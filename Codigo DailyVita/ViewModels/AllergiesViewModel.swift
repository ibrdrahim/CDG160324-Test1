//
//  AllergiesViewModel.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import Foundation

class AlelrgiesViewModel: ObservableObject {
    @Published var allergies: [AllergiesData] = []
    @Published var enteredText = ""
    @Published var selectedAllergies: [AllergiesData] = []
    
    init() {
        allergies = LoadAllergiesFromJSON()
    }
    
    private func LoadAllergiesFromJSON() -> [AllergiesData] {
        guard let fileURL = Bundle.main.url(forResource: "Allergies", withExtension: "json") else {
            fatalError("Failed to locate JSON file")
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let allergies = try JSONDecoder().decode(Allergies.self, from: jsonData)
            return allergies.data
        } catch {
            fatalError("Failed to decode JSON: \(error)")
        }
    }
}
