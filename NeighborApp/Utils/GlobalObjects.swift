//
//  AppDelegate.swift
//  NeighborApp
//
//  Created by Nitesh on 11/28/15.
//  Copyright © 2015 Nitesh. All rights reserved.
//

import UIKit

enum NavIndex: Int{
    case Home = 0, Chat, PlacesOfInterest
}

class GlobalObjects: NSObject{
    
    var msgCount = 0
    typealias customCompletionHandler = (AnyObject!) -> Void
    var hastagClicked = ""
    var subscribeToSelf = false;
    
    var homeTabBar: UINavigationController
    
    var selectedTab:NavIndex = NavIndex.Home
    
    var tabBarItems:[UITabBarItem] = []
    var tabBarheight = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.screen.bounds.height
    var tabBarwidth = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.screen.bounds.width
    
    
    private var HomeScreen = UIStoryboard(name: "HomeScreens", bundle: nil).instantiateViewControllerWithIdentifier("HomeScreen") as! HomeViewController
    
    
    
    var tabBar = UITabBar()
    
    var latitude = "12.9335292499163"
    var longitude = "77.6217817571655"

    override init(){
        
        tabBar = UITabBar(frame: CGRect(x:0, y:tabBarheight! - 49, width:tabBarwidth!, height:49))

        
        self.homeTabBar = UINavigationController(rootViewController: self.HomeScreen)
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = self.homeTabBar
        
        
        super.init()
        self.createTabBarItems()

    
    }
    
    func isUserLoggedIn() -> Bool{
        if FBSDKAccessToken.currentAccessToken() != nil{
            return true
        }
        return false
    }
    
    func getUserInfo(onResult:customCompletionHandler) {
        let params = ["fields": "id, first_name, last_name, middle_name, name, email, picture"]
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        
        graphRequest.startWithCompletionHandler { (connection: FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            
            onResult(result)
        }
    }
    
    func createTabBarItems(){
        
        tabBarItems.removeAll(keepCapacity: true)
        let homeTabItem = UITabBarItem(title: "Home", image: UIImage(named: "homeTab"), selectedImage: UIImage(named: ""))
        let chatTabItem = UITabBarItem(title: "Chat", image: UIImage(named: "chatTab"), selectedImage: UIImage(named: ""))
        let mapTabItem = UITabBarItem(title: "Map", image: UIImage(named: "homeTab"), selectedImage: UIImage(named: ""))

        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blackColor()], forState:.Selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        
        homeTabItem.tag = NavIndex.Home.rawValue
        chatTabItem.tag = NavIndex.Chat.rawValue
        mapTabItem.tag = NavIndex.PlacesOfInterest.rawValue
        
        
        
        tabBarItems.append(homeTabItem)
        tabBarItems.append(chatTabItem)
        tabBarItems.append(mapTabItem)
        
        tabBar.setItems(tabBarItems, animated: false)
    }
    
    func setRootNavController(index:NavIndex){
        
        if index == NavIndex.Home{
            (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = self.homeTabBar
            self.selectedTab = NavIndex.Home
            self.changeColor(NavIndex.Home)
        }
        
        
    }
    
    func changeColor(index:NavIndex){
        let tabItems = self.tabBar.items!
        for item in tabItems{
            let it = item
            if it.tag == index.rawValue{
                self.tabBar.selectedItem = it
            }
        }
        
        self.tabBar.tintColor = Constants.color.headingColor
    }
    
    func popAllViewControllers(){
        
    }
    
    class var sharedInstance: GlobalObjects{
        struct Static{
            static var onceToken : dispatch_once_t = 0
            static var instance: GlobalObjects? = nil
        }
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.instance = GlobalObjects()
        })
        return Static.instance!
    }
}
