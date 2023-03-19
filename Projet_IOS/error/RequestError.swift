//
//  RequestError.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 18/03/2023.
//

import Foundation

enum RequestError : Error, CustomStringConvertible {
    case unauthorized
    case badRequest
    case serverError
    case alreadyExists
    case unknown
    
    var description : String {
        switch self {
        case .unauthorized: return "Vous n'avez pas la permission d'effectuer cette action"
        case .badRequest: return "Votre requête est incorrecte, vérifiez les informations entrées"
        case .serverError: return "Erreur interne, veuillez réessayer plus tard"
        case .alreadyExists: return "Cet élément existe déjà !"
        case .unknown: return "Erreur inconnue"
//            case .fileNotFound(let filename): return "File \(filename) not found"
//        case .JsonDecodingFailed: return "JSON decoding failed"
//        case .JsonEncodingFailed: return "JSON encoding failed"
//        case .initDataFailed: return "Bad data format: initialization of data failed"
//        case .unknown: return "unknown error"
        }
    }
}
