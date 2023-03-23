//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation
import SwiftUI

struct ZoneListIntent {
    @ObservedObject private var model : ZoneList

    private var zoneDAO = ZoneDAO()

    init(model: ZoneList){
        self.model = model
    }

    // intent to load data from api
    func getAll() async throws -> Void {
        model.state = .loading

        do{
            model.state = .loaded(try await zoneDAO.getAll(url:"/zones"))
        }
        catch{
            throw RequestError.serverError
        }
    }

    func delete(id: String) async throws -> Void {
        do{
            try await zoneDAO.delete(url: "/zones", id: id)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }


}