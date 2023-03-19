//
//  GameState.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 09/03/2023.
//

import Foundation

enum GameState {
    case ready
    case empty
    case loading
    case loaded([Game])
    case error(GameIntentError)
}
