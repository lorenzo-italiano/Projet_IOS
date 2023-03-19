////
//// Created by Lorenzo Italiano on 02/03/2023.
////
//
//import Foundation
//
//class TrackDTO: Decodable{
//
//    private var trackName : String?
//    private var releaseDate : String
//    private var collectionName : String
//    private var collectionId : Int?
//    private var trackId : Int?
//    private var artistName : String
//    private var artworkUrl100 : String
//
//    init(trackName: String?, releaseDate: String, collectionName: String, collectionId: Int?, trackId: Int?, artistName: String, artworkUrl100: String) {
//        self.trackName = trackName
//        self.releaseDate = releaseDate
//        self.collectionName = collectionName
//        self.collectionId = collectionId
//        self.trackId = trackId
//        self.artistName = artistName
//        self.artworkUrl100 = artworkUrl100
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case collectionId = "collectionId"
//        case trackId = "trackId"
//        case trackName = "trackName"
//        case artistName = "artistName"
//        case releaseDate = "releaseDate"
//        case collectionName = "collectionName"
//        case artworkUrl100 = "artworkUrl100"
//    }
//
//    required init(from decoder: Decoder) throws {
//
//        let collectionIdContainer = try decoder.container(keyedBy: CodingKeys.self)
//        collectionId = try collectionIdContainer.decodeIfPresent(Int.self, forKey: .collectionId)
//
//        let trackIdContainer = try decoder.container(keyedBy: CodingKeys.self)
//        trackId = try trackIdContainer.decodeIfPresent(Int.self, forKey: .trackId)
//
//        let trackNameContainer = try decoder.container(keyedBy: CodingKeys.self)
//        trackName = try trackNameContainer.decodeIfPresent(String.self, forKey: .trackName)
//
//        let artistNameContainer = try decoder.container(keyedBy: CodingKeys.self)
//        artistName = try artistNameContainer.decode(String.self, forKey: .artistName)
//
//        let collectionNameContainer = try decoder.container(keyedBy: CodingKeys.self)
//        collectionName = try collectionNameContainer.decode(String.self, forKey: .collectionName)
//
//        let realeaseDateContainer = try decoder.container(keyedBy: CodingKeys.self)
//        releaseDate = try realeaseDateContainer.decode(String.self, forKey: .releaseDate)
//
//        let artworkUrl100Container = try decoder.container(keyedBy: CodingKeys.self)
//        artworkUrl100 = try artworkUrl100Container.decode(String.self, forKey: .artworkUrl100)
//    }
//
//    static public func dtoToArray(dtoArray: [TrackDTO]) -> [TrackViewModel] {
//
//        var trackViewModelArray : [TrackViewModel] = []
//
//        //print("array")
//        //print(dtoArray)
//
//        for track in dtoArray{
//            let trackId : Int = track.trackId ?? track.collectionId ?? 0
//            trackViewModelArray.append(TrackViewModel(id: trackId,trackName: track.trackName, artistName: track.artistName, collectionName: track.collectionName, releaseDate: track.releaseDate, artworkUrl100: track.artworkUrl100))
//        }
//
//        return trackViewModelArray
//    }
//
//}
