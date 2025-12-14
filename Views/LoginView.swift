//
//  LoginView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

internal import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {

                Text("Жүйеге қош келдіңіз")
                    .font(.title2.bold())

                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                SecureField("Құпия сөз", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                Button("Кіру") {
                    authVM.login(email: email, password: password)
                }
                .buttonStyle(DSPrimaryButton())
                .padding(.horizontal)

                NavigationLink("Аккаунт құру", destination: RegisterView())
                    .padding(.top, 10)

                Spacer()
            }
            
        }
    }
}

