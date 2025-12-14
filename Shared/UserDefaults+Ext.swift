//
//  UserDefaults+Ext.swift
//  ExtracurricularActivityApp
//
//  Created by Shyryn Akylbaeva on 08.12.2025.
//

import Foundation

extension UserDefaults {
    func setEncodable<T: Encodable>(_ value: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(value) {
            self.set(data, forKey: key)
        }
    }

    func getDecodable<T: Decodable>(forKey key: String) -> T? {
        guard let data = self.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
}

