//
//  RestAPIManager.swift
//  EventsShowCase
//
//  Created by Ameer Bajwa on 3/17/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

class RestAPIManager {
    
    // client id for seatgeek api = MjE2MDI3NTJ8MTYxNjAzMzE3MC44NTAzOTY2
    // client secret password for seatgeek api = 140630a24ab29057af70c23fc24968f8ee616a4316b27f1c42ca978a5538d934

    let baseURL = "https://api.seatgeek.com/2"
    let clientId = "MjE2MDI3NTJ8MTYxNjAzMzE3MC44NTAzOTY2"
    let clientSecret = "140630a24ab29057af70c23fc24968f8ee616a4316b27f1c42ca978a5538d934"

    func httpRequest(apiUrl: String, httpMethod: String, onSuccess: @escaping ([String:Any]) -> Void, onFailure: @escaping ([String: Any]) -> Void) {
        let url = baseURL + apiUrl + "?client_id=\(clientId)&client_secret=\(clientSecret)"
        let apiURL = URL(string: url)!

        let request = URLRequest(url: apiURL)
//        request.httpMethod = httpMethod
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("From Web Server")
                print(error?.localizedDescription ?? "No data")
                onFailure(["Error": error?.localizedDescription ?? "No data"])
                return
            }
            print("after API is called in the backend, now in the frontend")
            guard let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {
                print("Could not convert json object to a swift dictionary object")
                return
            }
            print("From Web Server")
            print(responseJSON)
            onSuccess(responseJSON)
        }
        task.resume()
    }
}
