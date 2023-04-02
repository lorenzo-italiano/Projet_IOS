//
//  UserIntent.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation

struct UserIntent {

    private var userDao = UserDAO()
    
    init() { }
    
    func login(email: String, password: String) async throws{
        do {
            try await userDao.login(email: email, password: password)
        }
        catch LoginError.userNotFound {
            throw LoginError.userNotFound
        }
        catch LoginError.wrongCredentials {
            throw LoginError.wrongCredentials
        }
        catch LoginError.serverError {
            throw LoginError.serverError
        }
        catch LoginError.unknown {
            throw LoginError.unknown
        }
    }

    func signup(name: String, surname: String, email: String, password: String, passwordRepeat: String) async throws {
        do {
            try await userDao.signup(name: name, surname: surname, email: email, password: password, passwordRepeat: passwordRepeat)
        }
        catch RequestError.badRequest{
            throw RequestError.badRequest
        }
        catch RequestError.serverError{
            throw RequestError.serverError
        }
        catch RequestError.alreadyExists{
            throw RequestError.alreadyExists
        }
        catch {
            throw RequestError.unknown
        }
    }

    public func forgottenPassword(email: String) async throws {
        do {
            try await userDao.forgottenPassword(email: email)
        }
        catch RequestError.serverError {
            throw RequestError.serverError
        }
    }
}
