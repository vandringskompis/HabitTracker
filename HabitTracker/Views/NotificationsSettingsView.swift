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
                
                
                Spacer()
                
                DatePicker("Choose a time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                
                Spacer()
                
                HStack{
                   
                    Button("Delete") {
                        bellIcon = "bell.slash"
                        
                        if let notifications = habit.notify as? Set<Notification> {
                            
                            for notification in notifications {
                                
                                if let id = notification.notificationID {
                                    let center = UNUserNotificationCenter.current()
                                    center.removePendingNotificationRequests(withIdentifiers: [id])
                                }
                            }
                        }
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
}

