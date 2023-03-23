//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

enum ZoneState {
    case ready
    case empty
    case loading
    case loaded([Zone])
    case error(ZoneIntentError)
}