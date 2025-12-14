//
//  RegisterView.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//
internal import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 24) {
            Text("Тіркелу")
                .font(.largeTitle.bold())

            VStack(spacing: 16) {
                TextField("Электронды пошта", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                SecureField("Құпия сөз", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }

            Button("Аккаунт жасау") {
                authVM.register(email: email, password: password)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)

            Spacer()
        }
        .padding()
        .navigationTitle("Тіркелу")
        .withBackButton()
    }
}

