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
                        .sorted { filterLogsCount(habit: $0, daysBack: selectedFilters()) > filterLogsCount(habit: $1, daysBack: selectedFilters()) }, id: \.self) { habit in
                            HStack{
                                Text(habit.title ?? "Title")
                                    .font(.title)
                                Spacer()
                                Text("\(filterLogsCount(habit: habit, daysBack: selectedFilters()))")
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
            return 0
            
        case "Week":
            return 7
            
        case "Month":
            return 30
            
        default:
            return 1000
        }
    }
    
    
    /**
     Count all the days a habit has been done, in a specific timeline. DaysBack is 1, 7, 30 or 1000 which is today, week, month and 1000 days.
     */
    
    func filterLogsCount(habit : Habit, daysBack: Int) -> Int {
        
        let calendar = Calendar.current
        
        
        let logs = (habit.logs as? Set<HabitLog>) ?? []
        
        // Look for every date that a habit has been done.
        // Filter the days from startDate to now.
        // Count the days that are filtered.
        
        if daysBack == 0 {
            
            return logs
                .compactMap { $0.date}
                .filter { calendar.isDateInToday($0)}
                .count
            
        } else {
            
            let now = calendar.startOfDay(for: Date())
            let startDate = calendar.date(byAdding: .day, value: -daysBack, to: now) ?? now
            
            return logs
                .compactMap { $0.date}
                .filter { $0 >= startDate}
                .count
        }
    }
}

#Preview {
    ProgressView()
}
