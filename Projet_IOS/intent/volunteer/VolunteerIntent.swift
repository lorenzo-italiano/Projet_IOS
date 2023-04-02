//
//  VolunteerIntent.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation
import SwiftUI

struct VolunteerIntent {

    @ObservedObject private var model : Volunteer

    private var volunteerDAO = VolunteerDAO()

    init(model: Volunteer){
        self.model = model
    }

    // intent to load data from api
    func getById(id: String) async throws -> Void {
        model.state = .loading

        do{
            let data = try await volunteerDAO.getById(url: "/volunteers", id: id)
            model.state = .loaded(data)
        }
        catch{
            throw RequestError.serverError
        }
    }

    func changePassword(id: String, passwordObject: PasswordChangeObject) async throws {
        do {
            try await volunteerDAO.changePassword(id: id, passwordObject: passwordObject)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
        catch RequestError.badRequest {
            throw RequestError.badRequest
        }
        catch RequestError.unauthorized {
            throw RequestError.unauthorized
        }
        catch RequestError.unknown {
            throw RequestError.unknown
        }
    }
    
}
