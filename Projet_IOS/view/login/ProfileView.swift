//
//  ProfileView.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation

import SwiftUI

struct ProfileView: View {
    
    private var intent: UserIntent = UserIntent()

    var body: some View {
        VStack{
            Text("Connected")
            Button("Déconnexion"){
                UserDefaults.standard.set("", forKey: "token")
            }
        }
    }

}
