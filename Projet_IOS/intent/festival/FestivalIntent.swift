//
// Created by Lorenzo Italiano on 26/03/2023.
//

import Foundation
import SwiftUI

struct FestivalIntent {

    @ObservedObject private var model : Festival

    private var festivalDAO = FestivalDAO()

    init(model: Festival){
        self.model = model
    }

    // intent to load data from api
//    func getById(id: String) async throws -> Void {
//        model.state = .loading
//
//        do{
//            let data = try await volunteerDAO.getById(url: "/volunteers", id: id)
//            model.state = .loaded(data)
//        }
//        catch{
//            throw RequestError.serverError
//        }
//    }

    func addNewDay(id: String, day: FestivalDay) async throws {
        do {
            try await festivalDAO.addNewDay(id: id, day: day)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }

    func addNewZone(id: String, zone: Zone) async throws {
        do {
            try await festivalDAO.addNewZone(id: id, zone: zone)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }

    func addUserToTimeslot(timeslotId: String, userId: String) async throws {
        do {
            try await festivalDAO.addUserToTimeslot(timeslotId: timeslotId, userId: userId)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }

}