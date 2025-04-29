//
//  ViewExtensionCustomStyles.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-29.
//

import Foundation
import SwiftUI


extension View {
    
    func customStyleTextFields () -> some View {
        self
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 10.0, x: 20, y: 10)
            .fontDesign(.monospaced)
    }
    
    func customIcons () -> some View {
        HStack{
            Image(systemName: "figure.run")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .shadow(radius: 10.0, x: 20, y: 10)
            
            Image(systemName: "trophy.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .foregroundStyle(.yellow)
                .shadow(radius: 10.0, x: 20, y: 10)
        }
    }
    
    func customStyleButton () -> some View {
        self
            .padding()
            .background(Color.indigo)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(radius: 10.0, x: 20, y: 10)
            .fontDesign(.monospaced)
    }
}
