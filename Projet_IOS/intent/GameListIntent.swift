//
//  GameListIntent.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 09/03/2023.
//

import SwiftUI
import Foundation

struct GameListIntent {
    @ObservedObject private var model : GameList

    init(model: GameList){
        self.model = model
    }

    // intent to load data from api
    func load() async -> Void {
        model.state = .loading
        do{
            let (data, _ ) = try await URLSession.shared.data(from: URL(string:"https://us-central1-projetwebig4-back.cloudfunctions.net/app/api/v1/games")!)
            model.gameList = JsonHelper.decodeGames(data: data)!
        }
        catch{
        // some error: invalid data?
        }
        model.state = .ready
    }


}
