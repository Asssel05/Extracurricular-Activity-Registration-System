//
//  AdminLoginView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

struct AdminLoginView: View {
    @EnvironmentObject var adminAuth: AdminAuthViewModel
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Image(systemName: "lock.shield.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.orange)
                    .padding(.top, 40)
                
                Text("Админ жүйесіне кіру")
                    .font(.title2.bold())
                
                SecureField("Админ паролі", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                Button("Кіру") {
                    adminAuth.login(password: password)
                }
                .buttonStyle(DSPrimaryButton())
                .padding(.horizontal)
                
                if !adminAuth.errorMessage.isEmpty {
                    Text(adminAuth.errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }
                
                Spacer()
            }
        }
    }
}
