//
//  MPTableViewCellSlider.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation

class MPTableViewCellSlider: UITableViewCell {
    var slider: UISlider
    var didChange: ((value: Float) -> ())?
    
    
    
    
    
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        slider = UISlider()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        slider.frame = CGRectMake(self.separatorInset.left, 0, self.frame.size.width-self.separatorInset.left-self.separatorInset.right, self.frame.size.height)
        slider.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        slider.addTarget(self, action: "sliderDidChange", forControlEvents: .ValueChanged)
        self.addSubview(slider)
        
        self.selectionStyle = .None
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    // MARK: - UISlider Changes
    
    func sliderDidChange() {
        self.didChange?(value: self.slider.value)
    }
}