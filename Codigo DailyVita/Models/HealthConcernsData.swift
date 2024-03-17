//
//  HealthConcernsData.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import Foundation

// MARK: - HealthConcerns
struct HealthConcerns: Codable {
    let data: [HealthConcernsData]
}

// MARK: - HealthConcernsData
struct HealthConcernsData: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}
