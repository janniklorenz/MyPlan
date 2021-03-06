//
//  Note.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Note) class Note: NSManagedObject {

    @NSManaged var text: String
    @NSManaged var title: String
    @NSManaged var images: NSSet
    @NSManaged var subject: Subject

}
