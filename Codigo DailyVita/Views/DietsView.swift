//
//  DietsView.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import SwiftUI
struct DietsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var dietsViewModel = DietsViewModel()
    let healthConcerns: [HealthConcernsData] 
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.appTheme.ignoresSafeArea(edges: .all)
                VStack(alignment: .leading) {
                    Group {
                        Text("Select the diets you follow.") +
                        Text(" *").foregroundColor(AppColor.button)
                    }
                    .padding()
                    if !dietsViewModel.errorMessages.isEmpty {
                        Text(dietsViewModel.errorMessages)
                            .font(.callout)
                            .foregroundColor(.pink)
                            .padding()
                    }
                    LazyVStack(spacing: CustomPadding.small) {
                        ForEach(dietsViewModel.diets) { diet in
                            CheckboxRow(diet: diet, viewModel: dietsViewModel)
                        }
                    }
                    .padding()
                    Spacer()
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Back")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .cornerRadius(8)
                                .foregroundColor(AppColor.button)
                                .fontWeight(.bold)
                        }
                        NavigationLink(destination: AllergiesView(healthConcerns: healthConcerns, diets: dietsViewModel.selectedDiets)) {
                            Text("Next")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(AppColor.button)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .background(dietsViewModel.selectedDiets.isEmpty ? AppColor.disabled : AppColor.button)
                        }
                        .disabled(dietsViewModel.selectedDiets.isEmpty)
                    }
                    .padding()
                    ProgressBar(progress: dietsViewModel.selectedDiets.isEmpty ? 0.2 : 0.4)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CheckboxRow: View {
    let diet: DietsData
    @ObservedObject var viewModel: DietsViewModel
    
    @State private var isTooltipVisible = false
    
    var body: some View {
        HStack {
            CheckBox(checked: viewModel.selectedDiets.contains(diet),onTap: {
                viewModel.toggleSelection(for: diet)
            })
            Text(diet.name)
            InfoButton(action: {
                isTooltipVisible.toggle()
            })
            Spacer()
            if isTooltipVisible {
                TooltipView(text: diet.toolTip).onTapGesture {
                    isTooltipVisible = false
                }
            }
        }
        .padding(.vertical, CustomPadding.medium)
    }
}

struct CheckBox: View {
    var checked:Bool
    var onTap: (() -> Void)
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? AppColor.selected : .secondary)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
struct InfoButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "info.circle")
                .foregroundColor(.blue)
        }
    }
}

struct TooltipView: View {
    let text: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(text)
                    .font(.system(size: CustomFontSize.small))
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .transition(.scale)
            }
        }
    }
}

struct DietsView_Previews: PreviewProvider {
    static var previews: some View {
        DietsView( healthConcerns: [])
            .environmentObject(DietsViewModel.dummyData())
    }
}
