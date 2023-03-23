//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

enum TimeslotState {
    case ready
    case empty
    case loading
    case loaded([Timeslot])
//    case error(VolunteerIntentError)
}