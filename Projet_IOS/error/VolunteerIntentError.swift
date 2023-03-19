//
// Created by Lorenzo Italiano on 19/03/2023.
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
