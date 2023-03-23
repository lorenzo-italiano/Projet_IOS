//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

enum FestivalState {
    case ready
    case empty
    case loading
    case loaded([Festival])
    case error(FestivalIntentError)
}
