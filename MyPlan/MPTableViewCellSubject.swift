//
//  MPTableViewCellSubject.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation

class MPTableViewCellSubject: UITableViewCell {
    
    var colorView: UILabel
    
    var subject: Subject? {
        didSet {
            self.colorView.text = subject!.titleShort
            
            self.colorView.backgroundColor = subject?.color
            self.colorView.textColor = subject?.color.getReadableTextColor()
            
            self.textLabel?.text = subject?.title
        }
    }
    
    
    
    
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        colorView = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: self.frame.size.height+5, bottom: 0, right: 15)
        
        colorView.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)
//        colorView.layer.cornerRadius = self.frame.size.height*0.4
        colorView.clipsToBounds = true
        colorView.textAlignment = .Center
        colorView.autoresizingMask = .FlexibleRightMargin | .FlexibleHeight
//        colorView.layer.borderColor = UIColor.blackColor().CGColor
//        colorView.layer.borderWidth = 1
        colorView.alpha = 0.8
        self.addSubview(colorView)
        
        self.selectionStyle = .None
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}