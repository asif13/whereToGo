//
//  BaseTabViewController.swift
//  NeighborApp
//
//  Created by Nitesh on 2/7/16.
//  Copyright © 2016 Nitesh. All rights reserved.
//

import UIKit

class BaseTabViewController: UIViewController,UITabBarDelegate {
    var tabBar:UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar = GlobalObjects.sharedInstance.tabBar
        //self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        //self.navigationController?.navigationBar.barTintColor = Constants.color.veryLightGray
        //self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.view.addSubview(tabBar)
        self.navigationController?.navigationBarHidden = false
        self.tabBar.delegate = self
        
        let tabItems = self.tabBar.items!
        self.configureTabBar()

        for item in tabItems{
            let it = item
            
            if GlobalObjects.sharedInstance.selectedTab == NavIndex.Home{
                if it.tag == NavIndex.Home.rawValue{
                    self.tabBar.selectedItem = it
                }
            }
                
            else if GlobalObjects.sharedInstance.selectedTab == NavIndex.Chat{
                if it.tag == NavIndex.Chat.rawValue{
                    self.tabBar.selectedItem = it
                }
            }
                
            else if GlobalObjects.sharedInstance.selectedTab == NavIndex.PlacesOfInterest{
                if it.tag == NavIndex.PlacesOfInterest.rawValue{
                    self.tabBar.selectedItem = it
                }
            }
        }
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTabBar()
        
    }
    
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        let navindex = NavIndex(rawValue: item.tag)
        GlobalObjects.sharedInstance.setRootNavController(navindex!)
    }
    func removeTabBar(){
        if self.tabBar != nil{
            self.tabBar.removeFromSuperview()
        }
    }
    func configureTabBar(){
        let tabItems = self.tabBar.items!
        
        let unselectedItem = [NSForegroundColorAttributeName:UIColor.grayColor()]
        let selectedItem = [NSForegroundColorAttributeName:Constants.color.headingColor]
        
        for item in tabItems{
            item.setTitleTextAttributes(unselectedItem, forState: UIControlState.Normal)
            item.setTitleTextAttributes(selectedItem, forState: UIControlState.Selected)
        }
        
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 2
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
