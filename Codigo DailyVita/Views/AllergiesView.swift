//
//  AllergiesView.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import SwiftUI

struct AllergiesView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var allergiesViewModel = AlelrgiesViewModel()
    let healthConcerns: [HealthConcernsData]
    let diets: [DietsData]
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                AppColor.appTheme.ignoresSafeArea(edges: .all)
                VStack {
                    Text("Write any specific allergies or sensitivity towards specific things. (optional)")
                        .foregroundColor(AppColor.selected)
                        .font(.title2)
                    
                    VStack{
                            LazyVGrid(columns:  [GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 10)], spacing: 8) {
                                    ForEach(allergiesViewModel.selectedAllergies) { item in
                                        Text(item.name)
                                            .padding(.horizontal, 8)
                                            .background(AppColor.selected)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    TextField("", text: $allergiesViewModel.enteredText)
                                        .padding()
                                        .textFieldStyle(PlainTextFieldStyle())
                                }
                        .presentationCornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                        if(!allergiesViewModel.enteredText.isEmpty){
                            List(allergiesViewModel.allergies.filter { $0.name.contains(allergiesViewModel.enteredText)  }) { item in
                                Button(action: {
                                    allergiesViewModel.selectedAllergies.append(item)
                                    allergiesViewModel.enteredText = ""
                                }) {
                                    Text(item.name)
                                }.listRowBackground(Color.gray.opacity(0.3))
                            }
                            .listStyle(PlainListStyle())
                            .frame(height: 150)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                        }
                    }.background()
                    Spacer()
                    HStack{
                        Button(action: {
                            dismiss()
                        }) {
                                Text("Back")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .cornerRadius(8)
                                .foregroundColor(AppColor.button)
                                .fontWeight(.bold)
                        }
                        NavigationLink(destination: QuestionnaireView(healthConcerns: healthConcerns, diets: diets, allergies: allergiesViewModel.selectedAllergies)){
                                Text("Next")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(AppColor.button)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }
                    ProgressBar(progress: 0.6)
                }
                .padding()
                
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct AllergiesView_Preview: PreviewProvider {
    static var previews: some View {
        AllergiesView(healthConcerns: [], diets: [])
    }
}
