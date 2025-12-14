//
//  BackButtonModifier.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 09.12.2025.
//

internal import SwiftUI

struct BackButtonModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                            Text("Артқа")
                                .font(.subheadline)
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func withBackButton() -> some View {
        self.modifier(BackButtonModifier())
    }
}
