//
//  ClubListViewModel.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

import Foundation
internal import SwiftUI
import Combine

final class ClubListViewModel: ObservableObject {
    @Published var clubs: [Club] = []

    private let storageKey = "app.clubs.v1"

    init() {
        loadFromStorage()
        if clubs.isEmpty {
            loadSample()
            saveToStorage()
        }
    }

    // MARK: - Sample
    func loadSample() {
        // мысал ретінде бүгінгі дата + әртүрлі уақыттар
        let calendar = Calendar.current
        var comps = calendar.dateComponents([.year, .month, .day], from: Date())

        // Робот техника — бүгін сағат 16:00
        comps.hour = 16
        comps.minute = 0
        let t1 = calendar.date(from: comps) ?? Date()

        // Сурет салу — ертең сағат 18:30
        if let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date()) {
            var comps2 = calendar.dateComponents([.year, .month, .day], from: tomorrow)
            comps2.hour = 18
            comps2.minute = 30
            let t2 = calendar.date(from: comps2) ?? tomorrow

            clubs = [
                Club(
                    title: "Робототехника",
                    description: "Робот құрастыру және бағдарламалау",
                    place: "101 кабинет",
                    weeklyDay: "Дүйсенбі",
                    startTime: t1,
                    capacity: 12,
                    imageName: "photo_5325782425575034851_x.jpg",
                    instructor: "Бекежан Қ."
                ),
                Club(
                    title: "Сурет салу",
                    description: "Қылқалам, акварель, композиция",
                    place: "Студия",
                    weeklyDay: "Сәрсенбі",
                    startTime: t2,
                    capacity: 18,
                    imageName: "photo_5325782425575034850_x.jpg",
                    instructor: "Алия М."
                )
            ]
            return
        }

        // Қосымша fallback
        clubs = [
            Club(
                title: "Робототехника",
                description: "Робот құрастыру және бағдарламалау",
                place: "101 кабинет",
                weeklyDay: "Дүйсенбі",
                startTime: t1,
                capacity: 12,
                imageName: nil,
                instructor: "Бекежан Қ."
            )
        ]
    }

    // MARK: - Storage
    func saveToStorage() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(clubs)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("ClubListViewModel save error:", error)
        }
    }

    func loadFromStorage() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let arr = try decoder.decode([Club].self, from: data)
            self.clubs = arr
        } catch {
            print("ClubListViewModel load error:", error)
        }
    }

    // MARK: - CRUD
    func addClub(_ club: Club) {
        clubs.append(club)
        saveToStorage()
    }

    func updateClub(_ club: Club) {
        guard let idx = clubs.firstIndex(where: { $0.id == club.id }) else { return }
        clubs[idx] = club
        saveToStorage()
    }

    func deleteClub(_ club: Club) {
        clubs.removeAll { $0.id == club.id }
        saveToStorage()
    }
}
