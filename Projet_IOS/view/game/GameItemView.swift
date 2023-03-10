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
        HStack{
            Text(game.name)
            Spacer()
            AsyncImage(url: URL(string: game.picture),content: { image in
                image.resizable()
                     .frame(width: 80, height: 80)
            },
            placeholder: {
                ProgressView()
            })
        }
        
    }
}

struct Previews_GameItemView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
