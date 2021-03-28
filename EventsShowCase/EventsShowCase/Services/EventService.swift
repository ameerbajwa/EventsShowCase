//
//  EventService.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/17/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EventService {
    
    let restAPIManager = RestAPIManager()
    
    func getEvents(onSuccess: @escaping (EventList) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let apiUrl = "/events"
        
        restAPIManager.httpRequest(apiUrl: apiUrl, httpMethod: "GET",
                onSuccess: {responseJSON -> Void in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let eventList: EventList!
                    do {
                        eventList = try decoder.decode(EventList.self, from: responseJSON)
                        onSuccess(eventList)
                    } catch {
                        print("unexpected error: \(error).")
                        onFailure(["error":error])
                    }
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
    
    func callCoreData(onSuccess: @escaping ([NSManagedObject]?) -> Void, onFailure: @escaping (String) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EventFavorited")
        var favoritedEvents: [NSManagedObject]?
        
        do {
            favoritedEvents = try managedContext.fetch(fetchRequest)
            onSuccess(favoritedEvents)
        } catch let error as NSError {
            onFailure("Could not fetch. \(error)")
        }
    }
    
}


