//
//  MPCalenderSubjectCell.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 30.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

class MPCalenderSubjectCell: UICollectionViewCell {
    
    var timeLabel: UILabel
    var titleLabel: UILabel
    var lineView: UIView
    
    var _houre: Houre?
    var houre: Houre? {
        set (newHoure) {
            if let houre = newHoure {
                _houre = newHoure
                
                var parts = houre.subject.color.getRGBA()
                self.backgroundColor = UIColor(red: parts.red, green: parts.green, blue: parts.blue, alpha: 0.5)
                
                titleLabel.text = houre.subject.title
                timeLabel.text = MPDate(seconds: houre.houre.integerValue).description
                
                timeLabel.textColor = houre.subject.color.getReadableTextColor()
                titleLabel.textColor = houre.subject.color.getReadableTextColor()
                lineView.backgroundColor = houre.subject.color
            }
        }
        get {
            return _houre
        }
    }
    
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        timeLabel = UILabel()
        titleLabel = UILabel()
        lineView = UIView()
        
        super.init(frame: frame)
        
        timeLabel.frame = CGRectMake(5, 0, self.frame.size.width*0.3-5, self.frame.size.height)
        timeLabel.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        self.addSubview(timeLabel)
        
        titleLabel.frame = CGRectMake(self.frame.size.width*0.3, 0, self.frame.size.width*0.7, self.frame.size.height)
        titleLabel.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        self.addSubview(titleLabel)
        
        lineView.frame = CGRectMake(0, 0, 3, self.frame.size.height)
        lineView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.contentView.addSubview(lineView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
