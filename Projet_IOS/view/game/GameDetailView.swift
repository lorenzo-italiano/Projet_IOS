//
//  GameDetailView.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 09/03/2023.
//

import SwiftUI

struct GameDetailView: View {

    @ObservedObject private var game: Game

    init(game: Game){
        self.game = game
    }


    var body: some View {
        Spacer()
        AsyncImage(url: URL(string: game.picture),content: { image in
            image.resizable()
                 .frame(width: 350, height: 350)
        },
        placeholder: {
            ProgressView()
        })
        
        HStack{
            Text("Nom du jeu: ")
            Spacer()
            TextField("Nom du jeu", text: $game.name )
        }
        .padding(20)
        HStack{
            Text("Type du jeu: ")
            Spacer()
            Text(game.type)
        }
        .padding(20)
        
        Spacer()
    }

}
