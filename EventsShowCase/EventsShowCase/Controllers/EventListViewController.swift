//
//  ViewController.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/17/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {
    
    let eventService = EventService()
    private var eventsViewModel = [EventViewModel]()
    var eventListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setUpTableView()
        getEventListAPICall()
    }
    
    func setUpTableView() {
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
        
        self.view.addSubview(eventListTableView)
        eventListTableView.translatesAutoresizingMaskIntoConstraints = false
        eventListTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        eventListTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        eventListTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        eventListTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        eventListTableView.rowHeight = UITableView.automaticDimension
        eventListTableView.estimatedRowHeight = 200
        eventListTableView.register(EventListCell.self, forCellReuseIdentifier: "eventListCell")
    }
    
    func getEventListAPICall() {
        eventService.getEvents(onSuccess: { (response) in
            print("success")
            let events = response.events
            self.eventsViewModel = events.map({return EventViewModel(event: $0)})
            DispatchQueue.main.async {
                self.eventListTableView.reloadData()
            }
        }) { (error) in
            print("error")
        }
    }

}

extension EventListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsViewModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventListCell", for: indexPath) as? EventListCell
        cell?.eventViewModel = eventsViewModel[indexPath.row]
        return cell!
    }
    
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

