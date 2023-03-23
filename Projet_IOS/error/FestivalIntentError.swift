//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

struct FestivalIntentError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}