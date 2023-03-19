//
//  UserIntent.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation

struct UserIntent {
    
    init(){
        
    }
    
    func login(email: String, password: String) async throws{
        do {
            try await UserDAO().login(email: email, password: password)
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
}
