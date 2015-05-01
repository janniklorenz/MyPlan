//
//  Subject.swift
//  
//
//  Created by Jannik Lorenz on 01.05.15.
//
//

import Foundation
import CoreData

@objc(Subject) class Subject: NSManagedObject {

    @NSManaged var info: String
    @NSManaged var notify: NSNumber
    @NSManaged var title: String
    @NSManaged var titleShort: String
    @NSManaged var colorData: AnyObject
    @NSManaged var homeworks: NSSet
    @NSManaged var marks: NSSet
    @NSManaged var notes: NSSet
    @NSManaged var person: Person
    @NSManaged var stunden: NSSet

}
