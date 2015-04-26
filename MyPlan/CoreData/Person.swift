//
//  Person.swift
//  
//
//  Created by Jannik Lorenz on 26.04.15.
//
//

import Foundation
import CoreData

@objc(Person) class Person: NSManagedObject {

    @NSManaged var timestamp: NSDate
    @NSManaged var title: String
    @NSManaged var events: NSSet
    @NSManaged var markGroups: NSSet
    @NSManaged var plans: NSSet
    @NSManaged var subjects: NSSet
    @NSManaged var images: NSSet

}
