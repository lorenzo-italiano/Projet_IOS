//
//  GameIntentError.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 09/03/2023.
//

import Foundation

struct GameIntentError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
