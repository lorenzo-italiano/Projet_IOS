//
// Created by Lorenzo Italiano on 19/03/2023.
//

import Foundation

enum VolunteerListState {
    case ready
    case empty
    case loading
    case loaded([Volunteer])
    case error(VolunteerIntentError)
}