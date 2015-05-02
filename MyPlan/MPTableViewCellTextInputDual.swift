//
//  MPTableViewCellTextInput.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation

class MPTableViewCellTextInputDual: UITableViewCell, UITextFieldDelegate {
    var textField: UITextField
    var detailTextField: UITextField
    var didChange: ((key: String, value: String) -> ())?
    
    
    
    
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        textField = UITextField()
        detailTextField = UITextField()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        textField.frame = CGRectMake(self.separatorInset.left, 0, self.frame.size.width*0.5-self.separatorInset.left, self.frame.size.height)
        textField.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        textField.textAlignment = .Left
        textField.returnKeyType = UIReturnKeyType.Next
        textField.addTarget(self, action: "textFieldDidChange", forControlEvents: .EditingChanged)
        textField.delegate = self
        self.addSubview(textField)
        
        detailTextField.frame = CGRectMake(self.frame.size.width*0.5, 0, self.frame.size.width*0.5-self.separatorInset.right, self.frame.size.height)
        detailTextField.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        detailTextField.textAlignment = .Right
        detailTextField.returnKeyType = UIReturnKeyType.Done
        detailTextField.addTarget(self, action: "textFieldDidChange", forControlEvents: .EditingChanged)
        detailTextField.delegate = self
        self.addSubview(detailTextField)
        
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
            self.detailTextField.resignFirstResponder()
        }
        super.setSelected(selected, animated: animated)
    }
    
    
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField === self.textField {
            self.detailTextField.becomeFirstResponder()
        }
        else if textField === self.detailTextField {
            self.detailTextField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidChange() {
        self.didChange?(key: self.textField.text, value: self.detailTextField.text)
    }
    
}