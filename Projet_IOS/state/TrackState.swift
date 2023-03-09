//
// Created by Lorenzo Italiano on 16/02/2023.
//

import Foundation

enum TrackState : CustomStringConvertible{
    case ready
    case changingName(String)
    case error(TrackIntentError)
    var description: String { "bla" }
}

