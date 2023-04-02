//
// Created by Lorenzo Italiano on 30/03/2023.
//

import Foundation
import SwiftUI

struct FestivalModificationView: View {

    @ObservedObject private var festival: Festival
    @State private var intent : FestivalIntent

    @Binding private var showingPopover: Bool

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @State private var showingDayPopover: Bool = false
    @State private var showingZonePopover: Bool = false

    @State private var name: String
    @State private var year: Int

    init(festival: Festival, showingPopOver: Binding<Bool>) {
        self.festival = festival
        self.name = festival.name
        self.year = festival.year
        self._showingPopover = showingPopOver
        self.intent = FestivalIntent(model: self._festival.wrappedValue)
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Nom")) {
                    TextField("name", text: $name, prompt: Text("Nom du festival"))
                            .autocapitalization(.none)
                            .padding(.all)
                }
                Section(header: Text("Année")) {
                    TextField("year", value: $year, formatter: NumberFormatter(), prompt: Text("Année du festival"))
                            .autocapitalization(.none)
                            .padding(.all)
                }

                Section{
                    Button("Modifier"){
                        Task{
                            do {
                                festival.name = name
                                festival.year = year
                                try await self.intent.updateFestival(festival: festival)
                                showingPopover = false
                            }
                            catch RequestError.serverError {
                                showingAlert = true
                                alertMessage = RequestError.serverError.description
                            }
                            catch RequestError.unauthorized {
                                showingAlert = true
                                alertMessage = RequestError.unauthorized.description
                            }
                            catch RequestError.alreadyExists {
                                showingAlert = true
                                alertMessage = RequestError.alreadyExists.description
                            }
                            catch RequestError.badRequest {
                                showingAlert = true
                                alertMessage = RequestError.badRequest.description
                            }
                        }
                    }
                }


            }



            VStack{
                Text("Ce festival n'est pas actif")
                Button("Ouvrir le festival") {
                    Task{
                        do{
                            try await self.intent.openFestival(festival: festival)
                            festival.isActive = true
                            showingAlert = true
                            alertMessage = "Vous avez ouvert ce festival avec succès !"
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
            }.isVisible(!festival.isActive)

            VStack{
                Text("Ce festival est actif")
                Button("Clôturer le festival") {
                    Task{
                        do{
                            try await self.intent.closeFestival(festival: festival)
                            festival.isActive = false
                            showingAlert = true
                            alertMessage = "Vous avez clôturé ce festival avec succès !"
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
            }.isVisible(festival.isActive)

            Button("Ajouter une journée") {
                showingDayPopover = true
            }
                    .buttonStyle(.borderedProminent)


            Button("Ajouter une zone") {
                showingZonePopover = true
            }
                    .buttonStyle(.borderedProminent)

        }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                    }
                }

                .popover(isPresented: $showingDayPopover, content: {
                    FestivalCreateDayView(festival: festival, showingPopOver: $showingDayPopover)
                })
                .popover(isPresented: $showingZonePopover, content: {
                    FestivalCreateZoneView(festival: festival, showingPopOver: $showingZonePopover)
                })
    }
}
