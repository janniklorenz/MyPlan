//
//  MPCurrentTimeIndicator.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 06.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

class MPCurrentTimeIndicator: UICollectionReusableView {

    
    
    
    var time = UILabel()
    var minuteTimer: NSTimer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        time.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        time.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        time.font = UIFont.boldSystemFontOfSize(10)
        time.textColor = UIColor.greenColor()   // fd3935
        addSubview(time)
        
        var calendar = NSCalendar.currentCalendar()
        var oneMinuteInFuture = NSDate().dateByAddingTimeInterval(60)
        var components = calendar.components((.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit), fromDate: oneMinuteInFuture)
        var nextMinuteBoundary = calendar.dateFromComponents(components)
        
        minuteTimer = NSTimer(fireDate: nextMinuteBoundary!, interval: 60, target: self, selector: "minuteTick", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(minuteTimer!, forMode: "NSDefaultRunLoopMode")
        updateTime()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func minuteTick() {
        updateTime()
    }
    
    func updateTime() {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm aa"
        time.text = dateFormatter.stringFromDate(NSDate())
        time.sizeToFit()
    }
    
    
    
}
