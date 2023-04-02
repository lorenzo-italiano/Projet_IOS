//
// Created by Lorenzo Italiano on 01/04/2023.
//

import Foundation
import SwiftUI

struct HomeView: View {

    var body: some View {
        VStack{
            Spacer()
            Text("Bienvenue aux festivals de jeu de Montpellier !")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.8))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
        )
        .background(
            Image("landingImage")
                .resizable()
        )
    }



}
