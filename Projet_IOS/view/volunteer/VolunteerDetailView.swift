//
//  VolunteerDetailView.swift
//  Projet_IOS
//
//  Created by m1 on 10/03/2023.
//

import SwiftUI

struct VolunteerDetailView: View {

    @ObservedObject private var volunteer: Volunteer

    init(volunteer: Volunteer){
        self.volunteer = volunteer
    }


    var body: some View {
        Spacer()
        AsyncImage(url: URL(string: volunteer.profilePicture ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"), content: { image in
            image.resizable()
                 .frame(width: 350, height: 350)
        },
        placeholder: {
            ProgressView()
        })
        
        HStack{
            Text("Prénom : ")
            Spacer()
            TextField("Prénom", text: $volunteer.name )
        }
        .padding(20)
        
        HStack{
            Text("Nom ")
            Spacer()
            TextField("Nom", text: $volunteer.surname )
        }
        .padding(20)
        
        HStack{
            Text("Email ")
            Spacer()
            TextField("Email", text: $volunteer.email )
        }
        .padding(20)
        Spacer()
    }

}
