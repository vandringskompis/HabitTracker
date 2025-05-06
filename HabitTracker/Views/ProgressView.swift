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
        sortDescriptors: [],
        animation: .default)
    
    private var habits: FetchedResults<Habit>
    
    @State var selectedFilter : String = "Today"
    
    let filters = ["Today", "Week", "Month", "All time"]
    
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
                
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(filters, id: \.self) { filter in
                        Text(filter)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    ForEach(Array(habits)
                        .sorted { $0.streak > $1.streak }, id: \.self) { habit in
                        HStack{
                                Text(habit.title ?? "Title")
                                    .font(.title)
                            Spacer()
                            Text("Streak: \(filterLogsCount(habit: habit, daysBack: selectedFilters()))")
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
    
    func selectedFilters() -> Int {
        
        switch selectedFilter {
            
        case "Today":
            return 1
        
        case "Week":
            return 7
            
        case "Month":
            return 30
            
        default:
            return 1000
        }
    }
    
    func filterLogsCount(habit : Habit, daysBack: Int) -> Int {
        
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -daysBack, to: Date()) ?? Date()
        
        let logs = (habit.logs as? Set<HabitLog>) ?? []
        
        return logs
            .compactMap { $0.date}
            .filter { $0 >= startDate}
            .count
    }
}

#Preview {
    ProgressView()
}
