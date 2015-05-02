//
//  Settings.swift
//  
//
//  Created by Jannik Lorenz on 02.05.15.
//
//

import Foundation
import CoreData

@objc(Settings) class Settings: NSManagedObject {

    @NSManaged var notifications: NSNumber
    @NSManaged var currentPerson: Person

}
