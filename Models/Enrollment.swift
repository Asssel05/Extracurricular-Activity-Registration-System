//
//  Enrollment.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

import Foundation

struct Enrollment: Codable, Identifiable {
    var id = UUID().uuidString
    var userId: String
    var clubId: String
    var registeredAt: Date
}
