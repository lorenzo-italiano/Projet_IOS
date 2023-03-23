//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

class Festival: ObservableObject, Hashable, Equatable, Codable {

    static func == (lhs: Festival, rhs: Festival) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.year == rhs.year && lhs.isActive == rhs.isActive
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    @Published var id : String?
    @Published var name : String
    @Published var year : Int
    @Published var isActive : Bool
    @Published var zoneList : [String]
    @Published var timeslotList : [String]

    init(id: String?, name: String, year: Int, isActive: Bool, zoneList: [String], timeslotList: [String]) {
        self.id = id
        self.name = name
        self.year = year
        self.isActive = isActive
        self.zoneList = zoneList
        self.timeslotList = timeslotList
    }

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case year = "year"
        case isActive = "isActive"
        case zoneList = "zoneList"
        case timeslotList = "timeslotList"
    }

    required init(from decoder: Decoder) throws {

        let idContainer = try decoder.container(keyedBy: CodingKeys.self)
        id = try idContainer.decode(String.self, forKey: .id)

        let nameContainer = try decoder.container(keyedBy: CodingKeys.self)
        name = try nameContainer.decode(String.self, forKey: .name)

        let yearContainer = try decoder.container(keyedBy: CodingKeys.self)
        year = try yearContainer.decode(Int.self, forKey: .year)

        let isActiveContainer = try decoder.container(keyedBy: CodingKeys.self)
        isActive = try isActiveContainer.decode(Bool.self, forKey: .isActive)

        let zoneListContainer = try decoder.container(keyedBy: CodingKeys.self)
        zoneList = try zoneListContainer.decode([String].self, forKey: .zoneList)

        let timeslotListContainer = try decoder.container(keyedBy: CodingKeys.self)
        timeslotList = try timeslotListContainer.decode([String].self, forKey: .timeslotList)
    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(year, forKey: .year)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(zoneList, forKey: .zoneList)
        try container.encode(timeslotList, forKey: .timeslotList)
    }

}
