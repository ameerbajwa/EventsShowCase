//
//  EventViewModel.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/20/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

struct EventViewModel {
    
    var date = Date()
    
    var id: Int
    var name: String
    var location: String
    var time: String
    var images: [String]
    
    // Dependency Injection
    init(event: Event) {
        self.id = event.id
        self.name = event.title
        self.location = event.venue.displayLocation
        self.time = event.datetimeUtc
        self.images = []
        for performer in event.performers {
            if let isPerformerTheHomeTeam = performer.homeTeam {
                if isPerformerTheHomeTeam {
                    self.images.append(performer.image)
                }
            } else {
                self.images.append(performer.image)
            }
            print(performer.image)
        }
        
    }
    
    mutating func formattedTime(eventTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        date = dateFormatter.date(from: eventTime) ?? Date(timeInterval: -1000000, since: Date())
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
        return dateFormatter.string(from: date)
    }
}
