//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Madison Waters on 9/12/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    
//////// Functions used with all Apps using Local Notification ////////
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
//////// End of Functions used with all Apps using Local Notification ////////
    
    func scheduleDailyReminderNotification() {
        // Unique Identifier
        let indentifier = "DailyReminder"
        
        // What are we displaying on the notification
        let content = UNMutableNotificationContent()
        content.title = "Don't forget!"
        content.body = "A habit of creating a memory daily can pay off in the long run\n."
        content.subtitle = "Record a memory today!"
        
        content.badge = 1
        
        // When the notification gets shown
        var date = DateComponents()
        date.hour = 16
        date.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // The notification
        let request = UNNotificationRequest(identifier: indentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                NSLog("Error adding Notification \(error)")
            }
        }
    }
    
    
}
