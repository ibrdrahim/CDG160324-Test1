//
//  AllergiesData.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import Foundation

struct Allergies: Codable {
    let data: [AllergiesData]
}

struct AllergiesData: Identifiable, Codable {
    let id: Int
    let name: String
}
