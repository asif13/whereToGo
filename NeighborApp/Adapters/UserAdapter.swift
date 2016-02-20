//
//  UserAdapter.swift
//  NeighborApp
//
//  Created by Nitesh on 12/3/15.
//  Copyright © 2015 Nitesh. All rights reserved.
//

import UIKit
import CoreData


class UserAdapter: NSObject{
    
    var backgroundMOC = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
    
    
    func saveBGMOC(moc:NSManagedObjectContext){
        
        do{
            try moc.save()
        }catch{
            
        }
    }
    
    func getBgMoc() -> NSManagedObjectContext?{
        let managedObjectContext = self.backgroundMOC
        if (managedObjectContext.persistentStoreCoordinator == nil){
            managedObjectContext.persistentStoreCoordinator = (UIApplication.sharedApplication().delegate as! AppDelegate).persistentStoreCoordinator
        }
        return self.backgroundMOC
    }
    
    func addUser() -> User{
        let managedObjectContext = getBgMoc()
        self.backgroundMOC = managedObjectContext!
        let entityDescripition = NSEntityDescription.entityForName("User", inManagedObjectContext: managedObjectContext!)
        let user = User(entity:entityDescripition!, insertIntoManagedObjectContext:managedObjectContext!)
        return user
    }
    
    func insertUser() {
        let moc = self.backgroundMOC
        if moc.hasChanges{
            do{
                try moc.save()
            }catch{
                
            }
        }
    }
    
    func getCurrentUser() -> User!{
        let managedObjectContext = getBgMoc()
        self.backgroundMOC = managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        do{
            let users = try managedObjectContext?.executeFetchRequest(fetchRequest) as! [User]
            
            for usr in users{
                if usr.isCurrentUser == true{
                    return usr
                }
            }
        }
        catch{
        
        }
        return nil
    }
    
    func getAllUsers() -> [User]! {
        let managedObjectContext = getBgMoc()
        self.backgroundMOC = managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        do {
            let users = try managedObjectContext?.executeFetchRequest(fetchRequest) as! [User]
            
            if users.count > 0 {
                return users
            }
        }
        catch{
        }
        return nil
    }
    
    
    
    class var sharedInstance: UserAdapter{
        struct Static{
            static var onceToken : dispatch_once_t = 0
            static var instance: UserAdapter? = nil
        }
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.instance = UserAdapter()
        })
        return Static.instance!
    }
    
}