//
// Created by Lorenzo Italiano on 25/03/2023.
//

import Foundation

class FestivalCreation: ObservableObject, Hashable, Equatable, Codable {

    static func == (lhs: FestivalCreation, rhs: FestivalCreation) -> Bool {
        return lhs.name == rhs.name && lhs.year == rhs.year && lhs.day == rhs.day
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(day)
    }

    @Published var name : String
    @Published var year : Int
    @Published var day: FestivalDay

    init(name: String, year: Int, day: FestivalDay) {
        self.name = name
        self.year = year
        self.day = day
    }

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case year = "year"
        case day = "day"
    }

    required init(from decoder: Decoder) throws {

        let nameContainer = try decoder.container(keyedBy: CodingKeys.self)
        name = try nameContainer.decode(String.self, forKey: .name)

        let yearContainer = try decoder.container(keyedBy: CodingKeys.self)
        year = try yearContainer.decode(Int.self, forKey: .year)

        let dayListContainer = try decoder.container(keyedBy: CodingKeys.self)
        day = try dayListContainer.decode(FestivalDay.self, forKey: .day)

    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(year, forKey: .year)
        try container.encode(day, forKey: .day)
    }

}
