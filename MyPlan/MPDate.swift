//
//  MPDate.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 30.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

extension Int {
    var min: Int {
        get {
            return self*60
        }
    }
    var h: Int {
        get {
            return self*60*60
        }
    }
}

class MPDate: NSObject, NSCoding {
    var seconds: Int
    var step: Int
    
    var formated: (seconds: Int, minutes: Int, houres: Int) {
        get {
            var h = seconds/60/60
            var m = seconds/60-h*60
            var s = seconds-h*60*60-m*60
            
            return (s, m, h)
        }
    }
    
    override var description: String {
        get {
            var f = self.formated
            return "\(f.houres):\(f.minutes):\(f.seconds)"
        }
    }
    
    
    
    
    
    // MARK: - Init
    
    override init() {
        self.step = 5.min
        self.seconds = 0
    }
    init(seconds: Int) {
        self.step = 5.min
        self.seconds = seconds
    }
    init(houre: Int, minute: Int, seconds: Int) {
        self.step = 5.min
        self.seconds = houre.h + minute.min + seconds
    }
    
    
    
    
    
    
    
    // MARK: - NSCoding
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.seconds = decoder.decodeIntegerForKey("MPDate_seconds") as Int
        self.step = decoder.decodeIntegerForKey("MPDate_step") as Int
    }
    
    @objc func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.seconds, forKey: "MPDate_seconds")
        coder.encodeInteger(self.step, forKey: "MPDate_step")
    }
    
}
