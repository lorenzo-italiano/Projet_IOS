//
// Created by Lorenzo Italiano on 22/03/2023.
//

import Foundation
import SwiftUI

struct SignUpView: View {

    public var intent: UserIntent = UserIntent()

    @State var showingAlert = false
    @State var alertMessage: String = ""

    @State var name: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordRepeat: String = ""

//    @Binding public var tabSelection: Int

    var body: some View {
        VStack(alignment: .center){
            Text("Inscription").font(.title)

            Form{

                Section(header: Text("Prénom")) {
                    TextField("name", text: $name, prompt: Text("Entrez votre prénom"))
                            .autocapitalization(.none)
                            .padding(8)
                }

                Section(header: Text("Nom")) {
                    TextField("surname", text: $surname, prompt: Text("Entrez votre nom"))
                            .autocapitalization(.none)
                            .padding(8)
                }

                Section(header: Text("Email")) {
                    TextField("email", text: $email, prompt: Text("Entrez votre email"))
                            .autocapitalization(.none)
                            .padding(8)
                }

                Section(header: Text("Mot de passe")) {
                    SecureInputView("Mot de passe", text: $password)
                            .padding(8)
                }

                Section(header: Text("Mot de passe")) {
                    SecureInputView("Mot de passe", text: $passwordRepeat)
                            .padding(8)
                }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            Button("S'inscrire"){
                Task{
                    do{
                        try await self.intent.signup(name: name, surname: surname, email: email, password: password, passwordRepeat: passwordRepeat)
                        showingAlert = true
                        alertMessage = "Vous avez créé votre compte avec succès !"
//                        tabSelection = 4
                    }
                    catch RequestError.badRequest{
                        showingAlert = true
                        alertMessage = RequestError.badRequest.description
                    }
                    catch RequestError.serverError{
                        showingAlert = true
                        alertMessage = RequestError.serverError.description
                    }
                    catch RequestError.alreadyExists{
                        showingAlert = true
                        alertMessage = RequestError.alreadyExists.description
                    }
                    catch {
                        showingAlert = true
                        alertMessage = RequestError.unknown.description
                    }
                }
            }
            .padding(.all)
            .buttonStyle(.borderedProminent)
        }
    }
}
