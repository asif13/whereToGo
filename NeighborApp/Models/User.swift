//
//  User.swift
//  NeighborApp
//
//  Created by Nitesh on 12/3/15.
//  Copyright © 2015 Nitesh. All rights reserved.
//

import Foundation
import CoreData
@objc(User)
class User: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var imageURL: String?
    @NSManaged var first_name: String?
    @NSManaged var last_name: String?
    @NSManaged var fbID: String?
    @NSManaged var lat: NSNumber?
    @NSManaged var long: NSNumber?
    @NSManaged var isCurrentUser: NSNumber?
    @NSManaged var email: String?
}