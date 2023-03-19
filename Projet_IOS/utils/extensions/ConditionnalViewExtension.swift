//
//  ConditionnalViewExtension.swift
//  Projet_IOS
//
//  Created by Lorenzo Italiano on 14/03/2023.
//

import Foundation
import SwiftUI

extension View {
    /// Whether the view should be empty.
    /// - Parameter bool: Set to `true` to hide the view (return EmptyView instead). Set to `false` to show the view.
    func isVisible(_ bool: Bool) -> some View {
        modifier(EmptyModifier(isEmpty: !bool))
    }
}
