//
//  RewardViewModel.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-05-07.
//

import Foundation
import CoreData

class RewardViewModel : ObservableObject {
    
    let viewContext : NSManagedObjectContext
    
    @Published var reward : Reward
    
    init(reward: Reward, context: NSManagedObjectContext) {
            self.reward = reward
            self.viewContext = context
        }
    
    
    
        
    
    
    
    
}
