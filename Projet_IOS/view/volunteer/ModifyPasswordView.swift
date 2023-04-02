//
// Created by Lorenzo Italiano on 02/04/2023.
//

import Foundation
import SwiftUI

struct ModifyPasswordView: View {

    @AppStorage("token") var token: String = ""

    @ObservedObject private var volunteer: Volunteer
    @State private var intent: VolunteerIntent = VolunteerIntent(model: Volunteer(id: "", email: "", surname: "", name: "", profilePicture: "", password: "", isAdmin: false))

    @State var currentPassword: String = ""
    @State var newPassword: String = ""

    @State private var showingAlert = false
    @State private var alertMessage: String = ""

    init(volunteer: Volunteer){
        self.volunteer = volunteer
        self.intent = VolunteerIntent(model: self._volunteer.wrappedValue)
    }


    var body: some View {
        VStack(alignment: .center){
            Text("Changement de mot de passe").font(.title)
            Form {

                Section(header: Text("Mot de passe actuel")) {
                    SecureInputView("Mot de passe actuel", text: $currentPassword)
                            .padding(.all)
                }

                Section(header: Text("Nouveau mot de passe")) {
                    SecureInputView("Nouveau mot de passe", text: $newPassword)
                            .padding(.all)
                }

                Button("Changer son mot de passe"){
                    Task {
                        do {
                            try await self.intent.changePassword(id: JWTDecoder.decode(jwtToken: token)["userId"]! as! String, passwordObject: PasswordChangeObject(currentPassword: currentPassword, newPassword: newPassword))
                            showingAlert = true
                            alertMessage = "Vous avez changé votre mot de passe avec succès"
                        }
                        catch RequestError.serverError{
                            showingAlert = true
                            alertMessage = RequestError.serverError.description
                        }
                        catch RequestError.badRequest{
                            showingAlert = true
                            alertMessage = RequestError.badRequest.description
                        }
                        catch RequestError.unauthorized{
                            showingAlert = true
                            alertMessage = RequestError.unauthorized.description
                        }
                        catch RequestError.unknown{
                            showingAlert = true
                            alertMessage = RequestError.unknown.description
                        }
                    }
                }
            }
        }
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                    }
                }

    }
}
