//
// Created by Lorenzo Italiano on 01/04/2023.
//

import Foundation
import SwiftUI

struct TimeslotAssociationDetailView: View {

    @AppStorage("token") var token: String = ""

    @ObservedObject private var timeslotVolunteer: TimeslotVolunteerAssociation
    @State private var intent: FestivalIntent = FestivalIntent(model: Festival(id: nil, name: "", year: 0, isActive: false, zoneList: [], timeslotList: []))

    @ObservedObject private var festival: Festival
    @ObservedObject private var zone: Zone

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @State private var capacity: String = ""
    @State private var currentNumber: String = ""

    @State private var nbMissingVolunteers: String = ""

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

    private func formatDayShortString(date: Date) -> String{
        let tmpDate = formatDayString(date: date)
        let array = tmpDate.components(separatedBy: " ")
        return array[0] + " " + array[1] + " " + array[2]
    }

    private func isUserAlreadyInTimeslotZone(timeslotAssociation: TimeslotVolunteerAssociation) -> Bool {
        if(token != "") {
            for volunteer in timeslotAssociation.volunteerList {
                if(volunteer.id == JWTDecoder.decode(jwtToken: token)["userId"]! as! String){
                    return true
                }
            }
        }
        return false
    }

    init(timeslotVolunteer: TimeslotVolunteerAssociation, festival: Festival, zone: Zone){
        self.timeslotVolunteer = timeslotVolunteer
        self.festival = festival
        self.zone = zone
        self.intent = FestivalIntent(model: self._festival.wrappedValue)
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text(formatDayShortString(date: Timeslot.stringToISODate(string: timeslotVolunteer.timeslot.startDate)!) + " " + formatTimeslotString(startDate: Timeslot.stringToISODate(string: timeslotVolunteer.timeslot.startDate)!, endDate: Timeslot.stringToISODate(string: timeslotVolunteer.timeslot.endDate)!))
                Text("il manque " + nbMissingVolunteers + " bénévoles dans ce créneau").isVisible(Int(nbMissingVolunteers) ?? 0 >= 0)
                Text("il y a " + String(abs(Int(nbMissingVolunteers) ?? 0)) + " bénévoles en trop dans ce créneau").isVisible(Int(nbMissingVolunteers) ?? 0 < 0)
                Text("il y a " + currentNumber + " / " + capacity + " personnes pour ce créneau")
                NavigationLink(destination: ReassignVolunteerView(zone: zone, festival: festival, timeslotVolunteer: timeslotVolunteer)){
                    Text("Réaffecter")
                }
                .buttonStyle(.borderedProminent)
                .isVisible(Int(nbMissingVolunteers) ?? 0 < 0 && JWTDecoder.isUserAdmin(jwtToken: token))

                List {
                    ForEach(timeslotVolunteer.volunteerList, id: \.self) { volunteer in
                        Text(volunteer.name + " " + volunteer.surname)
                    }
                }

                Button("S'inscrire à ce créneau") {
                    Task {
                        do {
                            try await self.intent.addUserToZoneToTimeslot(zone: zone, timeslot: timeslotVolunteer.timeslot)
                            showingAlert = true
                            alertMessage = "Vous vous êtes inscrit sur un créneau d'une zone !"
                        } catch RequestError.unauthorized {
                            showingAlert = true
                            alertMessage = RequestError.unauthorized.description
                        } catch RequestError.serverError {
                            showingAlert = true
                            alertMessage = RequestError.serverError.description
                        } catch RequestError.badRequest {
                            showingAlert = true
                            alertMessage = "Vous n'êtes pas indiqué disponible durant ce créneau, inscrivez vous disponible pour ce créneau avant de pouvoir vous inscrire dans une zone !"
                        }
                    }
                }
                        .isVisible((Int(nbMissingVolunteers) ?? 0 > 0 || JWTDecoder.isUserAdmin(jwtToken: token)) && token != "" && festival.isActive && !isUserAlreadyInTimeslotZone(timeslotAssociation: timeslotVolunteer))
                        .buttonStyle(.borderedProminent)
                        .padding()

                Button("Se désinscrire du créneau") {
                    Task {
                        do {
                            try await self.intent.removeUserFromZoneInTimeslot(zone: zone, timeslot: timeslotVolunteer.timeslot)
                            showingAlert = true
                            alertMessage = "Vous vous êtes désinscrit de ce créneau avec succès!"
                        } catch RequestError.unauthorized {
                            showingAlert = true
                            alertMessage = RequestError.unauthorized.description
                        } catch RequestError.serverError {
                            showingAlert = true
                            alertMessage = RequestError.serverError.description
                        }
                    }
                }
                        .isVisible(festival.isActive && isUserAlreadyInTimeslotZone(timeslotAssociation: timeslotVolunteer))
                        .buttonStyle(.borderedProminent)
                        .padding()

                        .alert(alertMessage, isPresented: $showingAlert) {
                            Button("OK", role: .cancel) {
                            }
                        }
            }
        }
                .onAppear{
                    Task {
                        do {
                            let nb = try await self.intent.getNbMissingVolunteersInTimeslot(zone: zone, timeslot: timeslotVolunteer)
                            nbMissingVolunteers = nb
                            let nbVolunteers = try await self.intent.getNbVolunteersTimeslot(id: timeslotVolunteer.timeslot.id)
                            currentNumber = nbVolunteers
                            let cap = try await self.intent.getMaxCapacityTimeslot(id: timeslotVolunteer.timeslot.id)
                            capacity = cap
                        }
                        catch RequestError.serverError{
                            showingAlert = true
                            alertMessage = RequestError.serverError.description
                        }
                    }
                }
    }
}
