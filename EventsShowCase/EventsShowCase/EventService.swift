//
//  EventService.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/17/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

class EventService {
    
    let restAPIManager = RestAPIManager()
    
    func getEvents(onSuccess: @escaping (Data) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let apiUrl = "/events"
        
        restAPIManager.httpRequest(apiUrl: apiUrl, httpMethod: "GET",
                onSuccess: {responseJSON -> Void in
                    onSuccess(responseJSON)
                },
                onFailure: { responseJSON -> Void in
                    onFailure(responseJSON)
                })
    }
    
    func getEvent(eventId: String, onSuccess: @escaping (Data) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let apiUrl = "/events/\(eventId)"
        
        restAPIManager.httpRequest(apiUrl: apiUrl, httpMethod: "GET",
                onSuccess: {responseJSON -> Void in
                    onSuccess(responseJSON)
                },
                onFailure: { responseJSON -> Void in
                    onFailure(responseJSON)
                })
    }
    
}


