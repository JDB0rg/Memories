//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Madison Waters on 9/12/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    let localNotificationHelper = LocalNotificationHelper()
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        localNotificationHelper.requestAuthorization() { (success) in
            if success == success {
                    self.localNotificationHelper.scheduleDailyReminderNotification()
                    self.performSegue(withIdentifier: "onboardSegue", sender: nil)
///////////////// Doesn't seem to hit this /////////////////
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        localNotificationHelper.getAuthorizationStatus() { (settings) in
            if settings == .authorized {
                self.performSegue(withIdentifier: "onboardSegue", sender: nil)
///////////// Hits segue instantly /////////////////
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//In the button's action, call the requestAuthorization function of the localNotificationHelper. In the completion closure of this function, if it was successful, call the scheuleDailyReminderNotification() function. At this point, the onboarding view controller has done its job, so you can move the user to the main part of the application. To do this, trigger the manual segue by calling performSegue(withIdentifier: String, sender: Any?). The identifier should be the segue's identifier that you assigned in the storyboard between the onboarding view controller and the navigation controller. You can pass nil in for the sender.
//    Using the localNotificationHelper, call the getAuthorizationStatus method in the viewDidLoad(). This will allow you to check the current local notification authorization status, whether it has already been authorized, rejected, or not been requested at all. Since this onboarding view controller is meant only to ask the user for that authorization, create a conditional statement that will check the value of the status returned in the completion closure of the getAuthorizationStatus function. If the user has already authorized local notifications, then perform the manual segue to send them straight to the table view controller.
