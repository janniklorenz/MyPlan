//
//  Person.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
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

}
