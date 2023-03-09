//
// Created by Lorenzo Italiano on 14/02/2023.
//

import SwiftUI

struct TrackDetailView: View {

    @ObservedObject private var track: TrackViewModel

    init(track: TrackViewModel){
        self.track = track
    }


    var body: some View {
        Spacer()
        HStack{
            Text("Nom du morceau: ")
            TextField("Nom du morceau", text: $track.trackName )
                    //.onChange(of: statevar){
                    //    newValue in
                    //    stateChanged(newValue)
                    //}
                    //.onSubmit(){track.nameChanged()}
        }
        Text("Nom de l'auteur: " + track.artistName)
        Text("Nom de l'album: " + track.collectionName)
        Text("Date de sortie: " + track.releaseDate)
        Spacer()
    }

}
