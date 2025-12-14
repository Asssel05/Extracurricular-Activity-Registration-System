//
//  MenuView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

struct MenuView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var adminAuth: AdminAuthViewModel   // керек болса
                                                           // (атанаға әсер етпейді)

    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {

                Text("Профиль")
                    .font(.largeTitle.bold())

                if let email = authVM.currentUserEmail {
                    Text(email)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                // 🔥 Ата-ана үшін ШЫҒУ батырмасы
                Button("Шығу") {
                    authVM.logout()
                }
                .buttonStyle(DSSecondaryButton())
                .foregroundColor(.red)
                .padding(.horizontal)

            }
            .padding()
            .navigationTitle("Менің профилім")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
