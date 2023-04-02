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
    
    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    
    init(gameList: GameList) {
        self.gameList = gameList
        self.intent = GameListIntent(model: self._gameList.wrappedValue)
    }

    var body: some View {
        VStack{
            if case .loading = gameList.state {
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
                                for index in indexSet{
                                    Task{
                                        do{
                                            try await self.intent.delete(id: self.gameList.gameList[index].id ?? "")
                                            try await self.intent.load()
                                            showingAlert = true
                                            alertMessage = "Vous avez supprimé un jeu !"
                                        }
                                        catch RequestError.unauthorized{
                                            showingAlert = true
                                            alertMessage = RequestError.unauthorized.description
                                        }
                                        catch RequestError.serverError{
                                            showingAlert = true
                                            alertMessage = RequestError.serverError.description
                                        }
                                    }
                                    
                                }
//                                gameList.gameList.index(gameList.gameList.startIndex, offsetBy: indexSet)
//                                gameList.gameList.remove(atOffsets: indexSet)
                            }
                            
                        }
                        .refreshable {
                            Task{
                                do{
                                    try await self.intent.load()
                                }
                                catch RequestError.serverError{
                                    showingAlert = true
                                    alertMessage = RequestError.serverError.description
                                }
                            }
                        }
                        Button("Create Game"){
                            Task{
                                do{
                                    try await self.intent.createGame()
                                    try await self.intent.load()
                                    showingAlert = true
                                    alertMessage = "Vous avez créé un nouveau jeu !"
                                }
                                catch RequestError.unauthorized{
                                    showingAlert = true
                                    alertMessage = RequestError.unauthorized.description
                                }
                                catch RequestError.serverError{
                                    showingAlert = true
                                    alertMessage = RequestError.serverError.description
                                }
                                catch RequestError.alreadyExists{
                                    showingAlert = true
                                    alertMessage = RequestError.alreadyExists.description
                                }
                                catch RequestError.badRequest{
                                    showingAlert = true
                                    alertMessage = RequestError.badRequest.description
                                }
                            }
                        }
                    }
                }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .onAppear{
                    if case .empty = gameList.state{
                        Task{
                            do{
                                try await self.intent.load()
                            }
                            catch RequestError.serverError{
                                showingAlert = true
                                alertMessage = RequestError.serverError.description
                            }
                        }
                    }
                }
            }
        }
    }

}

