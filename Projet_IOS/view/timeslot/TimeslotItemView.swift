//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation
import SwiftUI

struct TimeslotItemView: View {

    @ObservedObject private var timeslot: Timeslot

    private func getFormattedStringFromDate(dateISO: String) -> String{
//        let arr = dateISO.componentsSeparatedByString("")
        let arr = dateISO.components(separatedBy: "-")
        
        let year = arr[0]
        let month = arr[1]

        let arr2 = arr[2].components(separatedBy: "T")
        
        let day = arr2[0]
        
        let arr3 = arr2[1].components(separatedBy: ":")
        
        let hour = arr3[0]
        let minutes = arr3[1]

        return day + " " + month + " " + year + ", " + hour + ":" + minutes
    }

    init(timeslot: Timeslot){
        self.timeslot = timeslot
    }

    var body: some View {
        VStack{
//            Text(getFormattedStringFromDate(dateISO: "2023-03-04T08:00:00.000Z"))
            Text(getFormattedStringFromDate(dateISO: timeslot.startDate))
            Text(getFormattedStringFromDate(dateISO: timeslot.endDate))
        }
    }
}
