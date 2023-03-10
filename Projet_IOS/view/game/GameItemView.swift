//
//  GameItemView.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 09/03/2023.
//

import SwiftUI

struct GameItemView: View{

    @ObservedObject private var game: Game

    init(game: Game){
        self.game = game
    }

    var body: some View {
        Text(game.name)
    }
}
