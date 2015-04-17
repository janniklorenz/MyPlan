//
//  Person.swift
//  MyPlan 5
//
//  Created by Jannik Lorenz on 16.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Person) class Person: NSManagedObject {

    @NSManaged var timestamp: NSDate
    @NSManaged var title: String
    @NSManaged var events: NSSet
    @NSManaged var plans: NSSet
    @NSManaged var subjects: NSSet
    @NSManaged var markGroups: NSSet

}
