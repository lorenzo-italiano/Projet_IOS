//
//  LoginError.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 15/03/2023.
//

import Foundation

enum LoginError : Error, CustomStringConvertible {
    case userNotFound
    case wrongCredentials
    case serverError
    case unknown
    
    var description : String {
        switch self {
        case .userNotFound: return "L'utilisateur n'existe pas"
        case .wrongCredentials: return "Mot de passe ou mail erroné"
        case .serverError: return "Erreur interne, veuillez réessayer plus tard"
        case .unknown: return "Erreur inconnue"
//            case .fileNotFound(let filename): return "File \(filename) not found"
//        case .JsonDecodingFailed: return "JSON decoding failed"
//        case .JsonEncodingFailed: return "JSON encoding failed"
//        case .initDataFailed: return "Bad data format: initialization of data failed"
//        case .unknown: return "unknown error"
        }
    }
}
