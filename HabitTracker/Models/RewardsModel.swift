//
//  RewardsModel.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-05-09.
//

import Foundation
import SwiftUI

struct RewardsModel : Identifiable {
    
    var title: String
    var rewardEmoji : String
    var done : Bool
    var backgroundColor = UIColor()
    let id = UUID()
    
}

