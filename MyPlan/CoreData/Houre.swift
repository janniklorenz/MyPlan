//
//  Houre.swift
//  
//
//  Created by Jannik Lorenz on 01.05.15.
//
//

import Foundation
import CoreData

@objc(Houre) class Houre: NSManagedObject {

    @NSManaged var houre: NSNumber
    @NSManaged var info: String
    @NSManaged var notify: NSNumber
    @NSManaged var day: Day
    @NSManaged var subject: Subject
    @NSManaged var infos: NSSet

}
