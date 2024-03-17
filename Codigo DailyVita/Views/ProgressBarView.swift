//
//  ProgressBarView.swift
//  Codigo DailyVita
//
//  Created by Ibrahim Baisa on 16/03/24.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                Capsule()
                    .fill(Color.clear)
                    .frame(width: geometry.size.width, height: 10)
                
                Capsule()
                    .fill(AppColor.selected)
                    .frame(width: geometry.size.width * progress, height: 10)
            }
        }
        .padding(.top,CustomPadding.medium)
        .frame(width: .infinity, height: 10)
    }
}


struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 0.5)
    }
}
