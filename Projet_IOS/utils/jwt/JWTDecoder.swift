//
// Created by Lorenzo Italiano on 23/03/2023.
//

import Foundation

class JWTDecoder {

    static public func decode(jwtToken jwt: String) -> [String: Any] {
        let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }

    static public func isUserAdmin(jwtToken jwt: String) -> Bool {
        if(jwt == ""){
            return false
        }

        let segments = jwt.components(separatedBy: ".")
        let decoded = decodeJWTPart(segments[1]) ?? [:]

        guard let isAdmin = decoded["isAdmin"] else {
            return false
        }
        
        return isAdmin as! Bool

    }

    static private func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")

        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    static private func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
              let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
            return nil
        }

        return payload
    }

}
