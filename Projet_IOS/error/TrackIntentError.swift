//
// Created by Lorenzo Italiano on 16/02/2023.
//

import Foundation

struct TrackIntentError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}

