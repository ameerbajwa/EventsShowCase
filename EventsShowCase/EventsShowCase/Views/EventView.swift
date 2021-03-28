//
//  EventView.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/27/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit

class EventView: UIView {
    
    var eventName = UILabel()
    var eventLocation = UILabel()
    var eventTime = UILabel()
    var eventImageView = UIImageView()
    var eventFavoritedButton = UIButton()
    
    var eventViewModel: EventViewModel! {
        didSet {
            eventName.text = eventViewModel.name
            eventLocation.text = eventViewModel.location
            eventTime.text = eventViewModel.formattedTime(eventTime: eventViewModel.time)
            eventImageView.image = UIImage(data: eventViewModel.setImage(stringUrl: eventViewModel.imageStringUrls[0])!)
            if eventViewModel.favorited == true {
                eventFavoritedButton.setImage(UIImage(named: "heartFilled"), for: .normal)
            } else {
                eventFavoritedButton.setImage(UIImage(named: "heartEmpty"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpEventNameLabel()
        self.setupEventFavoritedButton()
        self.setUpEventImage()
        self.setUpEventTimeLabel()
        self.setUpEventLocationLabel()
    }
    
    func setUpEventNameLabel() {
        eventName.font = UIFont.boldSystemFont(ofSize: 22)
        eventName.numberOfLines = 0
        
        addSubview(eventName)
        eventName.translatesAutoresizingMaskIntoConstraints = false
        eventName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        eventName.topAnchor.constraint(equalTo: topAnchor, constant: 30.0).isActive = true
//        eventName.trailingAnchor.constraint(equalTo: eventFavoritedButton.leadingAnchor, constant: -20.0).isActive = true
    }
    
    func setupEventFavoritedButton() {
        addSubview(eventFavoritedButton)
        eventFavoritedButton.translatesAutoresizingMaskIntoConstraints = false
        eventFavoritedButton.leadingAnchor.constraint(equalTo: eventName.trailingAnchor, constant: 20.0).isActive = true
        eventFavoritedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        eventFavoritedButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        eventFavoritedButton.topAnchor.constraint(equalTo: topAnchor, constant: 20.0).isActive = true
    }
    
    func setUpEventImage() {
        eventImageView.layer.cornerRadius = 20.0
        eventImageView.sizeToFit()
        
        addSubview(eventImageView)
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.topAnchor.constraint(equalTo: eventName.bottomAnchor, constant: 40.0).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        eventImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setUpEventTimeLabel() {
        eventTime.font = UIFont.systemFont(ofSize: 18)
        eventTime.textColor = UIColor.black
        eventTime.numberOfLines = 0
        
        addSubview(eventTime)
        eventTime.translatesAutoresizingMaskIntoConstraints = false
        eventTime.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 10.0).isActive = true
        eventTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        eventTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
//        eventTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0).isActive = true
    }

    func setUpEventLocationLabel() {
        eventLocation.font = UIFont.systemFont(ofSize: 16)
        eventLocation.textColor = UIColor.darkGray
        
        addSubview(eventLocation)
        eventLocation.translatesAutoresizingMaskIntoConstraints = false
        eventLocation.topAnchor.constraint(equalTo: eventTime.bottomAnchor, constant: 10.0).isActive = true
        eventLocation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        eventLocation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
