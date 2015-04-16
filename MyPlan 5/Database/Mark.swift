//
//  Mark.swift
//  MyPlan 5
//
//  Created by Jannik Lorenz on 16.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Mark) class Mark: NSManagedObject {

    @NSManaged var mark: NSNumber
    @NSManaged var text: String
    @NSManaged var timestamp: NSDate
    @NSManaged var title: String
    @NSManaged var images: NSSet
    @NSManaged var subject: Subject
    @NSManaged var marks: Marks

}
