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

var rewardList = [
    
    RewardsModel(title: "1 habit", rewardEmoji: "🥉" , done: false, backgroundColor: .red),
    RewardsModel(title: "10 habit", rewardEmoji: "🥈" , done: false, backgroundColor: .yellow),
    RewardsModel(title: "30 habit", rewardEmoji: "🥇" , done: false, backgroundColor: .blue),
    RewardsModel(title: "100 habit", rewardEmoji: "🏆" , done: false, backgroundColor: .systemIndigo),
    RewardsModel(title: "1 notification", rewardEmoji: "🥉" , done: false, backgroundColor: .red),
    RewardsModel(title: "10 notifications", rewardEmoji: "🥈" , done: false, backgroundColor: .yellow),
    RewardsModel(title: "30 notifications", rewardEmoji: "🥇" , done: false, backgroundColor: .blue),
    RewardsModel(title: "100 notifications", rewardEmoji: "🏆" , done: false, backgroundColor: .systemIndigo),
    RewardsModel(title: "?", rewardEmoji: "🥉" , done: false, backgroundColor: .red),
    RewardsModel(title: "?", rewardEmoji: "🥈" , done: false, backgroundColor: .yellow),
    RewardsModel(title: "?", rewardEmoji: "🥇" , done: false, backgroundColor: .blue),
    RewardsModel(title: "?", rewardEmoji: "🏆" , done: false, backgroundColor: .systemIndigo)
    
]

