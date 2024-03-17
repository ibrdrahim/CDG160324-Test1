//
//  DietsData.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import Foundation

// MARK: - HealthConcerns
struct Diets: Codable {
    let data: [DietsData]
}

// MARK: - HealthConcernsData
struct DietsData: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let toolTip: String
    var isChecked: Bool?
    
    init(id: Int, name: String, toolTip: String, isChecked: Bool = false) {
        self.id = id
        self.name = name
        self.toolTip = toolTip
        self.isChecked = isChecked
    }
}
