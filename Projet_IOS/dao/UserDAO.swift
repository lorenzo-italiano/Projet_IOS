//
//  UserDAO.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation

//import CryptoSwift
//
//extension String {
//
//    func aesEncrypt(key: String, iv: String) throws -> String {
//        let data = self.data(using: .utf8)!
//        let encrypted = try! AES(key: key, iv: iv, padding: .pkcs7).encrypt([UInt8](data))
//        let encryptedData = Data(encrypted)
//        return encryptedData.toHexString()
//    }
//
//    func aesDecrypt(key: String, iv: String) throws -> String {
//        let data = self.dataFromHexadecimalString()!
//        let decrypted = try! AES(key: key, iv: iv, padding:.pkcs7).decrypt([UInt8](data))
//        let decryptedData = Data(decrypted)
//        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
//    }
//
//    func dataFromHexadecimalString() -> Data? {
//        var data = Data(capacity: count / 2)
//        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
//        regex.enumerateMatches(in: self, options: [], range: NSMakeRange(0, count)) { match, flags, stop in
//            let byteString = (self as NSString).substring(with: match!.range)
//            let num = UInt8(byteString, radix: 16)
//            data.append(num!)
//        }
//            return data
//    }
//
//}
//
//extension Data {
//
//    var bytes: Array<UInt8> {
//        return Array(self)
//    }
//
//    func toHexString() -> String {
//        return bytes.toHexString()
//    }
//
//}

class UserDAO {
    
    init(){
        
    }
    
//    func aesEncrypt(key: String, iv: String) -> String? {
//            guard
//                let data = self.data(using: .utf8),
//                let key = key.data(using: .utf8),
//                let iv = iv.data(using: .utf8),
//                let encrypt = data.encryptAES256(key: key, iv: iv)
//                else { return nil }
//            let base64Data = encrypt.base64EncodedData()
//            return String(data: base64Data, encoding: .utf8)
//        }
//
//        func aesDecrypt(key: String, iv: String) -> String? {
//            guard
//                let data = Data(base64Encoded: self),
//                let key = key.data(using: .utf8),
//                let iv = iv.data(using: .utf8),
//                let decrypt = data.decryptAES256(key: key, iv: iv)
//                else { return nil }
//            return String(data: decrypt, encoding: .utf8)
//        }
    
    func login(email: String, password: String) async throws {
    
        let mydata = Login(email: email, password: password)
        
        let encoded = try! JSONEncoder().encode(mydata)
        
        var request = URLRequest(url: URL(string:"https://us-central1-projetwebig4-back.cloudfunctions.net/app/api/v1/auth/login/noencryption")!)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        let (data, response) = try! await URLSession.shared.upload(for: request, from: encoded)

        let httpresponse = response as! HTTPURLResponse // le bon type
        if (httpresponse.statusCode == 200) { // tout s'est bien passé
            UserDefaults.standard.set(try! JSONDecoder().decode(HttpLoginResponse.self, from: data).token, forKey: "token")
//            guard let decoded : DTO = await JSONHelper.decode(data: data) else { // utilisation de notre décodeur
//                return // mauvaise récupération de données
//            }
        // conversion éventuelle du DTO decoded en instance Model
        }
        else if (httpresponse.statusCode == 404) {
            throw LoginError.userNotFound
        }
        else if (httpresponse.statusCode == 401) {
            throw LoginError.wrongCredentials
        }
        else if (httpresponse.statusCode == 500) {
            throw LoginError.serverError
        }
        else{
            throw LoginError.unknown
        }
    }
}
