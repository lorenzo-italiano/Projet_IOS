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

    var body: some View {
        Text(zone.name)
    }

}