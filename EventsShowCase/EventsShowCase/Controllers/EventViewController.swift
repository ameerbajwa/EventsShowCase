//
//  EventViewController.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/27/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    let eventService = EventService()
    var eventView = EventView()
//    var selectedEventId: Int?
    var eventViewModel: EventViewModel?
    var favoritedEventsDict: [Int:Bool]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.main.async {
        self.eventView = EventView.init(frame: CGRect(x: 0, y: self.view.safeAreaLayoutGuide.layoutFrame.origin.y + (self.navigationController?.navigationBar.frame.size.height)!, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.eventView.eventViewModel = eventViewModel
        self.eventView.eventFavoritedButton.addTarget(self, action: #selector(self.eventFavoritedButtonPressed), for: .touchUpInside)
        self.view.addSubview(self.eventView)
//        }
        
//        getEventAPICall { (eventviewmodel) in
//
//        }
    }
    
//    func getEventAPICall(onSuccess: @escaping (EventViewModel) -> Void) {
//        if let id = selectedEventId {
//            eventService.getEvent(eventId: id, onSuccess: { (response) in
//                print("success")
//                self.eventViewModel = EventViewModel(event: response)
//                onSuccess(self.eventViewModel!)
//            }) { (error) in
//                print("error")
//            }
//        }
//    }
    
    @objc func eventFavoritedButtonPressed() {
        if var evm = self.eventViewModel {
            evm.favorited = !(evm.favorited!)
            DispatchQueue.main.async {
                if evm.favorited == true {
                    self.eventView.eventFavoritedButton.setImage(UIImage(named: "heartFilled"), for: .normal)
                } else {
                    self.eventView.eventFavoritedButton.setImage(UIImage(named: "heartEmpty"), for: .normal)
                }
            }
            
            eventService.updateCoreData(id: evm.id, favorited: evm.favorited!, favoritedEventsDict: favoritedEventsDict!)
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
