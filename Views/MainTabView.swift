//
//  MainTabView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView { ClubListView() }
                .tabItem {
                    Label("Үйірмелер", systemImage: "list.bullet")
                }

            NavigationView { MyClubsView() }
                .tabItem {
                    Label("Менің үйірмелерім", systemImage: "person.2.fill")
                }

            NavigationView { MenuView() }
                .tabItem {
                    Label("Профиль", systemImage: "person.circle")
                }
            
            
        }
    }
}
