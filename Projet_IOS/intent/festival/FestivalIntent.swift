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

    func removeUserFromTimeslot(timeslotId: String, userId: String) async throws {
        do {
            try await festivalDAO.removeUserFromTimeslot(timeslotId: timeslotId, userId: userId)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }



    func addTimeslotToZone(zoneId: String, timeslot: Timeslot) async throws {
        do {
            try await festivalDAO.addTimeslotToZone(zoneId: zoneId, timeslot: timeslot)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }

    func addUserToZoneToTimeslot(zone: Zone, timeslot: Timeslot) async throws {
        do {
            try await festivalDAO.addUserToZoneToTimeslot(zone: zone, timeslot: timeslot)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
        catch RequestError.badRequest{
            throw RequestError.badRequest
        }
    }

    func removeUserFromZoneInTimeslot(zone: Zone, timeslot: Timeslot) async throws {
        do {
            try await festivalDAO.removeUserFromZoneInTimeslot(zone: zone, timeslot: timeslot)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
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

    func openFestival(festival: Festival) async throws -> Void {
        do {
            try await festivalDAO.openFestival(festival: festival)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }

    func closeFestival(festival: Festival) async throws -> Void {
        do {
            try await festivalDAO.closeFestival(festival: festival)
        }
        catch RequestError.unauthorized{
            throw RequestError.unauthorized
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
    }

    public func getDayStartDate(festival: Festival, timeslot: Timeslot) async throws -> String {
        do {
            return try await festivalDAO.getDayStartDate(festival: festival, timeslot: timeslot)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
    }

    public func getDayEndDate(festival: Festival, timeslot: Timeslot) async throws -> String {
        do {
            return try await festivalDAO.getDayEndDate(festival: festival, timeslot: timeslot)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
        catch RequestError.unauthorized {
            throw RequestError.unauthorized
        }
        catch RequestError.alreadyExists {
            throw RequestError.alreadyExists
        }
        catch RequestError.badRequest {
            throw RequestError.badRequest
        }
    }

    public func updateFestival(festival: Festival) async throws {
        do {
            try await festivalDAO.updateWithPut(url: "/festivals", updatedObject: festival, id: festival.id!)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
        catch RequestError.unauthorized {
            throw RequestError.unauthorized
        }
        catch RequestError.alreadyExists {
            throw RequestError.alreadyExists
        }
        catch RequestError.badRequest {
            throw RequestError.badRequest
        }
    }

    public func getNbVolunteersInFestival(festival: Festival) async throws -> String {
        do {
            return try await festivalDAO.getNbVolunteersInFestival(festival: festival)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
    }

    public func getNbMissingVolunteersInZone(zone: Zone) async throws -> String {
        do {
            return try await festivalDAO.getNbMissingVolunteersInZone(zone: zone)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
    }

    public func getNbExtraVolunteersInZone(zone: Zone) async throws -> String {
        do {
            return try await festivalDAO.getNbExtraVolunteersInZone(zone: zone)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
    }

    public func getNbMissingVolunteersInTimeslot(zone: Zone, timeslot: TimeslotVolunteerAssociation) async throws -> String {
        do {
            return try await festivalDAO.getNbMissingVolunteersInTimeslot(zone: zone, timeslot: timeslot)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
    }

    public func deleteDay(date: Date) async throws {
        do {
            try await festivalDAO.deleteDay(date: date)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
        catch RequestError.unauthorized {
            throw RequestError.unauthorized
        }
    }

    public func getReassignableZones(id: String) async throws -> [Zone] {
        do {
            return try await self.festivalDAO.getReassignableZones(id: id)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
    }

    public func reassignVolunteerToTimeslotToZone(newZoneId: String, oldZoneId: String, oldTimeslotId: String, newTimeslot: String, volunteerId: String) async throws {
        do {
            try await self.festivalDAO.reassignVolunteerToTimeslotToZone(newZoneId: newZoneId, oldZoneId: oldZoneId, oldTimeslotId: oldTimeslotId, newTimeslot: newTimeslot, volunteerId: volunteerId)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
        catch RequestError.unauthorized {
            throw RequestError.unauthorized
        }
    }

}