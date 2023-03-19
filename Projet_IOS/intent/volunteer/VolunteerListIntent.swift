//
// Created by Lorenzo Italiano on 19/03/2023.
//

import Foundation
import SwiftUI

struct VolunteerListIntent {
    @ObservedObject private var model : VolunteerList

    private var volunteerDAO = VolunteerDAO()

    init(model: VolunteerList){
        self.model = model
    }

    // intent to load data from api
    func getAll() async throws -> Void {
        model.state = .loading

        do{
            model.state = .loaded(try await volunteerDAO.getAll(url:"/volunteers"))
        }
        catch{
            throw RequestError.serverError
        }
    }

    func delete(id: String) async throws -> Void {
        do{
            try await volunteerDAO.delete(url: "/volunteers", id: id)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }


}
