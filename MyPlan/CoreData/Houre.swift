//
//  Houre.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Houre) class Houre: NSManagedObject {

    @NSManaged var houre: NSNumber
    @NSManaged var info: String
    @NSManaged var notify: NSNumber
    @NSManaged var day: Day
    @NSManaged var subject: Subject

}
