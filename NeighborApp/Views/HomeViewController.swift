//
//  HomeViewController.swift
//  NeighborApp
//
//  Created by Nitesh on 11/28/15.
//  Copyright © 2015 Nitesh. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts
import CoreTelephony

class HomeViewController: BaseTabViewController, FBSDKLoginButtonDelegate, CLLocationManagerDelegate{
    
    
    var locationManager: CLLocationManager!
    var locationUpdated:Bool = false
    var currPlacemark:CLPlacemark!
    var contactStore: AnyObject!
    var savedOnce = false
    var eventsTrending = ["#silkBoardfare","#kormanglaRaveParty","#HSRPaintBall"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCurrentLocation()

        if GlobalObjects.sharedInstance.isUserLoggedIn(){
            self.goToNextScreen()
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.delegate = self
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "homeScreen")!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        self.goToNextScreen()
    }
    
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        //FBSDKAccessToken.setCurrentAccessToken(nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        print("lat value \(newLocation.coordinate.latitude)")
        print("lon value \(newLocation.coordinate.longitude)")
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0{
//            let coord = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
//            print(locations[0].coordinate.latitude)
//            print(locations[0].coordinate.longitude)
        }
        
        if manager.location != nil{
            
            
        

        }
    }
    
    
    
    func getCurrentLocation(){
        
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled(){
        
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            self.locationManager.startUpdatingLocation()
            
            let location = locationManager.location
            if location != nil{
                var coord = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
                coord = (location?.coordinate)!
                
                GlobalObjects.sharedInstance.latitude = "\(coord.latitude)"
                GlobalObjects.sharedInstance.longitude = "\(coord.longitude)"
                
                print("current lat/long: \(GlobalObjects.sharedInstance.latitude) \(GlobalObjects.sharedInstance.longitude)")
                
            }
            
        }
        
        
        
    }
    
    func setLocation(currPlaceMark:CLPlacemark!){
        if self.locationUpdated == false{
            self.locationUpdated = true
        }
    
    }
    
    
    func goToNextScreen(){
        
        GlobalObjects.sharedInstance.getUserInfo { (result) -> Void in
            let usrInfo = result as? NSDictionary
            if usrInfo != nil{
                print(usrInfo)
                let email = usrInfo?["email"] as? String
                let first_name = usrInfo?["first_name"] as? String
                let fbID = usrInfo?["id"] as? String
                let last_name = usrInfo?["last_name"] as? String
                let name = usrInfo?["name"] as? String
                var prImgURL = "https://graph.facebook.com"
                if fbID != nil{
                    prImgURL = "https://graph.facebook.com/\(fbID!)/picture?type=large"
                }
                
                let userData = UserAdapter.sharedInstance.addUser()
                userData.fbID = fbID
                userData.first_name = first_name
                userData.last_name = last_name
                userData.name = name
                userData.imageURL = prImgURL
                userData.email = email
                userData.isCurrentUser = true
                UserAdapter.sharedInstance.insertUser()
                
                let navC = self.navigationController?.viewControllers
                for vc in navC!{
                    if vc is ShowNearbyUsersViewController{
                        (vc as! ShowNearbyUsersViewController).getProfileImage()
                    }
                }
            }
        
        }
        self.performSegueWithIdentifier("showChatsScreen", sender: nil)
        
        

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
