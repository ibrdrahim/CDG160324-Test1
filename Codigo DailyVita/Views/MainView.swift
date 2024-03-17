//
//  ContentView.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColor.appTheme.ignoresSafeArea(edges: .all)
                
                VStack {
                    Text("Welcome to DailyVita")
                        .foregroundColor(AppColor.selected)
                        .padding(.top, CustomPadding.large)
                        .padding(.horizontal, CustomPadding.medium)
                        .font(.system(size: CustomFontSize.title))
                        .fontWeight(.bold)
                    
                    Text("Hello, we are here to make your life healthier and happier.")
                        .foregroundColor(AppColor.selected)
                        .padding(.top, CustomPadding.large)
                        .padding(.horizontal, CustomPadding.medium)
                        .font(.system(size: CustomFontSize.title))
                        .fontWeight(.bold)
                    
                    Image("onboarding")
                        .resizable()
                        .frame( height: 300)
                    
                    Text("We will ask a couple of questions to better understand your vitamin need.")
                        .foregroundColor(AppColor.selected)
                        .padding(.top, CustomPadding.large)
                        .padding(.horizontal, CustomPadding.medium)
                        .font(.system(size: CustomFontSize.medium))
                    
                    Spacer()
                    
                    NavigationLink(destination: HealthConcernsView()){
                        Text("Get Started")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(AppColor.button)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(CustomPadding.medium)
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
}
