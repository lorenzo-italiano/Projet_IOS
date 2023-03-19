//
// Created by Lorenzo Italiano on 19/03/2023.
//

import Foundation

import SwiftUI

struct VolunteerItemView: View{

    @ObservedObject private var volunteer: Volunteer

    init(volunteer: Volunteer){
        self.volunteer = volunteer
    }

    var body: some View {
        HStack{
            Text(volunteer.surname)
            Text(volunteer.name)
            Spacer()
            AsyncImage(url: URL(string: volunteer.profilePicture ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"), content: { image in
                image.resizable()
                        .frame(width: 80, height: 80)
            },
                    placeholder: {
                        ProgressView()
                    })
        }

    }
}

struct Previews_VolunteerItemView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}