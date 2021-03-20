//
//  EventsViewModel.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/19/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

class EventsViewModel: NSObject {
    
    let eventService = EventService()

    private(set) var eventList : EventList! {
        didSet {
            self.bindEventsViewModelToEventListViewController()
        }
    }
    
    var bindEventsViewModelToEventListViewController : (() -> ()) = {}
    
    override init() {
        super.init()
        eventService.getEvents(onSuccess: { (response) in
            print("success")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.eventList = try decoder.decode(EventList.self, from: response)
            } catch {
                print("unexpected error: \(error).")
            }
            if let events = self.eventList {
                for event in events.events {
                    print("\(event.datetimeLocal) \(event.title) \(event.type) \(event.venue.displayLocation) \(event.performers[0].name)")
                }
            }
        }) { (error) in
            print("error")
        }
    }

}
