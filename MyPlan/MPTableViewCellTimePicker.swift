//
//  MPTableViewCellTimePicker.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import Foundation

class MPTableViewCellTimePicker: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    var didChangeFrom: ((date: NSDateComponents) -> ())?
    var didChangeTo: ((date: NSDateComponents) -> ())?
    
    var dateFrom: NSDateComponents? {
        didSet {
            if let date = dateFrom {
                pickerView.selectRow(date.hour, inComponent: 0, animated: false)
                pickerView.selectRow(date.minute/5, inComponent: 1, animated: false)
                
                let formatter = NSDateComponentsFormatter()
                formatter.unitsStyle = .Positional
                
                labelFrom.text = formatter.stringFromDateComponents(date)
            }
        }
    }
    var dateTo: NSDateComponents? {
        didSet {
            if let date = dateTo {
                pickerView.selectRow(date.hour, inComponent: 3, animated: false)
                pickerView.selectRow(date.minute/5, inComponent: 4, animated: false)
                
                let formatter = NSDateComponentsFormatter()
                formatter.unitsStyle = .Positional
                
                labelTo.text = formatter.stringFromDateComponents(date)
            }
        }
    }
    
    var fullVisible: Bool {
        set (setFullVisible) {
            if setFullVisible {
                addSubview(pickerView)
            }
            else {
                pickerView.removeFromSuperview()
            }
        }
        get {
            return pickerView.hidden
        }
    }
    
    var labelFrom = UILabel()
    var labelTo = UILabel()
    
    let pickerView = UIPickerView()
    
    
    
    
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        separatorInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.autoresizingMask = .FlexibleWidth
        pickerView.frame = CGRectMake(0, 44, frame.size.width, 0)
        
        labelFrom.frame = CGRectMake(separatorInset.left, separatorInset.top, frame.size.width/2-separatorInset.left, 44)
        labelFrom.autoresizingMask = .FlexibleBottomMargin | .FlexibleRightMargin
        labelFrom.textAlignment = .Left
        addSubview(labelFrom)
        
        labelTo.frame = CGRectMake(frame.size.width/2, separatorInset.top, frame.size.width/2-separatorInset.right, 44)
        labelTo.autoresizingMask = .FlexibleBottomMargin | .FlexibleLeftMargin
        labelTo.textAlignment = .Right
        addSubview(labelTo)
        
        clipsToBounds = true
        self.selectionStyle = .None
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0, 3:
            return 24
            
        case 1, 4:
            return 12
            
        default:
            return 0
        }
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 2:
            return 80
            
        default:
            return 40
        }
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        switch component {
        case 0, 3:
            return "\(row)"
            
        case 1, 4:
            return "\(row*5)"
            
        default:
            return ""
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0...1:
            let date = NSDateComponents(
                hour: self.pickerView(pickerView, titleForRow: pickerView.selectedRowInComponent(0), forComponent: 0).toInt()!,
                minute: self.pickerView(pickerView, titleForRow: pickerView.selectedRowInComponent(1), forComponent: 1).toInt()!
            )
            self.didChangeFrom?(date: date)
            
        case 3...4:
            let date = NSDateComponents(
                hour: self.pickerView(pickerView, titleForRow: pickerView.selectedRowInComponent(3), forComponent: 3).toInt()!,
                minute: self.pickerView(pickerView, titleForRow: pickerView.selectedRowInComponent(4), forComponent: 4).toInt()!
            )
            self.didChangeTo?(date: date)
            
        default:
            break
        }
    }
//    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        
//    }
    
}