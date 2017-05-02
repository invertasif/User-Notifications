//
//  ViewController.swift
//  Notifications
//
//  Created by Asif Ikbal on 4/27/17.
//  Copyright © 2017 Asif Ikbal. All rights reserved.
//

import UIKit
import  UserNotifications


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        shouldNotification()
    }


    func shouldNotification() {
        
        // create the content
        let content = UNMutableNotificationContent()
        content.title = "10 seconds"
        content.subtitle = "alert"
        content.body = "Showing notification after 10 seconds"
        content.sound = UNNotificationSound.default()
        content.badge = 4
        content.userInfo = ["id":201]

        let imageURL = Bundle.main.url(forResource: "image", withExtension: "gif")
        do{
            content.attachments.append(try UNNotificationAttachment(identifier: "image", url: imageURL!, options: [:]))
        }
        catch{
           
        }
        
        // create the trigger 
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    
        // create the request 
        let request =  UNNotificationRequest(identifier: "10s", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        UNUserNotificationCenter.current().delegate = self
        
    }

}

//MARK: Notification Delegate
extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo["id"] ?? 0)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound,.badge])
    }
}
