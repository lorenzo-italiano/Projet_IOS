//
//  UserDAO.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation

class UserDAO {
    
    init() { }
    
    func login(email: String, password: String) async throws {
    
        let mydata = Login(email: email, password: password)
        
        let encoded = try! JSONEncoder().encode(mydata)
        
        var request = URLRequest(url: URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/auth/login/noencryption")!)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        let (data, response) = try! await URLSession.shared.upload(for: request, from: encoded)

        let httpresponse = response as! HTTPURLResponse // le bon type
        if (httpresponse.statusCode == 200) { // tout s'est bien passé
            UserDefaults.standard.set(try! JSONDecoder().decode(HttpLoginResponse.self, from: data).token, forKey: "token")
            print(try! JSONDecoder().decode(HttpLoginResponse.self, from: data).token)
//            guard let decoded : DTO = await JSONHelper.decode(data: data) else { // utilisation de notre décodeur
//                return // mauvaise récupération de données
//            }
        // conversion éventuelle du DTO decoded en instance Model
        }
        else if (httpresponse.statusCode == 404) {
            throw LoginError.userNotFound
        }
        else if (httpresponse.statusCode == 401) {
            throw LoginError.wrongCredentials
        }
        else if (httpresponse.statusCode == 500) {
            throw LoginError.serverError
        }
        else{
            throw LoginError.unknown
        }
    }

    func signup(name: String, surname: String, email: String, password: String, passwordRepeat: String) async throws {
        let mydata = SignUp(name: name, surname: surname, email: email, password: password, password_repeat: passwordRepeat)

        let encoded = try! JSONEncoder().encode(mydata)

        var request = URLRequest(url: URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/auth/sign-up")!)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"

        let (data, response) = try! await URLSession.shared.upload(for: request, from: encoded)

        let httpresponse = response as! HTTPURLResponse // le bon type
        if (httpresponse.statusCode == 201) { // tout s'est bien passé
//            UserDefaults.standard.set(try! JSONDecoder().decode(HttpLoginResponse.self, from: data).token, forKey: "token")
//            guard let decoded : DTO = await JSONHelper.decode(data: data) else { // utilisation de notre décodeur
//                return // mauvaise récupération de données
//            }
            // conversion éventuelle du DTO decoded en instance Model
        }
        else if (httpresponse.statusCode == 400) {
            // wrong credentials genre email mauvais format
            throw RequestError.badRequest
        }
        else if (httpresponse.statusCode == 409) {
            // Conflit ! l'utilisateur existe déjà (le mail est déjà utilisé)
            throw RequestError.alreadyExists
        }
        else if (httpresponse.statusCode == 500) {
            // Erreur serveur
            throw RequestError.serverError
        }
        else{
            throw RequestError.unknown
        }
    }

    public func forgottenPassword(email: String) async throws{
        let volunteer = Volunteer(id: "", email: email, surname: "", name: "", profilePicture: "", password: "", isAdmin: false)
        let encoded = try! JSONEncoder().encode(volunteer)

        guard let url = URL(string:"https://europe-west1-projetios-backend.cloudfunctions.net/app/api/v1/volunteers/forgotten") else {
            throw RequestError.serverError
        }

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"

        let (data, response) = try! await URLSession.shared.upload(for: request, from: encoded)

        guard let resp = response as? HTTPURLResponse else {
            throw RequestError.serverError
        }

        if(resp.statusCode == 500){
            throw RequestError.serverError
        }

    }
}
