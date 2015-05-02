//
//  Info.swift
//  
//
//  Created by Jannik Lorenz on 01.05.15.
//
//

import Foundation
import CoreData

@objc(Info) class Info: NSManagedObject {

    @NSManaged var timestamp: NSDate
    @NSManaged var value: String
    @NSManaged var key: String

}
