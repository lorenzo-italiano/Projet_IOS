//
//  ContentView.swift
//  ExercicesMobiles_Listes
//
//  Created by Lorenzo Italiano on 07/02/2023.
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var gameList : GameList = GameList(gameList: [])
    
    @AppStorage("token") var token: String = ""

    var body: some View {
        TabView {
           Text("The content of the first view")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Accueil")
                }
            GameListView(gameList: gameList)
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Jeux")
                }
            LoginView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Connexion")
                }
                .isVisible(token == "")
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
                .isVisible(token != "")
        }
    }
}
