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
    
    private var gameDAO = GameDAO()

    init(model: GameList){
        self.model = model
    }

    // intent to load data from api
    func load() async throws -> Void {
        model.state = .loading
        
        do{
            model.state = .loaded(try await gameDAO.getAll(url:"/games"))
        }
        catch{
            throw RequestError.serverError
        }

    }
    
    func delete(id: String) async throws -> Void {
        do{
            try await gameDAO.delete(url: "/games", id: id)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }
    
    func createGame() async throws -> Void{
        let mydata = Game(id: nil, name: "UUUUUNO", type: "famille", picture: "")

        do{
            try await gameDAO.create(url: "/games", newObject: mydata)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
        catch RequestError.badRequest{
            throw RequestError.badRequest
        }
    }
}
