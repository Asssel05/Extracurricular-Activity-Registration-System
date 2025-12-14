//
//  Club.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

// Club.swift
import Foundation

struct Club: Codable, Identifiable, Equatable {
    var id: String = UUID().uuidString     // string id
    var title: String
    var description: String
    var place: String
    var weeklyDay: String
    var startTime: Date                    // Date — күні мен уақыты
    var capacity: Int
    var imageName: String?
    var instructor: String
    var imageData: Data? = nil
}
