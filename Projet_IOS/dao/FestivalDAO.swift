//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

class FestivalDAO: DAO<Festival> {

    public func addNewDay(id: String, day: FestivalDay) async throws {
        let encoded = try! JSONEncoder().encode(day)

        guard let url = URL(string:"https://us-central1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/add/day/" + id) else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"

        let (_, response) = try! await URLSession.shared.upload(for: request, from: encoded)

        guard let resp = response as? HTTPURLResponse else {
            throw RequestError.serverError
        }

        if(resp.statusCode == 401) {
            throw RequestError.unauthorized
        }
        else if(resp.statusCode == 500){
            throw RequestError.serverError
        }
    }

    public func addNewZone(id: String, zone: Zone) async throws {
        let encoded = try! JSONEncoder().encode(zone)

        guard let url = URL(string:"https://us-central1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/add/zone/" + id) else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"

        let (_, response) = try! await URLSession.shared.upload(for: request, from: encoded)

        guard let resp = response as? HTTPURLResponse else {
            throw RequestError.serverError
        }

        if(resp.statusCode == 401) {
            throw RequestError.unauthorized
        }
        else if(resp.statusCode == 500){
            throw RequestError.serverError
        }
    }
}
