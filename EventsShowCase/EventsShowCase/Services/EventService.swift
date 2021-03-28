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
    
    func getEvent(eventId: Int, onSuccess: @escaping (Event) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let apiUrl = "/events/\(eventId)"
        
        restAPIManager.httpRequest(apiUrl: apiUrl, httpMethod: "GET",
                onSuccess: {responseJSON -> Void in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let event: Event!
                    do {
                        event = try decoder.decode(Event.self, from: responseJSON)
                        onSuccess(event)
                    } catch {
                        print("unexpected error: \(error).")
                        onFailure(["error":error])
                    }
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
    
    func updateCoreData(id: Int, favorited: Bool, favoritedEventsDict: [Int: Bool]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if favoritedEventsDict[id] == nil {
            let entity = NSEntityDescription.entity(forEntityName: "EventFavorited", in: managedContext)!
            let eventFavorited = NSManagedObject(entity: entity, insertInto: managedContext)
            
            eventFavorited.setValue(id, forKeyPath: "id")
            eventFavorited.setValue(favorited, forKeyPath: "favorited")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } else {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EventFavorited")
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
            var favoritedEvents: [NSManagedObject]?
            do {
                favoritedEvents = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                if favoritedEvents?.count != 0 {
                    favoritedEvents?[0].setValue(favorited, forKey: "favorited")
                }
            } catch {
                print("Fetch Failed: \(error)")
            }

            do {
                try managedContext.save()
               }
            catch {
                print("Saving Core Data Failed: \(error)")
            }
        }

    }
    
}


