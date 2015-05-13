//
//  Helper.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 30.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation

extension UIColor {
    class func getRandomColor() -> UIColor {
        return UIColor(
            red: CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
            green: CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
            blue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)),
            alpha: 1.0
        )
    }
    func getRGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return ( red: r, green: g, blue: b, alpha: a )
        }
        return ( red: 0, green: 0, blue: 0, alpha: 0 )
    }
    func getReadableTextColor() -> UIColor {
        var colors = self.getRGBA()
        if colors.red + colors.green + colors.blue > 1.5 {
            return UIColor.blackColor()
        }
        else {
            return UIColor.whiteColor()
        }
    }
}

extension NSDateComponents {
    convenience init (hour: Int, minute: Int) {
        self.init()
        self.hour = hour
        self.minute = minute
    }
    func compare(anotherDate: NSDateComponents) -> NSComparisonResult {
        if self.hour*60+self.minute < anotherDate.hour*60+anotherDate.minute {
            return NSComparisonResult.OrderedAscending
        }
        else if self.hour*60+self.minute > anotherDate.hour*60+anotherDate.minute {
            return NSComparisonResult.OrderedDescending
        }
        else {
            return NSComparisonResult.OrderedSame
        }
    }
}



extension Subject {
    var fullTitle: String {
        get {
            if self.titleShort.isEmpty {
                return self.title
            }
            else {
                return "\(self.title) (\(self.titleShort))"
            }
        }
    }
    var color:UIColor {
        set (newColor) {
            self.colorData = newColor
        }
        get {
            return self.colorData as! UIColor
        }
    }
}


extension DefaultTime {
    var beginDate: NSDateComponents {
        set (newDate) {
            self.beginDateData = newDate
        }
        get {
            return self.beginDateData as! NSDateComponents
        }
    }
    
    var endDate: NSDateComponents {
        set (newDate) {
            self.endDateData = newDate
        }
        get {
            return self.endDateData as! NSDateComponents
        }
    }
}


extension Day {
    var fullTitle: String {
        get {
            if self.titleShort.isEmpty {
                return self.title
            }
            else {
                return "\(self.title) (\(self.titleShort))"
            }
        }
    }
}





enum Dash {
    case ShowPlan(Plan)
    case ShowMarkGroup(MarkGroup)
    case Settings
    case Subjects
    case Events
    case Homeworks
    case Week
}





