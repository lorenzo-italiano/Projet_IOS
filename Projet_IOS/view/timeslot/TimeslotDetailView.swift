//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation
import SwiftUI

struct TimeslotDetailView: View {

    @ObservedObject private var timeslot: Timeslot

    init(timeslot: Timeslot){
        self.timeslot = timeslot
    }

    var body: some View {
        Text(timeslot.startDate)
//        Spacer()
//        AsyncImage(url: URL(string: game.picture),content: { image in
//            image.resizable()
//                    .frame(width: 350, height: 350)
//        },
//                placeholder: {
//                    ProgressView()
//                })
//
//        HStack{
//            Text("Nom du jeu: ")
//            Spacer()
//            TextField("Nom du jeu", text: $game.name )
//        }
//                .padding(20)
//        HStack{
//            Text("Type du jeu: ")
//            Spacer()
//            Text(game.type)
//        }
//                .padding(20)
//
//        Spacer()
    }

}