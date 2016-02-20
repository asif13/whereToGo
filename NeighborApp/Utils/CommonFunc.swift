//
//  AppDelegate.swift
//  NeighborApp
//
//  Created by Nitesh on 11/28/15.
//  Copyright © 2015 Nitesh. All rights reserved.
//

import UIKit

class CommonFunc: NSObject{
    
    class func showAlert(title:String, message:String, delay:Int) {
        let alertView = AlertView()
        alertView.showAlert(title, body: message)
        let delay_t = Int64(delay * Int(NSEC_PER_SEC))
        let hideTime = dispatch_time(DISPATCH_TIME_NOW, delay_t)
        dispatch_after(hideTime, dispatch_get_main_queue()) { () -> Void in
            alertView.hideAlert()
        }
    }
    
    class func convertToJson(object:AnyObject ) -> NSString?{
        
        do{
            let theJSONData = try NSJSONSerialization.dataWithJSONObject(object ,options: NSJSONWritingOptions.init(rawValue: 0))
            let theJSONText = NSString(data: theJSONData, encoding: NSASCIIStringEncoding)
            return theJSONText
        }
        catch{
        
        }
        
        return ""
        
    }
}
