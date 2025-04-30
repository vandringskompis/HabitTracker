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
        NavigationView {
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
                           // addHabit()
                            print("Hej")
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
                            ForEach(habits) {
                                habit in
                                HabitCardView(habit: habit)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { habits[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()



struct HabitCardView : View {
    
    @State var isChecked = false
    
    var habit : Habit
    
    var body : some View {
        let myColor = randomColor()
       
        ZStack(alignment: .topTrailing) {
            
            VStack {
                Text(habit.title ?? "2")
            }
            .onTapGesture {
                print("Kort tryckts")
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
