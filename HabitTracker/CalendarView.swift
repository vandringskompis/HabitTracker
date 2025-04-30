//
//  CalendarView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-30.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> FSCalendar {
            let calendar = FSCalendar()
            // Konfigurera kalendern om det behövs
            return calendar
        }

        func updateUIView(_ uiView: FSCalendar, context: Context) {
            // Uppdatera kalendern om det behövs
        }
}

#Preview {
    CalendarView()
}
