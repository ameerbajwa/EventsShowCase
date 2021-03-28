//
//  EventViewController.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/27/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    var eventView = UIView()

    override func loadView() {
        super.loadView()
        self.eventView = EventView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(self.eventView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
