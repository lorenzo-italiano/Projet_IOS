//
//  GameList.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 09/03/2023.
//

import SwiftUI

class GameList: ObservableObject {

    @Published public var gameList: [Game]{
        didSet{
            state = .ready
        }
    }
    
    @Published var state : GameState = .empty

    init(gameList: [Game]) {
        self.gameList = gameList
    }
    
    init(){
        self.gameList = [Game]()
    }

}
