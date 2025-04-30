//
//  AddNewHabitView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-30.
//

import SwiftUI

struct AddNewHabitView: View {
    @Environment(\.managedObjectContext) var viewContext
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
            newHabit.title = title
            newHabit.streak = 0
            newHabit.longestStreak = 0

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
