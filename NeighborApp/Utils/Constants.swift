//
//  AppDelegate.swift
//  NeighborApp
//
//  Created by Nitesh on 11/28/15.
//  Copyright © 2015 Nitesh. All rights reserved.
//

import UIKit

struct Constants {
    struct url {
        static let baseURL = "ec2-52-32-43-254.us-west-2.compute.amazonaws.com"
        //static let baseURL = "127.0.0.1"
        static let baseChatUrl = "http://\(baseURL):3000"
        static let registerUser = NSURL(string: "http://\(baseURL):3000/user")!
        static let usersInRangeUrl = NSURL(string: "http://\(baseURL):3000/getInRangeUsers")!
        static let getUsersLocation =  NSURL(string: "http://\(baseURL):3000/getInRangeUsers")!
        static let getChatsForLoc = NSURL(string: "http://\(baseURL):3000/getChatsForLoc")!
    }
    
    struct font {
        
    }
    
    struct color{
        static let veryLightGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        static let headingColor = UIColor(red: 120/255, green: 145/255, blue: 230/255, alpha: 1)
    }
}
