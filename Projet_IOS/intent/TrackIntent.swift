//
// Created by Lorenzo Italiano on 16/02/2023.
//

import SwiftUI
import Foundation

struct TrackIntent {
    @ObservedObject private var model : TrackViewModel

    init(track: TrackViewModel){
        self.model = track
    }

    // intent to change name of ViewModel
    func change(name: String){
        let newname = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if newname.count < 4{
            self.model.state = .error(TrackIntentError("Le nom est trop court !"))
        }
        else{
            self.model.state = .changingName(name)
        }

        // les observateurs ont été prévenus du résultat .ready
        self.model.state = .ready
    }

}
