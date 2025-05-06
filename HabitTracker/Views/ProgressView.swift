//
//  ProgressView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-30.
//

import SwiftUI

struct ProgressView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Habit.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.longestStreak, ascending: false)],
        animation: .default)
    
    private var habits: FetchedResults<Habit>
    
    var body: some View {
    
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Text("Progress")
                    .font(.system(size: 45))
                    .fontDesign(.monospaced)
                
                List {
                    ForEach(habits) { habit in
                        HStack{
                                Text(habit.title ?? "Title")
                                    .font(.title)
                            Spacer()
                                Text("Streak \(habit.longestStreak)")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(randomColor()))
                        .contentShape(Rectangle())
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 1))
                        .listRowBackground(Color.clear)

                    }
                }
                .scrollContentBackground(.hidden)
            }
            
        }
    }
    
    func randomColor() -> UIColor {
        
        let red = CGFloat(0.4 + drand48())
        let green = CGFloat(0.3 + drand48())
        let blue = CGFloat(0.3 + drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
    }
}

#Preview {
    ProgressView()
}
