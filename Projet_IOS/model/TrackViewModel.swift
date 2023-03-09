//
// Created by Lorenzo Italiano on 07/02/2023.
//

import SwiftUI

class TrackViewModel: Equatable, ObservableObject, Hashable {

    @Published public var id: Int
    @Published public var trackName: String {
        didSet {
            state = .ready
        }
    }
    @Published var state : TrackState = .ready{
        didSet{
            switch state{
                case .changingName(let newname):
                    debugPrint("TrackViewModel: ", newname, " changed")
                    // si le nom convient :
                    self.trackName = newname
                // sinon on fait passer le state en .error
                case .ready:
                    debugPrint("TrackViewModel: ready state")
                    debugPrint("--------------------------------------")
                default:
                    break
            }
        }
    }
    public var artistName: String
    public var collectionName: String
    public var releaseDate: String
    public var artworkUrl100: String

    init(trackName: String, artistName: String, collectionName: String, releaseDate: String, artworkUrl100: String) {
        self.id = Int.random(in: 1..<100000)
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.releaseDate = releaseDate
        self.artworkUrl100 = artworkUrl100
    }

    init(id: Int, trackName: String?, artistName: String, collectionName: String, releaseDate: String, artworkUrl100: String) {
        self.id = id
        self.trackName = trackName ?? ""
        self.artistName = artistName
        self.collectionName = collectionName
        self.releaseDate = releaseDate
        self.artworkUrl100 = artworkUrl100
    }

    static func ==(lhs: TrackViewModel, rhs: TrackViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
