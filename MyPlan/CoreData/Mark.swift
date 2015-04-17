//
//  Mark.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Mark) class Mark: NSManagedObject {

    @NSManaged var judging: NSNumber
    @NSManaged var mark: NSNumber
    @NSManaged var text: String
    @NSManaged var timestamp: NSDate
    @NSManaged var title: String
    @NSManaged var images: NSSet
    @NSManaged var markGroup: MarkGroup
    @NSManaged var subject: Subject

}
