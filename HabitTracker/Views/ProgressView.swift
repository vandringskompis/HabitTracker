//
//  ProgressView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-30.
//

import SwiftUI

struct ProgressView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Text("Exempeltext")
            }
            .frame(width: 175, height: 75)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1))
            .contentShape(Rectangle())
            .onTapGesture {
                print("Kort tryckts")
            }
            
            Button(action: {
                print("Knapp tryckts")
            }) {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 40, height: 40)
            }
            .offset(x: 15, y: -15)
        }
    }
}

#Preview {
    ProgressView()
}
