//
//  MPColorPickerViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

protocol MPColorPickerViewControllerDelegate {
    func didPickColor(color: UIColor)
}

class MPColorPickerViewController: UITableViewController {

    let kSectionStatic = 0
    let kSectionRGB = 1
    
    var delegate: MPColorPickerViewControllerDelegate?
    
    var _oldNavBarSettings: (translucent: Bool, tintColor: UIColor, barTintColor: UIColor?)?
    
    var color = UIColor() {
        didSet {
            self.tableView.reloadData()
            
            if let navigationController = self.navigationController {
                if _oldNavBarSettings == nil {
                    _oldNavBarSettings = (
                        navigationController.navigationBar.translucent,
                        navigationController.navigationBar.tintColor,
                        navigationController.navigationBar.barTintColor
                    )
                }
                navigationController.navigationBar.barTintColor = color
                navigationController.navigationBar.tintColor = color.getReadableTextColor()
                navigationController.navigationBar.translucent = false
            }
        }
    }
    
    
    
    
    
    // MARK: - Init
    
    init(delegate: MPColorPickerViewControllerDelegate) {
        super.init(style: .Grouped)
        
        self.delegate = delegate
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerClass(MPTableViewCellSlider.self, forCellReuseIdentifier: "Slider")
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    // MARK: - View Livestyle
    
    override func viewWillDisappear(animated: Bool) {
       self.delegate?.didPickColor(self.color)
        
        if let navigationController = self.navigationController {
            if let oldNavBarSettings = self._oldNavBarSettings {
                navigationController.navigationBar.barTintColor = oldNavBarSettings.barTintColor
                navigationController.navigationBar.tintColor = oldNavBarSettings.tintColor
                navigationController.navigationBar.translucent = oldNavBarSettings.translucent
            }
        }
    }
    
    
    
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionStatic:
            return 8
        
        case kSectionRGB:
            return 3
            
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String
        switch indexPath.section {
        case 1:
            reuseIdentifier = "Slider"
            
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = .None
        
        switch (indexPath.section, indexPath.row) {
        case (kSectionStatic, 0):
            cell.textLabel?.text = NSLocalizedString("Red", comment: "")
        case (kSectionStatic, 1):
            cell.textLabel?.text = NSLocalizedString("Orange", comment: "")
        case (kSectionStatic, 2):
            cell.textLabel?.text = NSLocalizedString("Yellow", comment: "")
        case (kSectionStatic, 3):
            cell.textLabel?.text = NSLocalizedString("Blue", comment: "")
        case (kSectionStatic, 4):
            cell.textLabel?.text = NSLocalizedString("Green", comment: "")
        case (kSectionStatic, 5):
            cell.textLabel?.text = NSLocalizedString("Black", comment: "")
        case (kSectionStatic, 6):
            cell.textLabel?.text = NSLocalizedString("White", comment: "")
        case (kSectionStatic, 7):
            cell.textLabel?.text = NSLocalizedString("Brown", comment: "")
        
            
        case (kSectionRGB, 0):
            var cell = cell as! MPTableViewCellSlider
            var parts = self.color.getRGBA()
            cell.slider.value = Float(parts.red)
            cell.slider.tintColor = UIColor.redColor()
            cell.didChange = { value in
                self.color = UIColor(red: CGFloat(value), green: CGFloat(parts.green), blue: CGFloat(parts.blue), alpha: CGFloat(parts.alpha))
            }
            
        case (kSectionRGB, 1):
            var cell = cell as! MPTableViewCellSlider
            var parts = self.color.getRGBA()
            cell.slider.value = Float(parts.green)
            cell.slider.tintColor = UIColor.greenColor()
            cell.didChange = { value in
                self.color = UIColor(red: CGFloat(parts.red), green: CGFloat(value), blue: CGFloat(parts.blue), alpha: CGFloat(parts.alpha))
            }
            
        case (kSectionRGB, 2):
            var cell = cell as! MPTableViewCellSlider
            var parts = self.color.getRGBA()
            cell.slider.value = Float(parts.blue)
            cell.slider.tintColor = UIColor.blueColor()
            cell.didChange = { value in
                self.color = UIColor(red: CGFloat(parts.red), green: CGFloat(parts.green), blue: CGFloat(value), alpha: CGFloat(parts.alpha))
            }
            
        default:
            break
        }
        
        

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch (section) {
        case kSectionRGB:
            return NSLocalizedString("__Foother_ColorPicker_RGB", comment: "")
            
        default:
            return "";
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (kSectionStatic, 0):
            self.color = UIColor.redColor()
        case (kSectionStatic, 1):
            self.color = UIColor.orangeColor()
        case (kSectionStatic, 2):
            self.color = UIColor.yellowColor()
        case (kSectionStatic, 3):
            self.color = UIColor.blueColor()
        case (kSectionStatic, 4):
            self.color = UIColor.greenColor()
        case (kSectionStatic, 5):
            self.color = UIColor.blackColor()
        case (kSectionStatic, 6):
            self.color = UIColor.whiteColor()
        case (kSectionStatic, 7):
            self.color = UIColor.brownColor()
            
        default:
            break
        }
    }

    
    
}
