//
// Created by Lorenzo Italiano on 02/04/2023.
//

import Foundation
import SwiftUI

class NbVolunteerInTimeslotList: ObservableObject {

    @Published var values = [String]()

    init() {
        values = Array(repeating: "", count: 20)
    }

}
