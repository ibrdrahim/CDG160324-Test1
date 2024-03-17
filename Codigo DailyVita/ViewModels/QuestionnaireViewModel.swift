//
//  QuestionnaireViewModel.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import Foundation

class QuestionnaireViewModel: ObservableObject {
    @Published var questions: [Question] = [
        Question(id: 1, text: "Is your daily exposure to sun limited?", options: ["Yes", "No"]),
        Question(id: 2, text: "Do you currently smoke (tobacco or marijuana)?", options: ["Yes", "No"]),
        Question(id: 3, text: "On average, how many alcoholic beverages do you have in a week?", options: ["0 - 1", "2 - 5", "5 +"])
    ]
    
    @Published var errorMessages:String = ""
    
    func saveSelectedOption(for questionId: Int, option: String) {
        if let index = questions.firstIndex(where: { $0.id == questionId }) {
            questions[index].selectedOption = option
        }
    }
    
    func allValidated()-> Bool {
        for question in questions {
            if question.selectedOption == nil {
                return false
            }
        }
        return true
    }
    
    func validate() {
        errorMessages =  allValidated() ?  "All questionnaire must be filled" : ""
    }
}
