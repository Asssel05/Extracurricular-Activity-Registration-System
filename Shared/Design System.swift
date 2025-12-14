//
//  Design System.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

// Бүкіл қолданбада қолданылатын дизайн жүйесі (түстер, стиле)
enum DS {
    // Егер кастом түс болмаса — резерв түс
    static let primaryFallback = Color.blue
    static let secondaryFallback = Color.gray
    
    // Түс палитрасы (қоссаң болады)
    static let background = Color(.systemBackground)
    static let cardBackground = Color(.secondarySystemBackground)
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
}

// MARK: - Primary Button Style
struct DSPrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(DS.primaryFallback.opacity(configuration.isPressed ? 0.8 : 1.0))
            .foregroundColor(.white)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

// Бұл функцияны View-ларда ыңғайлы қолдану үшін

// MARK: - Secondary Button Style
struct DSSecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .foregroundColor(DS.primaryFallback)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

// MARK: - Card Style (UI карточкалары үшін)
struct DSCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(DS.cardBackground)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(DSCard())
    }
}
