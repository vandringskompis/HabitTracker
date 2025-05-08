//
//  CalendarView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-04-30.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable {
    
    var markedDays: [Date]
    
    func makeUIView(context: Context) -> FSCalendar {
            
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        calendar.allowsSelection = false
        calendar.scrollEnabled = true
        calendar.appearance.selectionColor = .green
        
        return calendar
    }
        
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        context.coordinator.markedDays = markedDays
        
        uiView.selectedDates.forEach { uiView.deselect($0)}
        
        for date in markedDays {
            uiView.select(date)
        }
        
        uiView.reloadData()
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(markedDays: markedDays)
    }
    
    class Coordinator : NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        
        var markedDays: [Date]
        let calendar = Calendar.current
        
        init(markedDays: [Date]) {
            self.markedDays = markedDays
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date : Date) -> Int {
            return 0
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date : Date) -> UIColor? {
            return markedDays.contains(where: { self.calendar.isDate($0, inSameDayAs: date) }) ? .green : nil
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date : Date ) -> UIColor? {
            if markedDays.contains(where: {  self.calendar.isDate($0, inSameDayAs: date) }) {
                return .white
            }
            return nil
        }
    }
}

#Preview {
    CalendarView(markedDays: [Date()])
}
