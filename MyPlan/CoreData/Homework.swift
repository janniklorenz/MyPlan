//
//  Homework.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Homework) class Homework: NSManagedObject {

    @NSManaged var test: String
    @NSManaged var timestamp: NSDate
    @NSManaged var title: String
    @NSManaged var toDate: NSDate
    @NSManaged var images: Image
    @NSManaged var subject: Subject

}
