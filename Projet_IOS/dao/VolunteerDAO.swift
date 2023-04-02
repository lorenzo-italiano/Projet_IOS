//
// Created by Lorenzo Italiano on 19/03/2023.
//

import Foundation

class VolunteerDAO: DAO<Volunteer> {

    // Making the use of that method impossible because we can't create a volunteer like this, creating a volunteer
    // can only be done by a new user signing up on the app.
    @available(*, unavailable, message:"Can't create a volunteer with that method")
    override public func create(url: String, newObject: Volunteer) async throws {
        print("Not Supported")
    }

    func changePassword(id: String, passwordObject: PasswordChangeObject) async throws {
        let encoded = try! JSONEncoder().encode(passwordObject)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/volunteers/password/" + id) else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"

        let (_, response) = try! await URLSession.shared.upload(for: request, from: encoded)

        guard let resp = response as? HTTPURLResponse else {
            throw RequestError.serverError
        }

        if(resp.statusCode == 401) {
            throw RequestError.unauthorized
        }
        else if(resp.statusCode == 400){
            throw RequestError.badRequest
        }
        else if(resp.statusCode == 404){
            throw RequestError.unknown
        }
        else if(resp.statusCode == 500){
            throw RequestError.serverError
        }
    }

}
