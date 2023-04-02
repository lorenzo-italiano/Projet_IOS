//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

class ZoneDAO: DAO<Zone> {

    public func delete(url: String, id: String, zone: Zone) async throws {
        let encoded = try! JSONEncoder().encode(zone)

        guard let url = URL(string: "https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1" + url + "/" + id + "/removeZone") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"

        let (_ , response) = try! await URLSession.shared.upload(for: request, from: encoded)

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

    public func getNbVolunteers(id: String) async throws -> String{
        let encoded = Data()

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/zones/" + id + "/nbVolunteers") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"

        let (data , response) = try! await URLSession.shared.upload(for: request, from: encoded)

        guard let resp = response as? HTTPURLResponse else {
            throw RequestError.serverError
        }

        if(resp.statusCode == 500){
            throw RequestError.serverError
        }

        return String(decoding: data, as: UTF8.self)
    }

    public func getNbVolunteersInTimeslotInZone(timeslot: Timeslot, id: String) async throws -> String {
        let encoded = try! JSONEncoder().encode(timeslot)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/zones/" + id + "/timeslotNbVolunteers") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"

        let (data , response) = try! await URLSession.shared.upload(for: request, from: encoded)

        guard let resp = response as? HTTPURLResponse else {
            throw RequestError.serverError
        }

        if(resp.statusCode == 500){
            throw RequestError.serverError
        }

        return String(decoding: data, as: UTF8.self)
    }
}
