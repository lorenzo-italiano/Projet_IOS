//
// Created by Lorenzo Italiano on 24/03/2023.
//

import Foundation

import SwiftUI

struct FestivalItemView: View{

    @ObservedObject private var festival: Festival

    init(festival: Festival){
        self.festival = festival
    }

    var body: some View {
        HStack{
            Text(festival.name)
            Text(String(festival.year))
        }
    }
}
