//
//  DAO.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 16/03/2023.
//

import Foundation
import SwiftUI

class DAO<T: Codable> {
    
    @AppStorage("token") var token: String = ""
    
    init() { }
    
    public func create(url: String, newObject: T) async throws {
        
        let encoded = try! JSONEncoder().encode(newObject)
        
        guard let url = URL(string:"https://us-central1-projetwebig4-back.cloudfunctions.net/app/api/v1" + url) else {
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
        else if(resp.statusCode == 400){
            throw RequestError.badRequest
        }
        else if(resp.statusCode == 409){
            throw RequestError.alreadyExists
        }
        else if(resp.statusCode == 500){
            throw RequestError.serverError
        }
        
    }
    
    public func getAll(url: String) async throws -> [T] {
        do{
            let (data, _ ) = try await URLSession.shared.data(from: URL(string:"https://us-central1-projetwebig4-back.cloudfunctions.net/app/api/v1" + url)!)
            return JsonHelper.decodeGeneric(data: data)
        }
        catch{
            throw RequestError.serverError
        }
    }
    
    public func updateWithPut(url: String, updatedObject: T, id: String) async throws {
        
        let encoded = try! JSONEncoder().encode(updatedObject)
        
        guard let url = URL(string:"https://us-central1-projetwebig4-back.cloudfunctions.net/app/api/v1" + url + "/" + id) else {
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
        else if(resp.statusCode == 400){
            throw RequestError.badRequest
        }
        else if(resp.statusCode == 409){
            throw RequestError.alreadyExists
        }
        else if(resp.statusCode == 500){
            throw RequestError.serverError
        }
        
    }
    
    public func delete(url: String, id: String) async throws {
        
        guard let url = URL(string: "https://us-central1-projetwebig4-back.cloudfunctions.net/app/api/v1" + url + "/" + id) else {
            throw RequestError.serverError
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        
        let (_, response) = try! await URLSession.shared.data(for: request)
        
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
