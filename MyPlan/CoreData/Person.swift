//
//  Person.swift
//  
//
//  Created by Jannik Lorenz on 02.05.15.
//
//

import Foundation
import CoreData

@objc(Person) class Person: NSManagedObject {

    @NSManaged var notify: NSNumber
    @NSManaged var timestamp: NSDate
    @NSManaged var title: String
    @NSManaged var defaultTime: NSSet
    @NSManaged var events: NSSet
    @NSManaged var images: NSSet
    @NSManaged var markGroups: NSSet
    @NSManaged var plans: NSSet
    @NSManaged var subjects: NSSet
    @NSManaged var settings: Settings

}
