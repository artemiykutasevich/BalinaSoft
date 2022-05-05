//
//  ViewModifiers.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import SwiftUI

struct DropShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.5), radius: 4, x: 3, y: 3)
            .shadow(color: .white.opacity(0.5), radius: 4, x: -3, y: -3)
    }
}

extension View {
    func dropShadow() -> some View {
        self.modifier(DropShadowModifier())
    }
}
