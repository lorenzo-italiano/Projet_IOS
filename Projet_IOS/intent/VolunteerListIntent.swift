//
//  VolunteerListIntent.swift
//  Projet_IOS
//
//  Created by m1 on 10/03/2023.
//

import SwiftUI
import Foundation

struct VolunteerListIntent {
    @ObservedObject private var model : VolunteerList

    init(model: VolunteerList){
        self.model = model
    }

    // intent to load data from api
    func load() async -> Void {
        model.state = .loading
        do{
            let (data, _ ) = try await URLSession.shared.data(from: URL(string:"https://us-central1-projetwebig4-back.cloudfunctions.net/app/api/v1/volunteers")!)
            model.volunteerList = JsonHelper.decodeVolunteers(data: data)!
        }
        catch{
        // some error: invalid data?
        }
        model.state = .ready
    }


}
