//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation
import SwiftUI

struct TimeslotListIntent {

    @ObservedObject private var model : TimeslotList

    private var timeslotDAO = TimeslotDAO()

    init(model: TimeslotList){
        self.model = model
    }

    // intent to load data from api
    func load() async throws -> Void {
        model.state = .loading

        do{
            model.state = .loaded(try await timeslotDAO.getAll(url:"/timeslots"))
        }
        catch{
            throw RequestError.serverError
        }

    }

    func delete(id: String) async throws -> Void {
        do{
            try await timeslotDAO.delete(url: "/timeslots", id: id)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }

//    func createGame() async throws -> Void{
//        let mydata = Game(id: nil, name: "UUUUUNO", type: "famille", picture: "")
//
//        do{
//            try await gameDAO.create(url: "/games", newObject: mydata)
//        }
//        catch RequestError.unauthorized{
//            throw RequestError.unauthorized
//        }
//        catch RequestError.serverError{
//            throw RequestError.serverError
//        }
//        catch RequestError.badRequest{
//            throw RequestError.badRequest
//        }
//    }
}
