//
//  DietsViewModel.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import Foundation
import Combine

class DietsViewModel: ObservableObject {
    @Published var diets = [DietsData]()
    @Published var selectedDiets: [DietsData] = []
    @Published var errorMessages:String = ""
    
    init() {
        self.diets = loadDietsFromJson()
    }
    
    func validate() {
        if selectedDiets.isEmpty{
            return errorMessages = "You have to select at least 1 diets."
        }
        
        return errorMessages = ""
    }
    
    private func loadDietsFromJson() -> [DietsData] {
        guard let fileURL = Bundle.main.url(forResource: "Diets", withExtension: "json") else {
            fatalError("Failed to locate JSON file")
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let diets = try decoder.decode(Diets.self, from: jsonData)
            return diets.data
        } catch {
            fatalError("Failed to decode JSON: \(error)")
        }
    }
    
    func toggleSelection(for diet: DietsData) {
        if let index = selectedDiets.firstIndex(where: { $0.id == diet.id }) {
            selectedDiets.remove(at: index)
        } else {
            selectedDiets.append(diet)
        }
        validate() 
    }
    
    // Function to generate dummy data for preview
    static func dummyData() -> DietsViewModel {
        let viewModel = DietsViewModel()
        viewModel.diets = [
            DietsData(id: 1, name: "Dummy 1", toolTip: "Dummy tooltip 1"),
            DietsData(id: 2, name: "Dummy 2", toolTip: "Dummy tooltip 2"),
            DietsData(id: 3, name: "Dummy 3", toolTip: "Dummy tooltip 3")
        ]
        return viewModel
    }
}
