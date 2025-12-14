//
//  AuthViewModel.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var errorMessage = ""
    @Published var currentUserEmail: String? = nil

    func register(email: String, password: String) {
        let user = LocalUser(email: email, password: password)
        UserDefaults.standard.setEncodable(user, forKey: "user_\(email)")
        
        isLoggedIn = true
        currentUserEmail = email
        errorMessage = ""
    }

    func login(email: String, password: String) {
        if let saved: LocalUser = UserDefaults.standard.getDecodable(forKey: "user_\(email)") {
            if saved.password == password {
                isLoggedIn = true
                currentUserEmail = email
                errorMessage = ""
            } else {
                errorMessage = "Құпия сөз қате"
            }
        } else {
            errorMessage = "Мұндай қолданушы жоқ"
        }
    }

    func logout() {
        isLoggedIn = false
        currentUserEmail = nil
    }
}
