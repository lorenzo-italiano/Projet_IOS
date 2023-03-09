//
// Created by Lorenzo Italiano on 21/02/2023.
//

import Foundation
import SwiftUI

struct JsonHelper {

    // First method without Result and error handling
    static func loadFromFile(name:String, extensionName: String) -> [TrackDTO]? {
        if let fileURL = Bundle.main.url(forResource: name, withExtension: extensionName){ // paramètres de type String
            if let content = try? Data(contentsOf: fileURL) {
                // donnée de type Data (buffer d'octets)
                return decode(data: content)
            }
        }

        return nil
    }

    static func writeJSONToFile(data: Data, toUrl: URL) -> Result<String, JSONError>{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let json = try? encoder.encode(data)
        guard let jsonData = json else { return .failure(.JsonEncodingFailed)}
        try? jsonData.write(to: toUrl)
        return .success("Success !")
    }

//    static func loadFromFile(filename: String, ext: String) -> Result<Data, JSONError>{ // Data si succès, JSONError sinon
//        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
//            return .failure(.fileNotFound(filename+"."+ext))
//        }
//        guard let content = try? Data(contentsOf: fileURL) else {
//            return .failure(.JsonDecodingFailed)
//        }
//        return .success(content)
//    }


    static func decode(data: Data) -> [TrackDTO]? {
        let decoder = JSONDecoder() // création d'un décodeur

        print(data)

        if let decoded = try? decoder.decode([TrackDTO].self, from: data) { // si on a réussit à décoder
            return decoded
        }
        return nil
    }




    /*static func decode<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder() // création d'un décodeur
        if let decoded = try? decoder.decode([TrackViewModel].self, from: data) { // si on a réussit à décoder
            self.tracks = decoded
        }
        return JSONDecoder().decode(, from: data)
    }*/
}
