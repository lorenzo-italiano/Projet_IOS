//
//  GameState.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 09/03/2023.
//

import Foundation

enum GameState : CustomStringConvertible{
    case ready
    case empty
    case loading
    case error(GameIntentError)
    var description: String { "bla" }
}
