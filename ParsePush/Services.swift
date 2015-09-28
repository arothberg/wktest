//
//  Services.swift
//  ParsePush
//
//  Created by Tommy Fannon on 9/25/15.
//  Copyright © 2015 Crazy8Dev. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

//let ipAddress = "192.168.1.16"
let ipAddress = "192.168.1.11"

let url = "http://\(ipAddress)/Offline/api/login"
let notUrl = "http://\(ipAddress)/Offline/api/Notification"


public class Services {
 
    public static func login(name: String, token: NSData, completed: (result: String)->()) {
        return login(name, token: tokenToString(token), completed: completed)
    }
    
    static func login(name: String, token: String, completed: (result: String)->()) {
        let dict = ["LoginName":name, "DeviceToken":token]
        Alamofire.request(.POST, url + "/PostLogin", parameters: dict, encoding: .JSON)
            .responseJSON { request, response, result in
                switch result {
                case .Success(let data):
                    let json = JSON(data)
                    print(json)
                    completed(result: json.string!)
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                }
        }
    }
    
    static func tokenToString(data: NSData) -> String {
        let tokenChars = UnsafePointer<CChar>(data.bytes)
        var tokenString = ""
        
        for var i = 0; i < data.length; i++ {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        print("tokenString: \(tokenString)")
        return tokenString
    }
    
    static func getUnreadCount(completed: (result: Int)->()) {
        Alamofire.request(.GET, notUrl + "/GetCount", parameters: nil, encoding: .JSON)
            .responseJSON { request, response, result in
                switch result {
                case .Success(let data):
                    let json = JSON(data)
                    print(json)
                    completed(result: json.int!)
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                }
        }
        
    }
    
    static func getUnreadNotifications(completed: (result: [Notification]?)->()) {
        Alamofire.request(.GET, notUrl + "/Get", parameters: nil, encoding: .JSON)
            .responseJSON { request, response, result in
                switch result {
                case .Success(let data):
                    //let json = JSON(data)
                    let jsonAlamo = data as? [[String:AnyObject]]
                    let result = jsonAlamo?.map { Mapper<Notification>().map($0)! }
                    //print(json[0].string)
                    //let notification = Mapper<Notification>().map(jsonAlamo?[0])
                    //print(notification)
                    completed(result: result)
                case .Failure(_, let error):
                    print("Request failed with error: \(error)")
                }
        }
        
    }


}