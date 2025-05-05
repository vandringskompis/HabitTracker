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
                    Spacer()
                    Text("Laga mat")
                        .font(.system(size: 30))
                        .fontDesign(.monospaced)
                        .shadow(radius: 10.0, x: 20, y: 10)
            
                    /* if let title = habit.title {
                         Text(title)
                     }*/
                    Spacer()
                    
                    Image(systemName: "bell")
                    Image(systemName: "trash")
                    
                }
                .padding()
                
                
                HStack{
                    CalendarView()
                        .padding(30)
                }
                
                Spacer()
                
                HStack{
                    Text("Streak: \n     0")
                        .font(.title)
                    //Text("\(habit.streak)")
                    
                    Spacer()
                    
                    Text("Longest Streak: \n              6")
                        .font(.title)
                    //Text("\(habit.longestStreak)")
                    
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    
    HabitView()
}
