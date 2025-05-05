//
//  HabitView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-30.
//

import SwiftUI

struct HabitView: View {
    
    var habit : Habit
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var showDeleteView = false
    
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
            
                     if let title = habit.title {
                         Text(title)
                             .font(.system(size: 30))
                             .fontDesign(.monospaced)
                             .shadow(radius: 10.0, x: 20, y: 10)
                         
                             .alert("Are you sure you want to delete \"\(title)\"", isPresented: $showDeleteView) {
                                 Button("Delete", role: .destructive) {
                                     deleteHabit()
                                 }
                                 Button("Cancel", role: .cancel) {}
                             }
                     }
                    Spacer()
                    
                    Image(systemName: "bell")
                    Image(systemName: "trash")
                        .onTapGesture {
                            showDeleteView = true
                        }
                    
                }
                .padding()
                
                
                HStack{
                    CalendarView()
                        .padding(30)
                }
                
                Spacer()
                
                HStack{
                    Text("Streak: \n    \(habit.streak)")
                        .font(.title)
                    
                    Spacer()
                    
                    Text("Longest Streak: \n              \(habit.longestStreak)")
                        .font(.title)
                    
                    
                }
                .padding()
            }
        }
    }
    
    func deleteHabit() {
        viewContext.delete(habit)
        do {
            try viewContext.save()
            print("Habit deleted. Success!")
            dismiss()
        } catch {
            print("Error. Did not delete habit: \(error.localizedDescription)")
        }
    }
}
