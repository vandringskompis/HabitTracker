//
//  HabitView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-30.
//

import SwiftUI

struct HabitView: View {
    
    //var habit : Habit
    
    var body: some View {
        
        ZStack{
        LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
        
            VStack{
                HStack{
                    Spacer()
                    Text("Laga mat")
                        .font(.system(size: 35))
                        .fontDesign(.monospaced)
                        .shadow(radius: 10.0, x: 20, y: 10)
            
                    Spacer()
                    
                   /* if let title = habit.title {
                        Text(title)
                    }*/
                }
                Spacer()
                
                HStack{
                    Text("Streak: \n     0")
                        .font(.title)
                    
                    Spacer()
                    
                    Text("Longest Streak: \n              6")
                        .font(.title)
                    
                    //Text("\(habit.streak)")
                }
                .padding()
            }
        }
    }
}

#Preview {
    
    HabitView()
}
