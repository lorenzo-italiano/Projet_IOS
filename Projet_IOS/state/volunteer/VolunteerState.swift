//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

enum VolunteerState {
    case ready
    case empty
    case loading
    case loaded(Volunteer)
    case error(VolunteerIntentError)
}