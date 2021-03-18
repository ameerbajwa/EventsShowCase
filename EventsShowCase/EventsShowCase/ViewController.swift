//
//  ViewController.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/17/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eventService = EventService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        eventService.getEvents(onSuccess: { (response) in
//            print("success")
//        }) { (error) in
//            print("error")
//        }
        
        eventService.getEvent(eventId: "5370958", onSuccess: { (response) in
            print("success")
        }) { (error) in
            print("error")
        }
    }


}

