//
//  Helpers.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 09.12.2025.
//

import Foundation

extension Date {
    /// Көрсетуге арналған: "Дүйсенбі, 14:00" сияқты формат
    func toReadableDayAndTime() -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.locale = Locale(identifier: "kk_KZ") // қазақша аптаның күндері үшін
        dayFormatter.dateFormat = "EEEE" // толық апта күні (дүйсенбі)
        let day = dayFormatter.string(from: self).capitalized

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let time = timeFormatter.string(from: self)

        return "\(day), \(time)"
    }

    /// Тек уақыт (қажет болса)
    func toTimeOnly() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
