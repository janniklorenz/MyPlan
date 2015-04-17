//
//  Day.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Day) class Day: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var titleShort: String
    @NSManaged var weekIndex: NSNumber
    @NSManaged var houres: NSSet
    @NSManaged var plan: Plan

}
