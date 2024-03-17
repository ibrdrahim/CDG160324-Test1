//
//  AllergiesView.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//
import SwiftUI

struct HealthConcernsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var healthConcernsViewModel = HealthConcernsViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                AppColor.appTheme.ignoresSafeArea(edges: .all)
                VStack(alignment: .leading) {
                    Group{
                        Text("Select the top health concerns.")
                            .font(.title2) +
                        Text(" * \n").foregroundColor(AppColor.button)
                            .font(.title2) +
                        Text("(Up to 5)")
                            .font(.title2)
                    }.padding()
                    if(!healthConcernsViewModel.errorMessages.isEmpty){
                        Text(healthConcernsViewModel.errorMessages)
                            .font(.callout)
                                .foregroundColor(.pink)
                                .padding()
                    }
                    ScrollView{
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 200), spacing: 10)], spacing: 10) {
                                ForEach(healthConcernsViewModel.healthConcerns) { concern in
                                    Button(action: {
                                        healthConcernsViewModel.toggleSelection(concern)
                                       }) {
                                        Text(concern.name)
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .foregroundColor(healthConcernsViewModel.selectedConcerns.contains(concern) ?.white : AppColor.selected  )
                                            .background(healthConcernsViewModel.selectedConcerns.contains(concern) ? AppColor.selected : AppColor.appTheme)
                                            .cornerRadius(20)
                                            .lineLimit(1)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding()
                            
                    }.padding()
                    
                    if(!healthConcernsViewModel.selectedConcerns.isEmpty){
                        VStack(alignment:.leading){
                            Text("Prioritize")
                            .font(.title2)
                                
                            List{
                                ForEach(healthConcernsViewModel.selectedConcerns.indices, id: \.self) { index in
                                    HStack{
                                        Spacer().frame(width:CustomPadding.small)
                                        Text(healthConcernsViewModel.selectedConcerns[index].name)
                                            .padding(CustomPadding.small)
                                            .foregroundColor(.white)
                                            .background(AppColor.selected)
                                            .cornerRadius(20)
                                            .lineLimit(1)
                                        Spacer()
                                        Image(systemName: "line.horizontal.3")
                                            .padding()
                                            .onDrag {
                                                NSItemProvider(object: String(index) as NSString)
                                            }
                                    }
                                    .onDrag { NSItemProvider(object: String(index) as NSString) }
                                    .listRowBackground(AppColor.appTheme)
                                    .padding(CustomPadding.small)
                                    .overlay( /// apply a rounded border
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(AppColor.selected, lineWidth: 1)
                                    )
                                }
                                .onMove(perform: move)
                                .background{
                                    AppColor.appTheme.ignoresSafeArea(edges: .all)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .background(AppColor.appTheme)
                            .scrollContentBackground(.hidden)
                        }.padding()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                                Text("Back")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .cornerRadius(8)
                                .foregroundColor(AppColor.button)
                                .fontWeight(.bold)
                        }
                        NavigationLink(destination: DietsView(healthConcerns: healthConcernsViewModel.selectedConcerns)){
                                Text("Next")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(healthConcernsViewModel.selectedConcerns.isEmpty ? AppColor.disabled : AppColor.button)
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .disabled(healthConcernsViewModel.selectedConcerns.isEmpty)
                        Spacer()
                    }.padding()
                    ProgressBar(progress: healthConcernsViewModel.selectedConcerns.isEmpty ? 0 : 0.2)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        healthConcernsViewModel.selectedConcerns.move(fromOffsets: source, toOffset: destination)
        healthConcernsViewModel.objectWillChange.send() // Trigger manual notification
    }
}

struct HealthConcernsView_Previews: PreviewProvider {
    static var previews: some View {
        HealthConcernsView()
    }
}
