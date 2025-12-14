//
//  EnrollmentViewModel.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

import Foundation
import UserNotifications
import Combine

final class EnrollmentViewModel: ObservableObject {

    // 🔥 Club VM-ді байланыстырдық → push үшін club атауын алу
    weak var clubVM: ClubListViewModel?

    @Published var enrollments: [Enrollment] = []
    private let storageKey = "app.enrollments.v1"

    // init with clubVM
    init(clubVM: ClubListViewModel? = nil) {
        self.clubVM = clubVM
        requestNotificationPermission()
        loadFromStorage()
    }

    // MARK: — PUSH PERMISSION
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Push notifications allowed ✅")
            } else {
                print("Push notifications denied ❌")
            }
        }
    }

    // MARK: — SEND NOTIFICATION
    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil   // Жіберілген бойда көрсетіледі
        )

        UNUserNotificationCenter.current().add(request)
    }


    // MARK: — ENROLL
    func enroll(userId: String, clubId: String) {
        let e = Enrollment(
            id: UUID().uuidString,
            userId: userId,
            clubId: clubId,
            registeredAt: Date()
        )

        enrollments.append(e)
        saveToStorage()

        // PUSH → тіркелу хабарламасы
        if let club = clubVM?.clubs.first(where: { $0.id == clubId }) {
            sendNotification(
                title: "Тіркелу сәтті 🎉",
                body: "\(club.title) үйірмесіне тіркелдіңіз!"
            )
        }
    }

    // MARK: — UNENROLL
    func unenroll(userId: String, clubId: String) {
        enrollments.removeAll { $0.userId == userId && $0.clubId == clubId }
        saveToStorage()

        // PUSH → орын босады
        if let club = clubVM?.clubs.first(where: { $0.id == clubId }) {
            sendNotification(
                title: "Орын босады 🔔",
                body: "\(club.title) үйірмесінде 1 орын босады!"
            )
        }
    }

    // MARK: — CHECK
    func isEnrolled(userId: String, clubId: String) -> Bool {
        enrollments.contains { $0.userId == userId && $0.clubId == clubId }
    }

    func countForClub(_ clubId: String) -> Int {
        enrollments.filter { $0.clubId == clubId }.count
    }

    func enrollmentsFor(userId: String) -> [Enrollment] {
        enrollments.filter { $0.userId == userId }
    }


    // MARK: — STORAGE SAVE
    func saveToStorage() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(enrollments)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Enrollment save error:", error)
        }
    }

    // MARK: — STORAGE LOAD
    func loadFromStorage() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let arr = try decoder.decode([Enrollment].self, from: data)
            self.enrollments = arr
        } catch {
            print("Enrollment load error:", error)
        }
    }
}
