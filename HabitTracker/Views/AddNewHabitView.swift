//
//  AddNewHabitView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-30.
//

import SwiftUI
import CoreData

struct AddNewHabitView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        entity: Reward.entity(),
        sortDescriptors: [],
        animation: .default)
    
    private var rewards: FetchedResults<Reward>
    
    @FetchRequest(
        entity: AddHabits.entity(),
        sortDescriptors: [],
        animation: .default)
    
    private var addHabitsCoreData: FetchedResults<AddHabits>
        
    @Environment(\.dismiss) var dismiss
    
    @State var title : String = ""
    @State var rewardTitleAlert = ""
    @State var showRewardAlert = false
   
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
                                if !showRewardAlert {
                                    dismiss()
                                }
                            }
                            .customStyleButton()
                            Spacer()
                        }
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showRewardAlert) {
            Alert(title: Text("Reward unlocked!"),
                  message: Text("\"\(rewardTitleAlert)\""),
                  dismissButton: .default(Text("Wohoo!!")) {
                dismiss()
            }
            )}
    }
    
    func addHabit() {
        let newHabit = Habit(context: viewContext)
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        newHabit.title = title
        newHabit.streak = 0
        newHabit.longestStreak = 0
            
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
                newHabit.lastCheck = yesterday
        }
            
        let fetchAddHabitsCount : NSFetchRequest<AddHabits> = AddHabits.fetchRequest()
            
        if let existingCount = try? viewContext.fetch(fetchAddHabitsCount).first {
            
            existingCount.count += 1
            if let rewardTitle = addToRewardList(for: Int(existingCount.count)) {
                rewardTitleAlert = "🎉 \(rewardTitle) unlocked!"
                showRewardAlert = true
            }
            
        } else {
            let newCount = AddHabits(context: viewContext)
            newCount.count = 1
            if let rewardTitle = addToRewardList(for: 1) {
                rewardTitleAlert = "🎉 \(rewardTitle) unlocked!"
                showRewardAlert = true
            }
        }
        
        do {
            try viewContext.save()
                
            } catch {
                print("New habit not added")
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    
    func addToRewardList(for count : Int) -> String? {
        
        guard [1, 10, 30, 100].contains(count) else {return nil}
        
        let addHabitsReward = Reward(context: viewContext)

        switch count {
        case 1:
            addHabitsReward.title = "Added 1 habit"
            addHabitsReward.emoji = "🥉"
        case 10:
            addHabitsReward.title = "Added 10 habit"
            addHabitsReward.emoji = "🥈"
        case 30:
            addHabitsReward.title = "Added 30 habit"
            addHabitsReward.emoji = "🥇"
        case 100:
            addHabitsReward.title = "Added 100 habit"
            addHabitsReward.emoji = "🏆"
        default:
            break
        }
        
        return addHabitsReward.title
    }
}

#Preview {
    AddNewHabitView()
}
