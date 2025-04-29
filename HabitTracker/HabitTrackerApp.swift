//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-28.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomePageView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
