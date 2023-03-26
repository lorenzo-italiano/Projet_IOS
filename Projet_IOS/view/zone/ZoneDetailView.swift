//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation
import SwiftUI

struct ZoneDetailView: View {

    @ObservedObject private var zone: Zone

    init(zone: Zone){
        self.zone = zone
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
        Text(zone.name)




        ForEach(zone.timeslotList, id: \.self) { timeslotAssociation in
            Text(formatDayShortString(date: Timeslot.stringToISODate(string: timeslotAssociation.timeslot.startDate)!) + " " + formatTimeslotString(startDate: Timeslot.stringToISODate(string: timeslotAssociation.timeslot.startDate)!, endDate: Timeslot.stringToISODate(string: timeslotAssociation.timeslot.endDate)!))
            List{
                ForEach(timeslotAssociation.volunteerList, id: \.self) { volunteer in
                    Text(volunteer.name + " " + volunteer.surname)
                }
            }
        }

    }

}