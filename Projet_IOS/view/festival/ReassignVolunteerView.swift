//
// Created by Lorenzo Italiano on 02/04/2023.
//

import Foundation
import SwiftUI

struct ReassignVolunteerView: View {

    @AppStorage("token") var token: String = ""

    @ObservedObject private var zone: Zone
    @ObservedObject private var festival: Festival
    @ObservedObject private var timeslotVolunteer: TimeslotVolunteerAssociation
    @State private var intent: FestivalIntent = FestivalIntent(model: Festival(id: nil, name: "", year: 0, isActive: false, zoneList: [], timeslotList: []))

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @State private var selectedVolunteer: Volunteer = Volunteer()
    @State private var selectedZone: Zone = Zone(id: "", name: "", nbVolunteers: 0, timeslotList: [])

    @State private var zoneList: Array<Zone> = [Zone]()

    init(zone: Zone, festival: Festival, timeslotVolunteer: TimeslotVolunteerAssociation) {
        self.zone = zone
        self.festival = festival
        self.timeslotVolunteer = timeslotVolunteer
        self.intent = FestivalIntent(model: self._festival.wrappedValue)
    }

    var body: some View {
        VStack {
            Text("Réassigner un bénévole")
                    .font(.title)

            Form {
                Section(header: Text("Selection du bénévole a réassigner")){
                    Picker("Bénévole à réassigner", selection: $selectedVolunteer) {
                        ForEach(timeslotVolunteer.volunteerList, id: \.self) { volunteer in
                            Text(volunteer.name + " " + volunteer.surname)
                        }
                    }
                }

                Section {
                    Picker("Nouvelle assignation", selection: $selectedZone) {
                        ForEach(zoneList, id: \.self) { zone in
                            Text(zone.name)
                        }
                    }
                }

                Button("Valider"){
                    Task {
                        do {
                            try await self.intent.reassignVolunteerToTimeslotToZone(newZoneId: selectedZone.id!, oldZoneId: zone.id!, oldTimeslotId: timeslotVolunteer.timeslot.id, newTimeslot: timeslotVolunteer.timeslot.id, volunteerId: selectedVolunteer.id)
                            showingAlert = true
                            alertMessage = "Vous avez réassigné un utilisateur avec succès"
                        }
                        catch RequestError.unauthorized {
                            showingAlert = true
                            alertMessage = RequestError.unauthorized.description
                        }
                        catch RequestError.serverError {
                            showingAlert = true
                            alertMessage = RequestError.serverError.description
                        }
                    }
                }
                        .buttonStyle(.borderedProminent)
            }
        }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                    }
                }
                .onAppear {
                    Task{
                        do {
                            let res = try await self.intent.getReassignableZones(id: timeslotVolunteer.timeslot.id)
                            self.zoneList = res
                        }
                        catch RequestError.serverError {
                            showingAlert = true
                            alertMessage = RequestError.serverError.description
                        }
                    }
                }
    }
}
