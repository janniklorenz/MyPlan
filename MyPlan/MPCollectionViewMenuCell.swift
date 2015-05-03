//
//  MPCollectionViewMenuCell.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 30.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

class MPCollectionViewMenuCell: UICollectionViewCell {
    
    var titleLabel: UILabel
    
    
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        
        super.init(frame: frame)
        
        titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        titleLabel.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        titleLabel.textAlignment = .Center
        addSubview(titleLabel)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
