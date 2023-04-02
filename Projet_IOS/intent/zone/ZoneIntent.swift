//
// Created by Lorenzo Italiano on 01/04/2023.
//

import Foundation
import SwiftUI

struct ZoneIntent {

    @ObservedObject private var model : Zone

    private var zoneDAO = ZoneDAO()

    init(model: Zone){
        self.model = model
    }

    func delete(zone: Zone, id: String) async throws -> Void {
        do{
            try await zoneDAO.delete(url: "/festivals", id: id, zone: zone)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }

    func getNbVolunteers(id: String) async throws -> String {
        do {
            return try await self.zoneDAO.getNbVolunteers(id: id)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
    }

    func getNbVolunteersInTimeslotInZone(timeslot: Timeslot, id: String) async throws -> String{
        do {
            return try await self.zoneDAO.getNbVolunteersInTimeslotInZone(timeslot: timeslot, id: id)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
    }

}
