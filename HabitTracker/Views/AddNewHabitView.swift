//
//  AddNewHabitView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-30.
//

import SwiftUI

struct AddNewHabitView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        entity: Reward.entity(),
        sortDescriptors: [],
        animation: .default)
    
    private var rewards: FetchedResults<Reward>
    
    @Environment(\.dismiss) var dismiss
    
    @State var title : String = ""
   
    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                    
                VStack {
                    Spacer()
                    Text("Yes!")
                        .font(.title)
                        .fontDesign(.monospaced)
                    
                    Text("Let's add a new habit!")
                        .font(.title)
                        .fontDesign(.monospaced)
                    
                    VStack(alignment: .leading){
                        
                        Spacer()
                        Text("New habit")
                            .fontDesign(.monospaced)
                        
                        TextField("Habit", text: $title)
                            .customStyleTextFields()
                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            Button("Add habit"){
                                addHabit()
                                dismiss()
                            }
                            .customStyleButton()
                            Spacer()
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    func addHabit() {
        withAnimation {
            let newHabit = Habit(context: viewContext)
            
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            newHabit.title = title
            newHabit.streak = 0
            newHabit.longestStreak = 0
            
            if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
                newHabit.lastCheck = yesterday
            }
            
            do {
                try viewContext.save()
            } catch {
                print("New habit not added")
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    AddNewHabitView()
}
