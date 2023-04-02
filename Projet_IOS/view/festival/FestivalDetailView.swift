//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation
import SwiftUI

struct FestivalDetailView: View {

    @ObservedObject private var festival: Festival

    @AppStorage("token") var token: String = ""

    @State private var intent : FestivalIntent

    @State private var showingPopover: Bool = false

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @State private var showDeleteAlert = false
    @State private var deleteAlertMessage: String = "Voulez vous supprimer ce festival ? Attention cette action est irréversible"

    @State private var nbVolunteers: String = ""

    init(festival: Festival){
        self.festival = festival
        self.intent = FestivalIntent(model: self._festival.wrappedValue)
    }
    
    private func getDayOfYear(date: Date) -> Int {
        
        let arr = date.description.components(separatedBy: "-")

        let month = Int(arr[1])!

        let arr2 = arr[2].components(separatedBy: " ")

        let day = Int(arr2[0])!

        return (31 * month) + day
        
    }

    private func computeNumberOfDays() -> String {
        
        var dayOfYearList : Array<Int> = []
        
        for timeslot in festival.timeslotList {
            let date = Timeslot.stringToISODate(string: timeslot.startDate)!
            let dayOfYear = getDayOfYear(date: date)
            if(!dayOfYearList.contains(dayOfYear)){
                dayOfYearList.append(dayOfYear)
            }
        }
        
        return String(dayOfYearList.count)
    }

    var body: some View {
        NavigationStack {
            VStack{
                Text(festival.name)
                        .font(.title)
                Text("Édition " + String(festival.year))
                        .font(.title)
            }

            Spacer()

            Text("Ce festival est actif").isVisible(festival.isActive)
            Text("Ce festival a été cloturé").isVisible(!festival.isActive)

            Text("Durée du festival: " + computeNumberOfDays() + " jours")
            Text("Nombre de bénévoles: " + nbVolunteers)
            NavigationLink {
                FestivalDayListView(festival: festival)
            } label: {
                Text("Emploi du temps")
            }
                    .buttonStyle(.borderedProminent)
            NavigationLink {
                ZoneListView(zoneList: ZoneList(zoneList: festival.zoneList), festival: festival)
            } label: {
                Text("Voir les zones")
            }
                    .buttonStyle(.borderedProminent)

            Spacer()

        }
        .onAppear{
            Task {
                do {
                    let nb = try await self.intent.getNbVolunteersInFestival(festival: festival)
                    nbVolunteers = nb
                }
                catch RequestError.serverError {
                    showingAlert = true
                    alertMessage = RequestError.serverError.description
                }
            }
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
                .toolbar{
                    ToolbarItemGroup {

                        Button {
                            showingPopover.toggle()
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }.isVisible(JWTDecoder.isUserAdmin(jwtToken: token) && !showingPopover)

                        Button {
                            showDeleteAlert = true
                        } label: {
                            Image(systemName: "xmark")
                        }.isVisible(JWTDecoder.isUserAdmin(jwtToken: token) && !showingPopover)


                    }
                }
        .confirmationDialog(deleteAlertMessage, isPresented: $showDeleteAlert) {
            Button("Ok") {
                Task{
                    do {
                        try await self.intent.delete(id: festival.id!)
                        showingAlert = true
                        alertMessage = "Vous avez supprimé un festival avec succès"
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
        .popover(isPresented: $showingPopover, content: {
            FestivalModificationView(festival: festival, showingPopOver: $showingPopover)
        })
    }

}
