//
//  EventModel.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/18/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

class Event: Decodable {
    var type: String
    var id: Int
    var datetimeUtc: String
    var datetimeLocal: String
    var venue: Venue
    var datetimeTbd: Bool
    var shortTitle: String
    var title: String
    var url: String
    var taxonomies: [Taxonomies]
    var performers: [Performer]
}

class Venue: Decodable {
    var id: Int
    var name: String
    var displayLocation: String
    var address: String
    var city: String
    var state: String
    var country: String
}

class Taxonomies: Decodable {
    var id: Int
    var name: String
}

class Performer: Decodable {
    var id: Int
    var type: String
    var name: String
    var image: String
    var homeTeam: Bool?
}
