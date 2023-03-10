//
//  VolunteerList.swift
//  Projet_IOS
//
//  Created by m1 on 10/03/2023.
//

import SwiftUI

class VolunteerList: ObservableObject {

    @Published public var volunteerList: [Volunteer]{
        didSet{
            state = .ready
        }
    }
    
    @Published var state : VolunteerState = .empty

    init(volunteerList: [Volunteer]) {
        self.volunteerList = volunteerList
    }
    
    init(){
        self.volunteerList = [Volunteer]()
    }

}
