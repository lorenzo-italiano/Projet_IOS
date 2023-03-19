//
//  EmptyModifier.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation
import SwiftUI

struct EmptyModifier: ViewModifier {

    let isEmpty: Bool

    func body(content: Content) -> some View {
        Group {
            if isEmpty {
                EmptyView()
            } else {
                content
            }
        }
    }
}
