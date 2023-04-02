//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

class FestivalDAO: DAO<Festival> {

    public func addNewDay(id: String, day: FestivalDay) async throws {
        let encoded = try! JSONEncoder().encode(day)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/add/day/" + id) else {
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

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/add/zone/" + id) else {
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

    public func addUserToTimeslot(timeslotId: String, userId: String) async throws {
        let volunteer: Volunteer = Volunteer(id: userId, email: "", surname: "", name: "", profilePicture: "", password: "", isAdmin: false)
        let encoded = try! JSONEncoder().encode(volunteer)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/timeslots/" + timeslotId + "/assign/") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"

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

    public func removeUserFromTimeslot(timeslotId: String, userId: String) async throws {
        let volunteer: Volunteer = Volunteer(id: userId, email: "", surname: "", name: "", profilePicture: "", password: "", isAdmin: false)
        let encoded = try! JSONEncoder().encode(volunteer)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/timeslots/" + timeslotId + "/removeVolunteer/") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"

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

    public func addTimeslotToZone(zoneId: String, timeslot: Timeslot) async throws {
        let encoded = try! JSONEncoder().encode(timeslot)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/zones/" + zoneId) else {
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

    public func addUserToZoneToTimeslot(zone: Zone, timeslot: Timeslot) async throws {
        let encoded = try! JSONEncoder().encode(timeslot)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/zones/" + zone.id! + "/assign") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"

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
        else if(resp.statusCode == 400){
            throw RequestError.badRequest
        }
    }

    public func removeUserFromZoneInTimeslot(zone: Zone, timeslot: Timeslot) async throws {
        let encoded = try! JSONEncoder().encode(timeslot)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/zones/" + zone.id! + "/removeVolunteer") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"

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

    public func openFestival(festival: Festival) async throws {
        let encoded: Data = Data()

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/" + festival.id! + "/open") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"

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

    public func closeFestival(festival: Festival) async throws {
        let encoded: Data = Data()

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/" + festival.id! + "/close") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"

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

    public func getDayStartDate(festival: Festival, timeslot: Timeslot) async throws -> String {
        let encoded = try! JSONEncoder().encode(timeslot)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/" + festival.id! + "/startOfDay") else {
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

    public func getDayEndDate(festival: Festival, timeslot: Timeslot) async throws -> String {
        let encoded = try! JSONEncoder().encode(timeslot)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/" + festival.id! + "/endOfDay") else {
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

    public func getNbVolunteersInFestival(festival: Festival) async throws -> String {
        let encoded = Data()

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/" + festival.id! + "/nbVolunteers") else {
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

    public func getNbMissingVolunteersInZone(zone: Zone) async throws -> String {
        let encoded = Data()

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/zones/" + zone.id! + "/missing") else {
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

    public func getNbExtraVolunteersInZone(zone: Zone) async throws -> String {
        let encoded = Data()

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/zones/" + zone.id! + "/extra") else {
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

    public func getNbMissingVolunteersInTimeslot(zone: Zone, timeslot: TimeslotVolunteerAssociation) async throws -> String {
        let encoded = try! JSONEncoder().encode(timeslot.timeslot)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/zones/" + zone.id! + "/timeslotMissing") else {
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

    public func deleteDay(date: Date) async throws {
        let timeslot = Timeslot(id: "", startDate: Timeslot.dateToISOString(date: date), endDate: Timeslot.dateToISOString(date: date), volunteerList: [])
        let encoded = try! JSONEncoder().encode(timeslot)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/festivals/deleteDay") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"

        let (data , response) = try! await URLSession.shared.upload(for: request, from: encoded)

        guard let resp = response as? HTTPURLResponse else {
            throw RequestError.serverError
        }

        if(resp.statusCode == 500){
            throw RequestError.serverError
        }
        if(resp.statusCode == 401){
            throw RequestError.unauthorized
        }
    }

    public func getReassignableZones(id: String) async throws -> [Zone] {
        let encoded = Data()

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/timeslots/" + id + "/reassignable") else {
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

        let decoder = JSONDecoder() // création d'un décodeur

        if let decoded = try? decoder.decode([Zone].self, from: data) {
            return decoded
        }

        return []
    }

    public func reassignVolunteerToTimeslotToZone(newZoneId: String, oldZoneId: String, oldTimeslotId: String, newTimeslot: String, volunteerId: String) async throws {
        let reassignObject = ReassignObject(oldZone: oldZoneId, oldTimeslot: oldTimeslotId, newTimeslot: newTimeslot, volunteer: volunteerId)
        let encoded = try! JSONEncoder().encode(reassignObject)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/zones/" + newZoneId + "/reassign") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"

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
