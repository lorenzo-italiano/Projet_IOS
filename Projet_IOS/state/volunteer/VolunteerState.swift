//
//  volunteerState.swift
//  Projet_IOS
//
//  Created by m1 on 10/03/2023.
//

import Foundation

enum VolunteerState : CustomStringConvertible{
    case ready
    case empty
    case loading
    case error(VolunteerIntentError)
    var description: String { "blabla" }
}
