//
//  ShowNearbyUsersViewController.swift
//  NeighborApp
//
//  Created by Nitesh on 12/3/15.
//  Copyright © 2015 Nitesh. All rights reserved.
//

import UIKit

class ShowNearbyUsersViewController: BaseTabViewController {

    @IBOutlet weak var profileTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProfileImage(){
        let currentUsr = UserAdapter.sharedInstance.getCurrentUser()
        if currentUsr == nil{
            getProfileImage()
            return
        }
        let fbUsrName = currentUsr.first_name
        self.profileTextLabel.text = "Hi, \(fbUsrName!)"

        if currentUsr != nil{
            if currentUsr.imageURL != nil{
                let profileImgNSURL = NSURL(string: currentUsr.imageURL!)!
                

                
            }
        }
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
