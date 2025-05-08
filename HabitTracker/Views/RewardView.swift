//
//  RewardView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-05-05.
//

import SwiftUI

struct RewardView: View {
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
           
            Text("Rewards")
        }
    }
}

#Preview {
    RewardView()
}
