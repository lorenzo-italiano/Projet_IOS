//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation

class Zone: ObservableObject, Hashable, Equatable, Codable {

    static func == (lhs: Zone, rhs: Zone) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.nbVolunteers == rhs.nbVolunteers
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    @Published var id : String?
    @Published var name : String
    @Published var nbVolunteers : Int
    @Published var timeslotList : [TimeslotVolunteerAssociation]

    init(id: String?, name: String, nbVolunteers: Int, timeslotList: [TimeslotVolunteerAssociation]) {
        self.id = id
        self.name = name
        self.nbVolunteers = nbVolunteers
        self.timeslotList = timeslotList
    }

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case nbVolunteers = "nbVolunteers"
        case timeslotList = "timeslotList"
    }

    required init(from decoder: Decoder) throws {

        let idContainer = try decoder.container(keyedBy: CodingKeys.self)
        id = try idContainer.decode(String.self, forKey: .id)

        let nameContainer = try decoder.container(keyedBy: CodingKeys.self)
        name = try nameContainer.decode(String.self, forKey: .name)

        let nbVolunteersContainer = try decoder.container(keyedBy: CodingKeys.self)
        nbVolunteers = try nbVolunteersContainer.decode(Int.self, forKey: .nbVolunteers)

        let timeslotListContainer = try decoder.container(keyedBy: CodingKeys.self)
        timeslotList = try timeslotListContainer.decode([TimeslotVolunteerAssociation].self, forKey: .timeslotList)
    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(nbVolunteers, forKey: .nbVolunteers)
        try container.encode(timeslotList, forKey: .timeslotList)
    }

}
