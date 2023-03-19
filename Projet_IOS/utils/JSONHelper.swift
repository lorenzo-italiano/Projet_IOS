//
// Created by Lorenzo Italiano on 21/02/2023.
//

import Foundation
import SwiftUI

struct JsonHelper {

    static func decodeGeneric<T: Decodable>(data: Data) -> [T] {
        let decoder = JSONDecoder() // création d'un décodeur

        //print(data)

        if let decoded = try? decoder.decode([T].self, from: data) { // si on a réussit à décoder
            return decoded
        }
        return []
    }

    static func encode<T: Encodable>(data: T) async -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(data)
    }

}
