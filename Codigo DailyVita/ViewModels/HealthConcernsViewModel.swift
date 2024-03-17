//
//  AllergiesView.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//
import Foundation

class HealthConcernsViewModel: ObservableObject {
    @Published var selectedConcerns: [HealthConcernsData] = []
    @Published var errorMessages:String = ""
    
    let healthConcerns: [HealthConcernsData]
    
    init() {
        self.healthConcerns = HealthConcernsViewModel.loadHealthConcernsFromJSON()
    }
    
    func validate() {
        if selectedConcerns.isEmpty{
            return errorMessages = "You have to select at least 1 health concern."
        }
        
        if selectedConcerns.count > 5 {
            return errorMessages = "You can only have upto 5 health concerns."
        }
        
        return errorMessages = ""
    }
    
    func toggleSelection(_ concern: HealthConcernsData) {
        if selectedConcerns.contains(concern) {
            selectedConcerns.removeAll { $0 == concern }
        } else {
            if selectedConcerns.count < 5 {
                selectedConcerns.append(concern)
            }
        }
        validate()
    }
    
    private static func loadHealthConcernsFromJSON() -> [HealthConcernsData] {
        guard let fileURL = Bundle.main.url(forResource: "Healthconcerns", withExtension: "json") else {
            fatalError("Failed to locate JSON file")
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let healthConcerns = try JSONDecoder().decode(HealthConcerns.self, from: jsonData)
            return healthConcerns.data
        } catch {
            fatalError("Failed to decode JSON: \(error)")
        }
    }
}
