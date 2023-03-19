//
//  GameDAO.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 13/03/2023.
//

import Foundation
import SwiftUI

class GameDAO : DAO<Game>{
        
//    public func createGame() async {
//        
//        let mydata = Game(id: nil, name: "UUUUUNO", type: "famille", picture: "")
//        
//        let encoded = try! JSONEncoder().encode(mydata)
//        
//        var request = URLRequest(url: URL(string:"https://us-central1-projetwebig4-back.cloudfunctions.net/app/api/v1/games")!)
//        
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        
//        request.httpMethod = "POST"
//        
//        let (data, response) = try! await URLSession.shared.upload(for: request, from: encoded)
//
//        let httpresponse = response as! HTTPURLResponse // le bon type
//        if httpresponse.statusCode == 201{ // tout s'est bien passé
//            print(data)
////            guard let decoded : DTO = await JSONHelper.decode(data: data) else { // utilisation de notre décodeur
////                return // mauvaise récupération de données
////            }
//        // conversion éventuelle du DTO decoded en instance Model
//        }
//        else{
//            print("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))") // print à éviter dans une app !
//        }
//    }
    
}
