//
// Created by Lorenzo Italiano on 26/03/2023.
//

import Foundation
import SwiftUI

struct FestivalCreateZoneView: View {

    @State private var intent : FestivalIntent = FestivalIntent(model: Festival(id: nil, name: "", year: 0, isActive: false, zoneList: [], timeslotList: []))
    @ObservedObject private var festival: Festival

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @State private var name :String = ""
    @State private var nbVolunteers: Int = 10

    init(festival: Festival){
        self.festival = festival
        self.intent = FestivalIntent(model: self._festival.wrappedValue)
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Ajouter une zone").font(.title)
            Form {
                Section(header: Text("Nom")) {
                    TextField("name", text: $name, prompt: Text("Nom du festival"))
                            .autocapitalization(.none)
                            .padding(.all)
                }
                Section(header: Text("Nombre volontaires nécessaire")) {
                    TextField("nbVolunteers", value: $nbVolunteers, formatter: NumberFormatter(), prompt: Text("Nombre volontaires nécessaire"))
                            .autocapitalization(.none)
                            .padding(.all)
                }

                Button("Ajouter") {
                    Task {
                        do {
                            try await self.intent.addNewZone(id: festival.id!, zone: Zone(id: nil, name: name, nbVolunteers: nbVolunteers, timeslotList: []))
                            showingAlert = true
                            alertMessage = "Vous avez ajouté une nouvelle zone !"
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
                .padding(.all)
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                    }
                }
            }
        }
    }
}
