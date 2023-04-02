//
// Created by Lorenzo Italiano on 26/03/2023.
//

import Foundation
import SwiftUI

struct FestivalAddTimeslotToZone: View {

    @State private var intent : FestivalIntent = FestivalIntent(model: Festival(id: nil, name: "", year: 0, isActive: false, zoneList: [], timeslotList: []))
    @ObservedObject private var festival: Festival
    @ObservedObject private var zone: Zone

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @State private var selectedTimeslot: Timeslot = Timeslot(id: "", startDate: "", endDate: "", volunteerList: [])

    init(zone: Zone, festival: Festival){
        self.festival = festival
        self.zone = zone
        self.intent = FestivalIntent(model: self._festival.wrappedValue)
    }

    private func formatDayStringHours(date: Date) -> String {

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

    private func formatDayString(date: Date) -> String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date/Time Style
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none

        // Set Locale
        dateFormatter.locale = Locale(identifier: "fr")

        // Convert Date to String
        return dateFormatter.string(from: date) // 9 septembre 2020 à 12:27
    }

    private func formatTimeslotString(startDate: Date, endDate: Date) -> String {
        let startDateString = formatDayStringHours(date: startDate)
        let startHourString = startDateString.components(separatedBy: " ")

        let endDateString = formatDayStringHours(date: endDate)
        let endHourString = endDateString.components(separatedBy: " ")

        return startHourString[4] + " - " + endHourString[4]
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Ajouter un créneau").font(.title)
            Form {
                Section(header: Text("Jour:")) {
                    Picker("Créneau", selection: $selectedTimeslot) {
                        ForEach(festival.timeslotList, id: \.self) { timeslot in
                            Text(formatDayString(date: Timeslot.stringToISODate(string: timeslot.startDate)!) + " " + formatTimeslotString(startDate: Timeslot.stringToISODate(string: timeslot.startDate)!, endDate: Timeslot.stringToISODate(string: timeslot.endDate)!)).tag(timeslot)
                        }
                    }
                }

                Button("Ajouter") {
                    Task {
                        do {
                            try await self.intent.addTimeslotToZone(zoneId: zone.id!, timeslot: selectedTimeslot)
//                            try await self.intent.addNewDay(id: festival.id!, day: FestivalDay(startDate: Timeslot.dateToISOString(date: startDate), endDate: Timeslot.dateToISOString(date: endDate)))
                            showingAlert = true
                            alertMessage = "Vous avez ajouté une nouvelle zone !"
//                            tabSelection = 0
//                            try await self.intent.getAll()
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

