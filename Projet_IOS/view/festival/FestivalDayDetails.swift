//
// Created by Lorenzo Italiano on 25/03/2023.
//

import Foundation
import SwiftUI

struct FestivalDayDetails: View {

    @ObservedObject private var festival: Festival
    private var date: Date

    init(festival: Festival, date: Date){
        self.festival = festival
        self.date = date
    }

    private func getDayOfYear(date: Date) -> Int {

        let arr = date.description.components(separatedBy: "-")

        let month = Int(arr[1])!

        let arr2 = arr[2].components(separatedBy: " ")

        let day = Int(arr2[0])!

        return (31 * month) + day

    }

    private func getTimeslotList() -> Array<Timeslot> {

        var dayOfYearList : Array<Timeslot> = []

        for timeslot in festival.timeslotList {
            let dateTmp = Timeslot.stringToISODate(string: timeslot.startDate)!

            if(getDayOfYear(date: date) == getDayOfYear(date: dateTmp)){
                dayOfYearList.append(timeslot)
            }
        }

        return dayOfYearList
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

    private func formatDayShortString(date: Date) -> String{
        let tmpDate = formatDayString(date: date)
        let array = tmpDate.components(separatedBy: " ")
        return array[0] + " " + array[1] + " " + array[2]
    }

    var body: some View {
        VStack{
            Text(festival.name + " " + String(festival.year))
            Text("Journée du " + formatDayShortString(date: date))
        }
        NavigationStack {
            VStack{
                List {
                    ForEach(getTimeslotList(), id: \.self) { timeslot in
//                        NavigationLink(destination: Text("placeholder")){
//                            Text(formatDayString(date: Timeslot.stringToISODate(string: timeslot.startDate)!))
//                            Text(formatDayString(date: Timeslot.stringToISODate(string: timeslot.endDate)!))
//                        }
                        HStack{
                            Text(formatTimeslotString(startDate: Timeslot.stringToISODate(string: timeslot.startDate)!, endDate: Timeslot.stringToISODate(string: timeslot.endDate)!))
                            Spacer()
                            Button("Disponible"){
                                print("TODO")
                            }
                        }
                    }
//                            .onDelete {
//                                indexSet in
//                                for index in indexSet{
//                                    Task{
//                                        do{
//                                            try await self.intent.delete(id: self.gameList.gameList[index].id ?? "")
//                                            try await self.intent.load()
//                                            showingAlert = true
//                                            alertMessage = "Vous avez supprimé un jeu !"
//                                        }
//                                        catch RequestError.unauthorized{
//                                            showingAlert = true
//                                            alertMessage = RequestError.unauthorized.description
//                                        }
//                                        catch RequestError.serverError{
//                                            showingAlert = true
//                                            alertMessage = RequestError.serverError.description
//                                        }
//                                    }
//
//                                }
//                            }
                }
//                        .refreshable {
//                            Task{
//                                do{
//                                    try await self.intent.getAll()
//                                }
//                                catch RequestError.serverError{
//                                    showingAlert = true
//                                    alertMessage = RequestError.serverError.description
//                                }
//                            }
//                        }
            }
        }
    }
}
