//
//  MPTableViewCellTextInput.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation

class MPTableViewCellTextInput: UITableViewCell, UITextFieldDelegate {
    var textField: UITextField
    var didChange: ((text: String) -> ())?
    
    
    
    
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        textField = UITextField()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        textField.frame = CGRectMake(self.frame.size.width*0.5, 0, self.frame.size.width*0.5-self.separatorInset.right, self.frame.size.height)
        textField.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        textField.textAlignment = .Right
        textField.returnKeyType = UIReturnKeyType.Done
        textField.addTarget(self, action: "textFieldDidChange", forControlEvents: .EditingChanged)
        textField.delegate = self
        self.addSubview(textField)
        
        self.selectionStyle = .None
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Toggle Selection
    override func setSelected(selected: Bool, animated: Bool) {
        if selected {
            self.textField.becomeFirstResponder()
        }
        else {
            self.textField.resignFirstResponder()
        }
        super.setSelected(selected, animated: animated)
    }
    
    
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidChange() {
        self.didChange?(text: self.textField.text)
    }
    
}