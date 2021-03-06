//
//  Image.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation
import CoreData

@objc(Image) class Image: NSManagedObject {

    @NSManaged var data: NSData
    @NSManaged var text: String
    @NSManaged var timestamp: NSDate
    @NSManaged var title: String

}
