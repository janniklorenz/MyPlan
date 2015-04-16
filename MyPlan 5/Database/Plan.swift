//
//  Plan.swift
//  MyPlan 5
//
//  Created by Jannik Lorenz on 16.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Plan) class Plan: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var days: NSSet
    @NSManaged var person: Person

}
