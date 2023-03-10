//
//  VolunteerDTO.swift
//  Projet_IOS
//
//  Created by m1 on 10/03/2023.
//

import Foundation

class VolunteerDTO: Decodable{

    private var ID : String
    private var email : String
    private var surname : String
    private var name : String
    private var profilePicture : String?
    private var password : String?
    private var isAdmin : Bool?

    init(ID: String, email: String, surname: String, name: String, profilePicture: String?, password: String?, isAdmin: Bool?) {
        self.ID = ID
        self.email = email
        self.surname = surname
        self.name = name
        self.profilePicture = profilePicture
        self.password = password
        self.isAdmin = isAdmin
        
    }

    private enum CodingKeys: String, CodingKey {
        case ID = "_id"
        case email = "email"
        case name = "name"
        case surname = "surname"
        case profilePicture = "profile_picture"
        case password = "password"
        case isAdmin = "isAdmin"
    }

    required init(from decoder: Decoder) throws {

        let IDContainer = try decoder.container(keyedBy: CodingKeys.self)
        ID = try IDContainer.decode(String.self, forKey: .ID)
        
        let emailContainer = try decoder.container(keyedBy: CodingKeys.self)
        email = try emailContainer.decode(String.self, forKey: .email)
        
        let nameContainer = try decoder.container(keyedBy: CodingKeys.self)
        name = try nameContainer.decode(String.self, forKey: .name)

        let surnameContainer = try decoder.container(keyedBy: CodingKeys.self)
        surname = try surnameContainer.decode(String.self, forKey: .surname)

        let profilePictureContainer = try decoder.container(keyedBy: CodingKeys.self)
        profilePicture = try profilePictureContainer.decodeIfPresent(String.self, forKey: .profilePicture)
        
        let passwordContainer = try decoder.container(keyedBy: CodingKeys.self)
        password = try passwordContainer.decodeIfPresent(String.self, forKey: .password)
        
        let isAdminContainer = try decoder.container(keyedBy: CodingKeys.self)
        isAdmin = try isAdminContainer.decodeIfPresent(Bool.self, forKey: .isAdmin)    }

    static public func dtoToArray(dtoArray: [VolunteerDTO]) -> [Volunteer] {

        var volunteerModelArray : [Volunteer] = []

        //print("array")
        //print(dtoArray)

        for volunteer in dtoArray{
            volunteerModelArray.append(Volunteer(id: volunteer.ID, name : volunteer.name, surname: volunteer.surname, profilePicture: volunteer.profilePicture, email: volunteer.email, password: volunteer.password, isAdmin: volunteer.isAdmin))
        }

        return volunteerModelArray
    }

}
