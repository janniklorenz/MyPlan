//
//  Houre.swift
//  MyPlan 5
//
//  Created by Jannik Lorenz on 16.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Houre) class Houre: NSManagedObject {

    @NSManaged var houre: NSNumber
    @NSManaged var info: String
    @NSManaged var day: Day
    @NSManaged var subject: Subject

}
