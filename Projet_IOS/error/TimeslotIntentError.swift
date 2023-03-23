//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

struct TimeslotIntentError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
