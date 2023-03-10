//
//  VolunteerModel.swift
//  Projet_IOS
//
//  Created by m1 on 10/03/2023.
//

import Foundation

class Volunteer: ObservableObject, Hashable, Equatable {
    
    static func == (lhs: Volunteer, rhs: Volunteer) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.surname == rhs.surname && lhs.profilePicture == rhs.profilePicture && lhs.password == rhs.password && lhs.isAdmin == rhs.isAdmin && lhs.email == rhs.email
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private var id : String
    @Published var name : String
    @Published var surname : String
    @Published var email : String
    @Published var profilePicture : String?
    @Published var password : String?
    @Published var isAdmin : Bool?


    init(id: String, name: String, surname : String, profilePicture: String?, email: String, password : String?, isAdmin: Bool?) {
        self.id = id
        self.name = name
        self.surname = surname
        self.profilePicture = profilePicture
        self.email = email
        self.password = password
        self.isAdmin = isAdmin
    }

}
