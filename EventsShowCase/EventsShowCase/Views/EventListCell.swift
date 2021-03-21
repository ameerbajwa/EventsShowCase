//
//  EventListCell.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/20/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit

class EventListCell: UITableViewCell {
    
    var eventName = UILabel()
    var eventLocation = UILabel()
    var eventTime = UILabel()
    
    var eventViewModel: EventViewModel! {
        didSet {
            eventName.text = eventViewModel.name
            eventLocation.text = eventViewModel.location
            eventTime.text = eventViewModel.formattedTime(eventTime: eventViewModel.time)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpEventNameLabel()
        setUpEventLocationLabel()
        setUpEventTimeLabel()
        accessoryType = .disclosureIndicator
    }
    
    func setUpEventNameLabel() {
        eventName.font = UIFont.boldSystemFont(ofSize: 20)
        eventName.textColor = UIColor.systemBlue
        eventName.numberOfLines = 0
        
        addSubview(eventName)
        eventName.translatesAutoresizingMaskIntoConstraints = false
        eventName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        eventName.topAnchor.constraint(equalTo: topAnchor, constant: 20.0).isActive = true
        eventName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
    }
    
    func setUpEventLocationLabel() {
        eventLocation.font = UIFont.systemFont(ofSize: 14)
        eventLocation.textColor = UIColor.darkGray
        
        addSubview(eventLocation)
        eventLocation.translatesAutoresizingMaskIntoConstraints = false
        eventLocation.topAnchor.constraint(equalTo: eventName.bottomAnchor, constant: 10.0).isActive = true
        eventLocation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        eventLocation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
    }
    
    func setUpEventTimeLabel() {
        eventTime.font = UIFont.systemFont(ofSize: 16)
        eventTime.textColor = UIColor.black
        
        addSubview(eventTime)
        eventTime.translatesAutoresizingMaskIntoConstraints = false
        eventTime.topAnchor.constraint(equalTo: eventLocation.bottomAnchor, constant: 10.0).isActive = true
        eventTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        eventTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        eventTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
