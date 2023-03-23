//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation
import SwiftUI

class FestivalListIntent {

    @ObservedObject private var model : FestivalList

    private var festivalDAO = FestivalDAO()

    init(model: FestivalList){
        self.model = model
    }

    // intent to load data from api
    func getAll() async throws -> Void {
        model.state = .loading

        do{
            model.state = .loaded(try await festivalDAO.getAll(url:"/festivals"))
        }
        catch{
            throw RequestError.serverError
        }
    }

    func delete(id: String) async throws -> Void {
        do{
            try await festivalDAO.delete(url: "/festivals", id: id)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }
}
