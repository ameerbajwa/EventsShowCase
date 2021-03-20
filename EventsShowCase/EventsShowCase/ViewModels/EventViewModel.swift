//
//  EventViewModel.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/20/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

struct EventViewModel {
    
    var id: Int
    var name: String
    var location: String
    
    // Dependency Injection
    init(event: Event) {
        self.id = event.id
        self.name = event.title
        self.location = event.venue.displayLocation
    }

}
