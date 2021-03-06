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
    var eventImageView = UIImageView()
    var eventFavoritedButton = UIButton()
    
    var eventFavorited: Bool = false
    
    var eventViewModel: EventViewModel! {
        didSet {
            eventName.text = eventViewModel.name
            eventLocation.text = eventViewModel.location
            eventTime.text = eventViewModel.formattedTime(eventTime: eventViewModel.time)
            eventImageView.image = UIImage(data: eventViewModel.setImage(stringUrl: eventViewModel.imageStringUrls[0])!)
            if let fav = eventViewModel.favorited {
                if fav {
                    eventFavoritedButton.setImage(UIImage(named: "heartFilled"), for: .normal)
                } else {
                    eventFavoritedButton.setImage(nil, for: .normal)
                }
            } else{
                eventFavoritedButton.setImage(nil, for: .normal)
            }
//            eventFavorited = eventViewModel.favorited ?? false
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpEventImage()
        setUpEventNameLabel()
        setUpEventLocationLabel()
        setUpEventTimeLabel()
        setUpEventFavoritedButton()
        accessoryType = .disclosureIndicator
    }
    
    func setUpEventImage() {
        eventImageView.layer.cornerRadius = 20.0
        
        addSubview(eventImageView)
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20.0).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        eventImageView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    }
    
    func setUpEventNameLabel() {
        eventName.font = UIFont.boldSystemFont(ofSize: 18)
//        eventName.textColor = UIColor.systemBlue
        eventName.numberOfLines = 0
        
        addSubview(eventName)
        eventName.translatesAutoresizingMaskIntoConstraints = false
        eventName.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 20.0).isActive = true
        eventName.topAnchor.constraint(equalTo: topAnchor, constant: 20.0).isActive = true
        eventName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50.0).isActive = true
    }
    
    func setUpEventLocationLabel() {
        eventLocation.font = UIFont.systemFont(ofSize: 14)
        eventLocation.textColor = UIColor.darkGray
        
        addSubview(eventLocation)
        eventLocation.translatesAutoresizingMaskIntoConstraints = false
        eventLocation.topAnchor.constraint(equalTo: eventName.bottomAnchor, constant: 10.0).isActive = true
        eventLocation.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 20.0).isActive = true
        eventLocation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50.0).isActive = true
    }
    
    func setUpEventTimeLabel() {
        eventTime.font = UIFont.systemFont(ofSize: 15)
        eventTime.textColor = UIColor.black
        eventTime.numberOfLines = 0
        
        addSubview(eventTime)
        eventTime.translatesAutoresizingMaskIntoConstraints = false
        eventTime.topAnchor.constraint(equalTo: eventLocation.bottomAnchor, constant: 10.0).isActive = true
        eventTime.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 20.0).isActive = true
        eventTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50.0).isActive = true
        eventTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0).isActive = true
    }
    
    func setUpEventFavoritedButton() {
        addSubview(eventFavoritedButton)
        bringSubviewToFront(eventFavoritedButton)
        eventFavoritedButton.translatesAutoresizingMaskIntoConstraints = false
        eventFavoritedButton.centerXAnchor.constraint(equalTo: eventImageView.trailingAnchor).isActive = true
        eventFavoritedButton.centerYAnchor.constraint(equalTo: eventImageView.topAnchor).isActive = true
        eventFavoritedButton.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        eventFavoritedButton.heightAnchor.constraint(equalToConstant: 25.0).isActive = true

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
