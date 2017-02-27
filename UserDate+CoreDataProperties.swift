//
//  UserDate+CoreDataProperties.swift
//  clothingApplication
//
//  Created by User on 2017/02/16.
//  Copyright © 2017年 Yusuke Hirose. All rights reserved.
//

import Foundation
import CoreData


extension UserDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDate> {
        return NSFetchRequest<UserDate>(entityName: "UserDate");
    }

    @NSManaged public var phot: String?
    @NSManaged public var clothename: String?
    @NSManaged public var size: String?
    @NSManaged public var blandname: String?
    @NSManaged public var price: Int16
    @NSManaged public var date: String?
    @NSManaged public var category: String?
    @NSManaged public var created_at: String?
}
