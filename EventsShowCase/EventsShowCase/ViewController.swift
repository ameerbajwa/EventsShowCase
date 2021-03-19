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
    var event: Event?
    
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
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.event = try decoder.decode(Event.self, from: response)
                print(self.event?.title)
                print(self.event?.datetimeLocal)
                print(self.event?.venue.displayLocation)
                print(self.event?.performers[0].image)
            } catch {
                print("unexpected error: \(error).")
            }
        }) { (error) in
            print("error")
        }
    }

}

