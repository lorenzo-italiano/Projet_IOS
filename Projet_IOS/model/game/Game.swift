//
// Created by Lorenzo Italiano on 02/03/2023.
//

import Foundation

class Game: Decodable, ObservableObject, Hashable, Equatable {
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.type == rhs.type && lhs.picture == rhs.picture
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private var id : String
    @Published var name : String
    @Published var type : String
    @Published var picture : String


    init(id: String, name: String, type: String, picture: String) {
        self.id = id
        self.name = name
        self.type = type
        self.picture = picture
    }

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case type = "type"
        case picture = "picture"
    }

    required init(from decoder: Decoder) throws {

        let idContainer = try decoder.container(keyedBy: CodingKeys.self)
        id = try idContainer.decode(String.self, forKey: .id)
        
        let nameContainer = try decoder.container(keyedBy: CodingKeys.self)
        name = try nameContainer.decode(String.self, forKey: .name)

        let typeContainer = try decoder.container(keyedBy: CodingKeys.self)
        type = try typeContainer.decode(String.self, forKey: .type)

        let pictureContainer = try decoder.container(keyedBy: CodingKeys.self)
        picture = try pictureContainer.decode(String.self, forKey: .picture)
    }

}
