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
    var beginDate: MPDate {
        set (newDate) {
            self.beginDateData = newDate
        }
        get {
            return self.beginDateData as! MPDate
        }
    }
    
    var endDate: MPDate {
        set (newDate) {
            self.endDateData = newDate
        }
        get {
            return self.endDateData as! MPDate
        }
    }
}



