//
//  User+CoreDataProperties.swift
//  clothingApplication
//
//  Created by User on 2017/03/08.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var date: String?
    @NSManaged public var img: String?
    @NSManaged public var wantname: String?
    @NSManaged public var wantbland: String?
    @NSManaged public var wantsize: String?

}
