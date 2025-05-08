//
//  NotificationsSettingsView.swift
//  HabitTracker
//
//  Created by Camilla Falk on 2025-05-07.
//

import SwiftUI
import UserNotifications

struct NotificationsSettingsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Notification.entity(),
        sortDescriptors: [],
        animation: .default)
    
    private var notifications: FetchedResults<Notification>
    
    @Environment(\.dismiss) var dismiss
    
    var habit : Habit
    
    @Binding var bellIcon : String
    @State var selectedDate = Date()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            VStack {
                
                Text("Schedule notifiction")
                    .font(.system(size: 45))
                    .fontDesign(.monospaced)
                    .multilineTextAlignment(.center)
                
                
                //Checks if a notification is already scheduled. Show time it is scheduled or say that no notification is schedueled.
                
                if let scheduledNotification = scheduledNotification() {
                    Text("Notification scheduled at: \(scheduledNotification.formatted(date: .omitted, time: .shortened))")
                        .fontDesign(.monospaced)
                } else {
                    Text("No notification scheduled")
                }
                    
                
                Spacer()
                
                DatePicker("Choose a time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                
                Spacer()
                
                HStack{
                   
                    Button("Delete") {
                        bellIcon = "bell.slash"
                        deleteNotification()
                        dismiss()
                    }
                    .foregroundStyle(.red)
                    
                    Spacer()
                    Button("Set time") {
                        setNotificationTime(habit: habit, at: selectedDate)
                        bellIcon = "bell"
                        dismiss()
                    }
                    .customStyleButton()
                }
            }
            .padding()
            
        }
    }
    
    func setNotificationTime(habit : Habit, at date : Date) {
        
        if let existingNotification = habit.notify as? Set<Notification> {
            let center = UNUserNotificationCenter.current()
            
            for notification in existingNotification {
                if let id = notification.notificationID {
                    center.removePendingNotificationRequests(withIdentifiers: [id])
                }
                viewContext.delete(notification)
            }
        }
        
        
        let content = UNMutableNotificationContent()
        
        if let title = habit.title{
            content.title = "\(title)"
            content.subtitle = "Time for \(title)!"
            content.sound = UNNotificationSound.default
            
            let newId = UUID().uuidString
            
            let dataComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: newId, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    
                }
            }
            
            let newNotification = Notification(context: viewContext)
            
            newNotification.notificationID = newId
            newNotification.time = date
            
            habit.addToNotify(newNotification)
            
            newNotification.id = habit
            
            do {
                try viewContext.save()
            } catch {
                print("New notificationId not added")
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func scheduledNotification() -> Date? {
        
        if let notifications = habit.notify as? Set<Notification>,
           let notification = notifications.first,
           let time = notification.time {
            return time
        }
        return nil
    }
    
    func deleteNotification() {
        if let notifications = habit.notify as? Set<Notification> {
            
            for notification in notifications {
                
                if let id = notification.notificationID {
                    let center = UNUserNotificationCenter.current()
                    center.removePendingNotificationRequests(withIdentifiers: [id])
                }
                viewContext.delete(notification)
            }
            do {
                try viewContext.save()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

