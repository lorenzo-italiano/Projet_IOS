//
//  ProfileView.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation

import SwiftUI

struct ProfileView: View {

    @AppStorage("token") var token: String = ""

    @ObservedObject var volunteer : Volunteer = Volunteer()

    private var intent: VolunteerIntent

    init() {
        self.intent = VolunteerIntent(model: self._volunteer.wrappedValue)
    }

    var body: some View {
        VStack{
            Spacer()
            AsyncImage(url: URL(string: volunteer.profilePicture ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"), content: { image in
                image.resizable()
                        .frame(width: 350, height: 350)
            },
            placeholder: {
                ProgressView()
            })
            HStack{
                Text(volunteer.name)
                Text(volunteer.surname)
            }
            Text(volunteer.email)
            Spacer()
            Button("Déconnexion"){
                UserDefaults.standard.set("", forKey: "token")
            }
            Spacer()
        }
        .onAppear{
            if(token != ""){
                Task{
                    do {
                        try await self.intent.getById(id: JWTDecoder.decode(jwtToken: token)["userId"]! as! String)
                    } catch {
                        //TODO replace print by display error
                        print("error")
                    }
                }
            }
        }
    }

}
