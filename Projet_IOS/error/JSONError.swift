//
// Created by Lorenzo Italiano on 03/03/2023.
//

import Foundation

enum JSONError : Error, CustomStringConvertible{
    case fileNotFound(String)
    case JsonDecodingFailed
    case JsonEncodingFailed
    case initDataFailed
    case unknown

    var description : String {
        switch self {
        case .fileNotFound(let filename): return "File \(filename) not found"
        case .JsonDecodingFailed: return "JSON decoding failed"
        case .JsonEncodingFailed: return "JSON encoding failed"
        case .initDataFailed: return "Bad data format: initialization of data failed"
        case .unknown: return "unknown error"
        }
    }
}
