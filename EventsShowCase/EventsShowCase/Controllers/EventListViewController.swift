//
//  ViewController.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/17/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit
import CoreData

class EventListViewController: UIViewController {
    
    let eventService = EventService()
    private var eventsViewModel = [EventViewModel]()
    var filteredEventsViewModel = [EventViewModel]()
    var selectedEventViewModel: EventViewModel?
    var dataIsLoaded: Bool = false
//    var selectedEventId: Int = 0
//    var favoritedEvents: [NSManagedObject]?
    var favoritedEventsDict: [Int:Bool] = [:]
    var eventListTableView = UITableView()
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 156/255, green: 194/255, blue: 255/255, alpha: 1.0)
        setUpTableView()
        setUpSearchBar()
//        getEventListAPICall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataIsLoaded = false
        favoritedEventsDict = [:]
        filteredEventsViewModel = []
        eventsViewModel = []
        getEventListAPICall()
    }
    
    func setUpSearchBar() {
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        searchBar.backgroundColor = UIColor.init(red: 156/255, green: 194/255, blue: 255/255, alpha: 1.0)
        searchBar.searchTextField.textColor = UIColor.white
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        searchBar.placeholder = "Search Events"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func setUpTableView() {
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
//        eventListTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .grouped)
        
        self.view.addSubview(eventListTableView)
        eventListTableView.translatesAutoresizingMaskIntoConstraints = false
        eventListTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        eventListTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        eventListTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        eventListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        eventListTableView.rowHeight = UITableView.automaticDimension
//        eventListTableView.estimatedRowHeight = 200
        eventListTableView.register(EventListCell.self, forCellReuseIdentifier: "eventListCell")
    }
    
    func getEventListAPICall() {
        eventService.callCoreData(onSuccess: { (favoritedEvents) in
            print(favoritedEvents!)
            if favoritedEvents!.count > 0 {
                for favoritedEvent in favoritedEvents! {
                    self.favoritedEventsDict[favoritedEvent.value(forKey: "id") as! Int] = favoritedEvent.value(forKey: "favorited") as? Bool ?? false
                }
            }
            print(self.favoritedEventsDict)
            self.eventService.getEvents(onSuccess: { (response) in
                print("success")
                let events = response.events
                self.eventsViewModel = events.map({return EventViewModel(event: $0)})
                if favoritedEvents!.count > 0 {
                    self.eventsViewModel = self.eventsViewModel.map({ (eventViewModel: EventViewModel) -> EventViewModel in
                        var newEventViewModel = eventViewModel
                        newEventViewModel.favorited = self.favoritedEventsDict[newEventViewModel.id] ?? false
//                        print("\(newEventViewModel.name) has been favorited: \(newEventViewModel.favorited)")
                        return newEventViewModel
                    })
                }
                self.filteredEventsViewModel = self.eventsViewModel
                self.dataIsLoaded = true
                DispatchQueue.main.async {
                    print("eventListTableView reloaded")
                    self.eventListTableView.reloadData()
                }
            }) { (error) in
                print("error")
            }
        }) { (error) in
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedEventSegue" {
            let vc = segue.destination as! EventViewController
            vc.favoritedEventsDict = favoritedEventsDict
            vc.eventViewModel = selectedEventViewModel
//            vc.selectedEventId = selectedEventId
        }
    }
    
}

// TABLE VIEW DATA SOURCE FUNCTIONS

extension EventListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataIsLoaded ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredEventsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventListCell", for: indexPath) as? EventListCell
        cell?.eventViewModel = filteredEventsViewModel[indexPath.row]
//        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
}

// TABLE VIEW DELEGATE FUNCTIONS

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        selectedEventId = filteredEventsViewModel[indexPath.row].id
        selectedEventViewModel = filteredEventsViewModel[indexPath.row]
        self.performSegue(withIdentifier: "selectedEventSegue", sender: nil)
    }
}

// SEARCH BAR DELEGATE FUNCTIONS

extension EventListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredEventsViewModel = eventsViewModel.filter { (event) -> Bool in
            return event.name.lowercased().contains(searchText.lowercased())
        }
        if searchText == "" {
            filteredEventsViewModel = eventsViewModel
        }
        DispatchQueue.main.async {
            self.eventListTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.eventListTableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredEventsViewModel = eventsViewModel
        searchBar.resignFirstResponder()
        DispatchQueue.main.async {
            self.eventListTableView.reloadData()
        }
    }
}

