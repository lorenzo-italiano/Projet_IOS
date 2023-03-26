//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation
import SwiftUI

struct FestivalDetailView: View {

    @ObservedObject private var festival: Festival

    init(festival: Festival){
        self.festival = festival
    }
    
    private func getDayOfYear(date: Date) -> Int {
        
        let arr = date.description.components(separatedBy: "-")

        let month = Int(arr[1])!

        let arr2 = arr[2].components(separatedBy: " ")

        let day = Int(arr2[0])!

        return (31 * month) + day
        
    }

    private func computeNumberOfDays() -> String {
        
        var dayOfYearList : Array<Int> = []
        
        for timeslot in festival.timeslotList {
            let date = Timeslot.stringToISODate(string: timeslot.startDate)!
            let dayOfYear = getDayOfYear(date: date)
            if(!dayOfYearList.contains(dayOfYear)){
                dayOfYearList.append(dayOfYear)
            }
        }
        
        return String(dayOfYearList.count)
    }

    var body: some View {
        VStack{
            Text(festival.name)
            Text("Édition " + String(festival.year))
            Text("Durée du festival: " + computeNumberOfDays() + " jours")
            NavigationLink {
                FestivalDayListView(festival: festival)
            } label: {
                Text("Emploi du temps")
            }
            .buttonStyle(.borderedProminent)
            NavigationLink {
                ZoneListView(zoneList: ZoneList(zoneList: festival.zoneList))
            } label: {
                Text("Voir les zones")
            }
            .buttonStyle(.borderedProminent)

            NavigationLink {
                FestivalCreateDayView(festival: festival)
            } label: {
                Text("Ajouter une journée")
            }
            .buttonStyle(.borderedProminent)

            NavigationLink {
                FestivalCreateZoneView(festival: festival)
            } label: {
                Text("Ajouter une zone")
            }
                    .buttonStyle(.borderedProminent)

        }
    }

}
