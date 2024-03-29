//
//  LoginView.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation

import SwiftUI

struct LoginView: View {

    @EnvironmentObject private var tabController: TabController

    private var intent: UserIntent = UserIntent()
    
    @State private var showingAlert = false
    @State private var alertMessage: String = ""
    
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack(alignment: .center){
            Text("Connexion").font(.title)
            
            Form{
                Section(header: Text("Email")) {
                    TextField("email", text: $email, prompt: Text("Entrez votre email"))
                        .autocapitalization(.none)
                        .padding(.all)
                }
                Section(header: Text("Mot de passe")) {
                    SecureInputView("Mot de passe", text: $password)
                        .padding(.all)
                }

                Button("Mot de passe oublié"){
                    Task {
                        do {
                            try await self.intent.forgottenPassword(email: email)
                            showingAlert = true
                            alertMessage = "Vous avez reçu un mail pour changer votre mot de passe !"
                        }
                        catch RequestError.serverError {
                            showingAlert = true
                            alertMessage = RequestError.serverError.description
                        }
                    }
                }
                        .padding(.all)
                        .buttonStyle(.borderedProminent)
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }



            Button("Connexion"){
                Task{
                    do{
                        try await self.intent.login(email: email, password: password)
                        tabController.open(.festivals)
                    }
                    catch LoginError.userNotFound {
                        showingAlert = true
                        alertMessage = LoginError.userNotFound.description
                    }
                    catch LoginError.wrongCredentials {
                        showingAlert = true
                        alertMessage = LoginError.wrongCredentials.description
                    }
                    catch LoginError.serverError {
                        showingAlert = true
                        alertMessage = LoginError.serverError.description
                    }
                    catch {
                        showingAlert = true
                        alertMessage = LoginError.unknown.description
                    }
                }
            }
            .padding(.all)
            .buttonStyle(.borderedProminent)
        }
    }

}
