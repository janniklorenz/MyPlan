//
//  Defualts.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 02.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation

extension Settings {
    func setDefaults() {
        self.notifications = NSNumber(bool: true)
    }
}


extension Person {
    func setDefaults(localContext: NSManagedObjectContext) {
        self.timestamp = NSDate()
        self.title = NSLocalizedString("New Person", comment: "")
        
        
        
        var subjectDeutsch = Subject.MR_createInContext(localContext) as! Subject!
        subjectDeutsch.setDefaults()
        subjectDeutsch.person = self
        subjectDeutsch.title = NSLocalizedString("German", comment: "")
        subjectDeutsch.titleShort = NSLocalizedString("Ger", comment: "")
        subjectDeutsch.color = UIColor.blackColor()
        
        var subjectEnglisch = Subject.MR_createInContext(localContext) as! Subject!
        subjectEnglisch.setDefaults()
        subjectEnglisch.person = self
        subjectEnglisch.title = NSLocalizedString("English", comment: "")
        subjectEnglisch.titleShort = NSLocalizedString("E", comment: "")
        subjectEnglisch.color = UIColor.redColor()
        
        var subjectMathe = Subject.MR_createInContext(localContext) as! Subject!
        subjectMathe.setDefaults()
        subjectMathe.person = self
        subjectMathe.title = NSLocalizedString("Maths", comment: "")
        subjectMathe.titleShort = NSLocalizedString("M", comment: "")
        subjectMathe.color = UIColor.blueColor()
        
        var subjectPhysik = Subject.MR_createInContext(localContext) as! Subject!
        subjectPhysik.setDefaults()
        subjectPhysik.person = self
        subjectPhysik.title = NSLocalizedString("Physics", comment: "")
        subjectPhysik.titleShort = NSLocalizedString("Ph", comment: "")
        subjectPhysik.color = UIColor.whiteColor()
        
        
        
        var plan = Plan.MR_createInContext(localContext) as! Plan!
        plan.setDefaults(localContext)
        plan.title = NSLocalizedString("Plan", comment: "")
        plan.person = self
        
        
        
        var markGroup = MarkGroup.MR_createInContext(localContext) as! MarkGroup!
        markGroup.setDefaults()
        markGroup.title = NSLocalizedString("Marks", comment: "")
        markGroup.person = self
        
        
        
        var time0 = DefaultTime.MR_createInContext(localContext) as! DefaultTime
        time0.person = self
        time0.beginDate = MPDate(houre: 7, minute: 45, seconds: 00)
        time0.endDate = MPDate(houre: 9, minute: 15, seconds: 00)
        
        var time1 = DefaultTime.MR_createInContext(localContext) as! DefaultTime
        time1.person = self
        time1.beginDate = MPDate(houre: 9, minute: 35, seconds: 00)
        time1.endDate = MPDate(houre: 11, minute: 05, seconds: 00)
        
        var time2 = DefaultTime.MR_createInContext(localContext) as! DefaultTime
        time2.person = self
        time2.beginDate = MPDate(houre: 11, minute: 25, seconds: 00)
        time2.endDate = MPDate(houre: 12, minute: 55, seconds: 00)
    }
}


extension Plan {
    func setDefaults(localContext: NSManagedObjectContext) {
        self.timestamp = NSDate()
        
        var days = [
            (long: NSLocalizedString("Monday", comment: ""),    short: NSLocalizedString("Mo", comment: "")),
            (long: NSLocalizedString("Tuesday", comment: ""),   short: NSLocalizedString("Tu", comment: "")),
            (long: NSLocalizedString("Wednesday", comment: ""), short: NSLocalizedString("We", comment: "")),
            (long: NSLocalizedString("Thursday", comment: ""),  short: NSLocalizedString("Th", comment: "")),
            (long: NSLocalizedString("Friday", comment: ""),    short: NSLocalizedString("Fr", comment: "")),
            (long: NSLocalizedString("Saturday", comment: ""),  short: NSLocalizedString("Sa", comment: "")),
            (long: NSLocalizedString("Sunday", comment: ""),    short: NSLocalizedString("Su", comment: "")),
        ]
        
        for i in 0...6 {
            var day = Day.MR_createInContext(localContext) as! Day
            day.plan = self.MR_inContext(localContext) as! Plan
            day.weekIndex = i
            day.title = days[i].long
            day.titleShort = days[i].short
        }
    }
}


extension Subject {
    func setDefaults() {
        self.timestamp = NSDate()
        self.notify = NSNumber(bool: true);
        self.usingMarks = NSNumber(bool: true);
        self.color = UIColor.whiteColor()
    }
}


extension MarkGroup {
    func setDefaults() {
        self.timestamp = NSDate()
    }
}




