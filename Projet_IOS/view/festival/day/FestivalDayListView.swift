//
// Created by Lorenzo Italiano on 25/03/2023.
//

import Foundation
import SwiftUI

struct FestivalDayListView: View {

    @ObservedObject private var festival: Festival

    @State private var intent : FestivalIntent

    @AppStorage("token") var token: String = ""

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    @State private var dayList: Array<Date> = []

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
    
    private func getDaysList() -> Array<Date> {
        
        var dayOfYearList : Array<Int> = []
        var dayDateList : Array<Date> = []
        
        for timeslot in festival.timeslotList {
            let date = Timeslot.stringToISODate(string: timeslot.startDate)!
            let dateDay = getDayOfYear(date: date)

            if(!dayOfYearList.contains(dateDay)){
                dayDateList.append(date)
                dayOfYearList.append(dateDay)
            }
        }

        dayList = dayDateList
        return dayDateList
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

    var body: some View {
        HStack{
            Text(festival.name)
            Text(String(festival.year))
        }
        NavigationStack {
            VStack {
                List {
                    ForEach(dayList, id: \.self) { day in
                        NavigationLink(destination: FestivalDayDetails(festival: festival, date: day)) {
                            Text(formatDayString(date: day))
                        }
                    }
                            .onDelete {
                                indexSet in
                                for index in indexSet{
                                    Task{
                                        do{
                                            try await self.intent.deleteDay(date: getDaysList()[index])
                                            showingAlert = true
                                            alertMessage = "Vous avez supprimé un jour de festival !"
                                            dayList.remove(atOffsets: indexSet)
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
                            }.deleteDisabled(!JWTDecoder.isUserAdmin(jwtToken: token))
                }
                        .alert(alertMessage, isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
                        }
            }
        }
                .onAppear {
                    getDaysList()
                }
    }
}
