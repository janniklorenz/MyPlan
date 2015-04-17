//
//  Event.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Event) class Event: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var notify: NSNumber
    @NSManaged var test: String
    @NSManaged var timestamp: NSDate
    @NSManaged var title: String
    @NSManaged var images: NSSet
    @NSManaged var person: Person

}
