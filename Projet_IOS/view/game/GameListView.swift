//
//  GameListView.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 09/03/2023.
//

import SwiftUI

struct GameListView: View {

    @ObservedObject public var gameList: GameList
    
    @State private var intent : GameListIntent
    
    init(gameList: GameList) {
        self.gameList = gameList
        self.intent = GameListIntent(model: self._gameList.wrappedValue)
    }

    var body: some View {
        VStack{
            if case .loading = gameList.state{
                ProgressView()
            }
            else{
                NavigationStack {
                    VStack{
                        List {
                            ForEach(gameList.gameList, id: \.self) { game in
                                NavigationLink(destination: GameDetailView(game: game)){
                                    GameItemView(game: game)
                                }
                            }
                            .onDelete {
                                indexSet in
                                gameList.gameList.remove(atOffsets: indexSet)
                            }
                            
                        }
                        .refreshable {
                            Task {
                                await self.intent.load()
                            }
                        }
                    }
                }
                .onAppear{
                    switch gameList.state{
                    case .empty:
                        Task{
                            await self.intent.load()
                        }
                    default:
                        break
                    }
                }
            }
        }
    }

}

