//
//  MPTableViewCellSwitch.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation

class MPTableViewCellSwitch: UITableViewCell {
    var switchItem: UISwitch
    var didChange: ((value: Bool) -> ())?
    
    
    
    
    
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        switchItem = UISwitch()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        switchItem.frame = CGRectMake(self.frame.size.width-self.separatorInset.right-switchItem.frame.size.width, (self.frame.size.height-switchItem.frame.size.height)/2, switchItem.frame.size.width, switchItem.frame.size.height)
        switchItem.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin
        switchItem.addTarget(self, action: "switchDidChange", forControlEvents: .ValueChanged)
        self.addSubview(switchItem)
        
        self.selectionStyle = .None
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - UISwitch Changes
    
    func switchDidChange() {
        self.didChange?(value: self.switchItem.on)
    }
}