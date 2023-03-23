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

    var body: some View {
        Text(festival.name)
    }

}