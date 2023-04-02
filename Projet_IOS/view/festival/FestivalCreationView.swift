//
// Created by Lorenzo Italiano on 25/03/2023.
//

import Foundation

import SwiftUI

struct FestivalCreationView: View {

//    @EnvironmentObject private var tabController: TabController

    @State private var intent : FestivalListIntent = FestivalListIntent(model: FestivalList(festivalList: []))

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @State var name: String = ""
    @State var year: Int = 2023

    @State private var startDate = Date()
    @State private var endDate = Date()

    @State private var festivalDayList : [FestivalDay] = []

//    @Binding public var tabSelection: Int = 0

    init(intent: FestivalListIntent){
        self.intent = intent
    }

//    @ObservedObject private var festival: Festival

//    init(festival: Festival){
//        self.festival = festival
//    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Créer un festival").font(.title)
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

                Section(header: Text("Jour 1:")) {
                    DatePicker(
                            "Ouverture",
                            selection: $startDate,
                            displayedComponents: [.date, .hourAndMinute]
                    )
                    DatePicker(
                            "Fermeture",
                            selection: $endDate,
                            displayedComponents: [.date, .hourAndMinute]
                    )
                }

                Button("Créer") {
                    Task {
                        do {
                            let mydata = FestivalCreation(name: name, year: year, day: FestivalDay(startDate: Timeslot.dateToISOString(date: startDate), endDate: Timeslot.dateToISOString(date: endDate)))
                            try await self.intent.create(festival: mydata)
                            showingAlert = true
                            alertMessage = "Vous avez créé un nouveau festival !"
//                            tabSelection = 0
//                            tabController.open(.festivals)
                            try await self.intent.getAll()

                        } catch RequestError.unauthorized {
                            showingAlert = true
                            alertMessage = RequestError.unauthorized.description
                        } catch RequestError.serverError {
                            showingAlert = true
                            alertMessage = RequestError.serverError.description
                        } catch RequestError.alreadyExists {
                            showingAlert = true
                            alertMessage = RequestError.alreadyExists.description
                        } catch RequestError.badRequest {
                            showingAlert = true
                            alertMessage = RequestError.badRequest.description
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
