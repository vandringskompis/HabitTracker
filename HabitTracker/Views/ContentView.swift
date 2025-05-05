//
//  ContentView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-28.
//


import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Habit.entity(),
        sortDescriptors: [],
        animation: .default)
    private var habits: FetchedResults<Habit>
    
    @State var showAddHabitSheet = false

    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
       
        NavigationStack {
          
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack {
                    
                    HStack{
                        Spacer()
                        Text("Habits")
                            .font(.system(size: 45))
                            .fontDesign(.monospaced)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Button("New habit"){
                            showAddHabitSheet = true
                        }
                        .frame(width: 110, height: 50)
                        .background(Color.indigo)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 15))
                        .fontDesign(.monospaced)
                        
                        .sheet(isPresented: $showAddHabitSheet){
                            AddNewHabitView()
                                .presentationDetents([.height(300), .medium, .large])
                                .presentationDragIndicator(.automatic)
                        }
                        
                    }
                    .padding()
                    
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20){
                            ForEach(habits, id: \.self) {
                                habit in
                                NavigationLink(destination: HabitView(habit: habit)){
                                    HabitCardView(habit: habit)
                                        .foregroundStyle(Color.black)
                                    
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .tint(.black)
    }
}

struct HabitCardView : View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var isChecked : Bool = false
    
    var habit : Habit
    
    var body : some View {
        
        let myColor = randomColor()
        
            ZStack(alignment: .topTrailing) {
                
                VStack {
                    Text(habit.title ?? "Text")
                }
                .frame(width: 175, height: 75)
                .background(Color(myColor))
                .contentShape(Rectangle())
                .clipShape(.rect(cornerRadius: 15))
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1))
                
                
                Button(action: {
                    isChecked = true
                    NSLog("Knappen try")
                    updateStreak(habit: habit)
                    
                }) {
                    Circle()
                        .fill(isChecked ? Color.green : Color.gray)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "trophy")
                                .opacity(isChecked ? 1 : 0)
                                .foregroundStyle(.black)
                        )
                }
                .offset(x: 15, y: -15)
            }
        
            .onAppear {
                isChecked = checkIfDone()
            }
    }
    
    func checkIfDone () -> Bool{
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        
        if let lastCheck = habit.lastCheck {
            if calendar.isDate(lastCheck, inSameDayAs: today) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func updateStreak(habit : Habit) {
        
        print("UpdateStreak körs")
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        //let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
          
      
        
        if let lastCheck = habit.lastCheck {
            let daysBetween = calendar.dateComponents([.day], from: lastCheck, to: today).day ?? 0
            
            if (daysBetween == 1) {
                habit.streak += 1
                habit.lastCheck = today
                
                if (habit.longestStreak <= habit.streak) {
                    habit.longestStreak = habit.streak
                }
                
                do {
                    try viewContext.save()
                    print("streak +1")
                } catch {
                    print(error)
                }
                
            } else if (daysBetween > 1) {
                
                if (habit.longestStreak <= habit.streak) {
                    habit.longestStreak = habit.streak
                }
                
                habit.lastCheck = today
                habit.streak = 1
                
                do {
                    try viewContext.save()
                    print("streak = 0")
                    
                } catch {
                    print(error)
                }
                
            } else {
                habit.streak = 1
                habit.lastCheck = today
                
                do {
                    try viewContext.save()
                    print("streak = 1")
                } catch {
                    print(error)
                }
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
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
