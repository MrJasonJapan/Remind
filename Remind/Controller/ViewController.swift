//
//  ViewController.swift
//  Remind
//
//  Created by SpaGettys on 2018/02/07.
//  Copyright © 2018 spagettys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get permision from our users to use NotificationCenter and CoreLocation
        UNService.shared.authroize()
        CLService.shared.authorize()
        
        // Set ourself as the observer for our entered Region event inside CLService.swift
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterRegion),
                                               name: NSNotification.Name("internalNotification.enteredRegion"),
                                               object: nil)
        
        //internalNotification.handleAction
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAction(_:)),
                                               name: NSNotification.Name("internalNotification.handleAction"),
                                               object: nil)
    }

    @IBAction func OnTimerTapped(){
        print("timer")
        
        AlertService.actionSheet(in: self, title: "5 Seconds") {
            UNService.shared.timerRequest(with: 5)
        }
        
    }
    
    @IBAction func OnDateTapped(){
        print("date")
        
        AlertService.actionSheet(in: self, title: "Some future time") {
        
            var components = DateComponents()
            components.second = 0
            //components.weekday = 4 // Wednesday
            
            UNService.shared.dateRequest(with: components)
        }
    }
    
    @IBAction func OnLocationTapped(){
        print("location")
        
        AlertService.actionSheet(in: self, title: "When I return") {
            CLService.shared.updateLocation()
        }
    }
    
    @objc
    func didEnterRegion() {
        UNService.shared.locationRequest()
    }
    
    // here is all of our application's logic in response to interaction with our notifications.
    @objc
    func handleAction(_ sender: Notification) {
        guard let action = sender.object as? NotificationActionID else { return }
        switch action {
        case .timer: print("timer logic")
        case.date: print("date logic")
        case.location: changeBackground()
        }
    }
    
    func changeBackground() {
        view.backgroundColor = .red
    }


}

