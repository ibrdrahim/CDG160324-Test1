//
//  QuestionData.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import Foundation

struct Question: Identifiable {
    let id: Int
    let text: String
    var selectedOption: String? = nil
    let options: [String]
}
