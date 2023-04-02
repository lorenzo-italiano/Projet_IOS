//
// Created by Lorenzo Italiano on 26/03/2023.
//

import Foundation

import SwiftUI

struct FestivalCreateDayView: View {

    @State private var intent : FestivalIntent = FestivalIntent(model: Festival(id: nil, name: "", year: 0, isActive: false, zoneList: [], timeslotList: []))
    @ObservedObject private var festival: Festival

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @Binding private var showingPopover: Bool

    @State private var startDate = Date()
    @State private var endDate = Date()

    init(festival: Festival, showingPopOver: Binding<Bool>){
        self.festival = festival
        self._showingPopover = showingPopOver
        self.intent = FestivalIntent(model: self._festival.wrappedValue)
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Ajouter une journée").font(.title)
            Form {
                Section(header: Text("Jour:")) {
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

                Button("Ajouter") {
                    Task {
                        do {
                            try await self.intent.addNewDay(id: festival.id!, day: FestivalDay(startDate: Timeslot.dateToISOString(date: startDate), endDate: Timeslot.dateToISOString(date: endDate)))
//                            try await self.intent.getAll()
                            showingPopover = false

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
