//
//  UNService.swift
//  Remind
//
//  Created by SpaGettys on 2018/02/08.
//  Copyright © 2018 spagettys. All rights reserved.
//

import Foundation
import UserNotifications

class UNService: NSObject {
    
    // prevents you from making your "own" class. Instead we are using the "singleton."
    private override init() {}
    static let shared = UNService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func authroize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No UN auth error")
            guard granted else {
                print("User Denied Access")
                return
            }
            self.configure()
        }
    }
    
    func configure(){
        unCenter.delegate = self
    }
    
    func timerRequest(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer is all done. YAY!"
        content.sound = .default()
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats:false)
        let request = UNNotificationRequest(identifier: "userNotification.timer",
                                            content: content,
                                            trigger: trigger)
        
        unCenter.add(request)
    }
    
    func dateRequest(with components: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = "Date Trigger"
        content.body = "It is now the future!"
        content.sound = .default()
        content.badge = 1
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: "userNotification.date",
                                            content: content,
                                            trigger: trigger)
        
        unCenter.add(request) 
    }
    
    func locationRequest(){
        let content = UNMutableNotificationContent()
        content.title = "You have returned"
        content.body = "Welcome back you still coder you!"
        content.sound = .default()
        content.badge = 1
        
        //we're not using UNLocationNotificationTrigger because apparently it's not consistent and causes people problems
        //UNLocationNotificationTrigger
        
        // since this has no trigger, it will fire imediately
        let request = UNNotificationRequest(identifier: "userNotification.location", content: content, trigger: nil)
        
        unCenter.add(request)
        
        
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("UN did receive response")
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("UN will present notification")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}
