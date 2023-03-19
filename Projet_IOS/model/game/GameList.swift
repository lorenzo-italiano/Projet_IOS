//
//  GameList.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 09/03/2023.
//

import SwiftUI

class GameList: ObservableObject {

    @Published var gameList: [Game]
    
    @Published public var state : GameState = .empty {
        didSet{
            if case .loaded(let data) = state {
                gameList = data
                state = .ready
            }
        }
    }

    init(gameList: [Game]) {
        self.gameList = gameList
    }
    
    init(){
        self.gameList = [Game]()
    }

}
