//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation
import SwiftUI

struct ZoneDetailView: View {

    @ObservedObject private var zone: Zone
    @ObservedObject private var festival: Festival
    @State private var intent: FestivalIntent = FestivalIntent(model: Festival(id: nil, name: "", year: 0, isActive: false, zoneList: [], timeslotList: []))
    @State private var zoneIntent: ZoneIntent = ZoneIntent(model: Zone(id: "", name: "", nbVolunteers: 0, timeslotList: []))

    @AppStorage("token") var token: String = ""

    @State private var showDeleteAlert = false
    @State private var deleteAlertMessage: String = "Voulez vous supprimer cette zone ? Attention cette action est irréversible"

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @State private var nbExtraVolunteers: String = ""
    @State private var nbMissingVolunteers: String = ""

    @ObservedObject private var nbVolunteersInTimeslot: NbVolunteerInTimeslotList = NbVolunteerInTimeslotList()
//    @ObservedObject private var nbVolunteersInTimeslot: Array<String> = Array(repeating: "", count: 20)

    @State private var nbVolunteers: String = ""

    init(zone: Zone, festival: Festival) {
        self.zone = zone
        self.festival = festival
        self.intent = FestivalIntent(model: self._festival.wrappedValue)
        self.zoneIntent = ZoneIntent(model: self._zone.wrappedValue)
    }

    private func formatDayString(date: Date) -> String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date/Time Style
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        // Set Locale
        dateFormatter.locale = Locale(identifier: "fr")

        // Convert Date to String
        return dateFormatter.string(from: date) // 9 septembre 2020 à 12:27
    }

    private func formatTimeslotString(startDate: Date, endDate: Date) -> String {
        let startDateString = formatDayString(date: startDate)
        let startHourString = startDateString.components(separatedBy: " ")

        let endDateString = formatDayString(date: endDate)
        let endHourString = endDateString.components(separatedBy: " ")

        return startHourString[4] + " - " + endHourString[4]
    }

    private func formatDayShortString(date: Date) -> String {
        let tmpDate = formatDayString(date: date)
        let array = tmpDate.components(separatedBy: " ")
        return array[0] + " " + array[1] + " " + array[2]
    }

    private func getNbVolunteersInTimeslotInZone(timeslot: Timeslot) async -> String{
        // envoyer timeslot et id de la zone
        let res = await Task {
            do {
                return try await zoneIntent.getNbVolunteersInTimeslotInZone(timeslot: timeslot, id: zone.id!)
            }
            catch RequestError.serverError {
                showingAlert = true
                alertMessage = RequestError.serverError.description
            }
            return ""
        }.result

        do {
            return try res.get()
        } catch {
            showingAlert = true
            alertMessage = RequestError.serverError.description
        }
        return ""
    }

    private func getAllNbVolunteersInTimeslotZone() async {
        for timeslotList in zone.timeslotList {
            let nb = await getNbVolunteersInTimeslotInZone(timeslot: timeslotList.timeslot)
            nbVolunteersInTimeslot.values[zone.timeslotList.index(of: timeslotList) ?? 0] = nb
        }
    }


    var body: some View {
        VStack {
            Text(zone.name)
            Text("Bénévoles nécessaires par créneau: " + String(zone.nbVolunteers))
            Text("Il y a " + nbVolunteers + " bénévoles différents dans cette zone")
            Text("Il manque " + nbMissingVolunteers + " bénévoles à travers les créneaux")
            Text("Il y a " + nbExtraVolunteers + " bénévoles en trop à travers les créneaux")
            NavigationLink {
                FestivalAddTimeslotToZone(zone: zone, festival: festival)
            } label: {
                Text("Ajouter un créneau")
            }
                    .isVisible(festival.isActive && JWTDecoder.isUserAdmin(jwtToken: token))
                    .buttonStyle(.borderedProminent)

            Text("Liste des créneaux")
            List {
                ForEach(0..<zone.timeslotList.count) { timeslotId in
                    NavigationLink(destination: TimeslotAssociationDetailView(timeslotVolunteer: zone.timeslotList[timeslotId], festival: festival, zone: zone)) {
                        HStack {
                            Text(formatDayShortString(date: Timeslot.stringToISODate(string: zone.timeslotList[timeslotId].timeslot.startDate)!) + " " + formatTimeslotString(startDate: Timeslot.stringToISODate(string: zone.timeslotList[timeslotId].timeslot.startDate)!, endDate: Timeslot.stringToISODate(string: zone.timeslotList[timeslotId].timeslot.endDate)!))
                            Spacer()
                            Text(nbVolunteersInTimeslot.values[timeslotId] + " / " + String(zone.nbVolunteers))
                        }
                    }
                }
//                ForEach(zone.timeslotList, id: \.self) { timeslotAssociation in
//                    NavigationLink(destination: TimeslotAssociationDetailView(timeslotVolunteer: timeslotAssociation, festival: festival, zone: zone)) {
//                        HStack {
//                            Text(formatDayShortString(date: Timeslot.stringToISODate(string: timeslotAssociation.timeslot.startDate)!) + " " + formatTimeslotString(startDate: Timeslot.stringToISODate(string: timeslotAssociation.timeslot.startDate)!, endDate: Timeslot.stringToISODate(string: timeslotAssociation.timeslot.endDate)!))
//                            Spacer()
//                            Text(nbVolunteersInTimeslot[zone.timeslotList.firstIndex(of: timeslotAssociation)] + " / " + String(zone.nbVolunteers))
//                        }
//                    }
//                }
            }
        }
                .toolbar{
                    ToolbarItemGroup {

                        Button {
                            showDeleteAlert = true
                        } label: {
                            Image(systemName: "xmark")
                        }.isVisible(JWTDecoder.isUserAdmin(jwtToken: token))

                    }
                }
                .confirmationDialog(deleteAlertMessage, isPresented: $showDeleteAlert) {
                    Button("Ok") {
                        Task{
                            do {
                                try await self.zoneIntent.delete(zone: zone, id: festival.id!)
                                showingAlert = true
                                alertMessage = "Vous avez supprimé une zone du festival avec succès"
                            }
                            catch RequestError.unauthorized{
                                showingAlert = true
                                alertMessage = RequestError.unauthorized.description
                            }
                            catch RequestError.serverError{
                                showingAlert = true
                                alertMessage = RequestError.serverError.description
                            }
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text(deleteAlertMessage)
                }
                .onAppear{
                    Task{
                        do {
                            let nbMissing = try await self.intent.getNbMissingVolunteersInZone(zone: zone)
                            self.nbMissingVolunteers = nbMissing
                            let nbExtra = try await self.intent.getNbExtraVolunteersInZone(zone: zone)
                            self.nbExtraVolunteers = nbExtra
                            let nbVol = try await self.zoneIntent.getNbVolunteers(id: zone.id!)
                            self.nbVolunteers = nbVol
                            await getAllNbVolunteersInTimeslotZone()
                        }
                        catch RequestError.serverError{
                            showingAlert = true
                            alertMessage = RequestError.serverError.description
                        }
                    }

                }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                    }
                }
    }
}
