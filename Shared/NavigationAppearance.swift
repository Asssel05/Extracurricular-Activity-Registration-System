//
//  NavigationAppearance.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 09.12.2025.
//

internal import SwiftUI

struct NavigationAppearance {
    static func setup() {
        let appearance = UINavigationBarAppearance()
        
        // 🔵 Навбар фоны
        appearance.backgroundColor = UIColor.systemBlue
        
        // 🔵 Навбар тақырып шрифті + түсі
        appearance.titleTextAttributes = [
            .foregroundColor : UIColor.white,
            .font : UIFont.systemFont(ofSize: 20, weight: .semibold)
        ]
        
        // 🔵 Large title стилі
        appearance.largeTitleTextAttributes = [
            .foregroundColor : UIColor.white,
            .font : UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        // 🔵 Төменгі сызығын өшіреміз (көрсетпеу үшін)
        appearance.shadowColor = .clear
        
        // 🔵 Артқа батырма түсі (chevron)
        UINavigationBar.appearance().tintColor = .white
        
        // 🔵 Global қолдану
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
