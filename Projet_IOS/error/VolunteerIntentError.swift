//
//  VolunteerIntentError.swift
//  Projet_IOS
//
//  Created by m1 on 10/03/2023.
//

import Foundation

struct VolunteerIntentError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
