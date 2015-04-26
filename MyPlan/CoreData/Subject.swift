//
//  Subject.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Subject) class Subject: NSManagedObject {

    @NSManaged var info: String
    @NSManaged var notify: NSNumber
    @NSManaged var title: String
    @NSManaged var homeworks: NSSet
    @NSManaged var marks: NSSet
    @NSManaged var notes: NSSet
    @NSManaged var person: Person
    @NSManaged var stunden: NSSet

}