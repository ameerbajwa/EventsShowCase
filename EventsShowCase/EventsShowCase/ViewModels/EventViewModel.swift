//
//  EventViewModel.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/20/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit
import Foundation
import CoreData

struct EventViewModel {
    
    var date = Date()
    
    var id: Int
    var name: String
    var location: String
    var time: String
    var imageStringUrls: [String]
    var imagesOfData: Data?
    
    var favoritedEvent: [NSManagedObject]?
//    var isEventFavorited: [Int: Bool]
    var favorited: Bool?
    
    // Dependency Injection
    init(event: Event) {
        self.id = event.id
        self.name = event.title
        self.location = event.venue.displayLocation
        self.time = event.datetimeUtc
        self.imageStringUrls = []
        for performer in event.performers {
            if let isPerformerTheHomeTeam = performer.homeTeam {
                if isPerformerTheHomeTeam {
                    self.imageStringUrls.append(performer.image)
                }
            } else {
                self.imageStringUrls.append(performer.image)
            }
        }
        self.imagesOfData = nil
        self.favorited = false
    }
    
    mutating func formattedTime(eventTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        date = dateFormatter.date(from: eventTime) ?? Date(timeInterval: -1000000, since: Date())
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
        return dateFormatter.string(from: date)
    }
    
    func setImage(stringUrl: String) -> Data? {
        guard let imageURL = URL(string: stringUrl) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }

        return imageData
    }
}
