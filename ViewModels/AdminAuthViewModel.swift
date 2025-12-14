//
//  AdminAuthViewModel.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

import Foundation
import Combine

/// Өте қарапайым жергілікті админ аутентификациясы.
/// Әдепкі пароль – "teacher123" (қажет болса өзгерте аласың).
final class AdminAuthViewModel: ObservableObject {
    @Published var isAdminLoggedIn: Bool = false
    @Published var errorMessage: String = ""

    private let adminKey = "app_admin_password"
    private let loggedKey = "app_admin_logged"

    init() {
        // Бастапқы пароль болмаса, орнатамыз
        if UserDefaults.standard.string(forKey: adminKey) == nil {
            UserDefaults.standard.set("teacher123", forKey: adminKey)
        }
        isAdminLoggedIn = UserDefaults.standard.bool(forKey: loggedKey)
    }

    func login(password: String) {
        let saved = UserDefaults.standard.string(forKey: adminKey) ?? ""
        if password == saved {
            isAdminLoggedIn = true
            UserDefaults.standard.set(true, forKey: loggedKey)
            errorMessage = ""
        } else {
            errorMessage = "Қате пароль"
            isAdminLoggedIn = false
        }
    }

    func logout() {
        isAdminLoggedIn = false
        UserDefaults.standard.set(false, forKey: loggedKey)
    }

    func changePassword(old: String, new: String) -> Bool {
        let saved = UserDefaults.standard.string(forKey: adminKey) ?? ""
        if old == saved {
            UserDefaults.standard.set(new, forKey: adminKey)
            return true
        }
        return false
    }
}
