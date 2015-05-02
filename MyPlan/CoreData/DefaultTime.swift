//
//  DefaultTime.swift
//  
//
//  Created by Jannik Lorenz on 02.05.15.
//
//

import Foundation
import CoreData

@objc(DefaultTime) class DefaultTime: NSManagedObject {

    @NSManaged var beginDateData: AnyObject
    @NSManaged var endDateData: AnyObject
    @NSManaged var person: Person

}
