//
//  AllergiesView.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import SwiftUI

struct QuestionnaireView: View {
    @ObservedObject var questionnaireViewModel = QuestionnaireViewModel()
    let healthConcerns: [HealthConcernsData]
    let diets: [DietsData]
    let allergies: [AllergiesData]
    
    var body: some View {
        NavigationStack{
            ZStack{
                AppColor.appTheme.ignoresSafeArea(edges: .all)
                ScrollView{
                    VStack(alignment: .leading) {
                        
                        if !questionnaireViewModel.errorMessages.isEmpty {
                            Text(questionnaireViewModel.errorMessages)
                                .font(.callout)
                                .foregroundColor(.pink)
                                .padding()
                        }
                        ForEach(questionnaireViewModel.questions) { question in
                            QuestionView(question: question, onSelectOption: { option in
                                questionnaireViewModel.saveSelectedOption(for: question.id, option: option)
                            })
                        }
                    }
                }
                VStack{
                    Spacer()
                    Button(action: {
                        print("Health Concerns \(healthConcerns)")
                        print("Diets \(diets)")
                        print("Allergies \(allergies)")
                        print("Questionaire \(questionnaireViewModel.questions)")
                    }) {
                        Text("Get my personalized vitamin")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(questionnaireViewModel.allValidated() ? AppColor.button : AppColor.disabled)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }.padding()
                    ProgressBar(progress:   questionnaireViewModel.allValidated() ? 1.0 : 0.8)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct QuestionView: View {
    let question: Question
    let onSelectOption: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(question.text)
                    .foregroundColor(AppColor.selected)
                    .font(.title2) +
                Text(" *").foregroundColor(AppColor.button)
                    .font(.title2)
            }
            ForEach(question.options, id: \.self) { option in
                Button(action: {
                    onSelectOption(option)
                }) {
                    RadioButton(text: option, isSelected: question.selectedOption == option)
                }
            }
        }
        .padding()
    }
}

struct RadioButton: View {
    let text: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .foregroundColor(isSelected ? AppColor.selected : .primary)
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(AppColor.selected)
        }.padding(.vertical, CustomPadding.small)
    }
}

struct QuestionnaireView_Preview: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(healthConcerns: [], diets: [], allergies: [])
    }
}
