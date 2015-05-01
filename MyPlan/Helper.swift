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










class MPTableViewCellTextImput: UITableViewCell, UITextFieldDelegate {
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




class MPTableViewCellSubject: UITableViewCell {
    var colorView: UILabel
    
    var _subject: Subject?
    var subject: Subject? {
        set (newSubject) {
            self.colorView.text = newSubject!.titleShort
            
            self.colorView.backgroundColor = newSubject?.color
            self.colorView.textColor = newSubject?.color.getReadableTextColor()
            
            self.textLabel?.text = newSubject?.title
        }
        get {
            return _subject
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        colorView = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset = UIEdgeInsets(top: 0, left: self.frame.size.height+5, bottom: 0, right: 15)
        
        colorView.frame = CGRectMake(self.frame.size.height*0.1, self.frame.size.height*0.1, self.frame.size.height*0.8, self.frame.size.height*0.8)
        colorView.layer.cornerRadius = self.frame.size.height*0.4
        colorView.clipsToBounds = true
        colorView.textAlignment = .Center
        colorView.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        colorView.layer.borderColor = UIColor.blackColor().CGColor
        colorView.layer.borderWidth = 1
        self.addSubview(colorView)
        
        self.selectionStyle = .None
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
