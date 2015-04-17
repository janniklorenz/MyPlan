//
//  Day.swift
//  MyPlan 5
//
//  Created by Jannik Lorenz on 16.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Day) class Day: NSManagedObject {

    @NSManaged var weekIndex: NSNumber
    @NSManaged var title: String
    @NSManaged var titleShort: String
    @NSManaged var houres: NSSet
    @NSManaged var plan: Plan

}
