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

    var delegate: MPColorPickerViewControllerDelegate?
    
    var _oldNavBarSettings: (translucent: Bool, tintColor: UIColor, barTintColor: UIColor?)?
    
    var _color: UIColor?
    var color: UIColor {
        set (newColor) {
            _color = newColor
            self.tableView.reloadData()
            
            if let navigationController = self.navigationController {
                if _oldNavBarSettings == nil {
                    _oldNavBarSettings = (
                        navigationController.navigationBar.translucent,
                        navigationController.navigationBar.tintColor,
                        navigationController.navigationBar.barTintColor
                    )
                }
                navigationController.navigationBar.barTintColor = _color
                navigationController.navigationBar.tintColor = _color?.getReadableTextColor()
                navigationController.navigationBar.translucent = false
            }
            
        }
        get {
            if _color == nil {
                _color = UIColor()
            }
            return _color!
        }
    }
    
    
    // MARK: - Init
    init(delegate: MPColorPickerViewControllerDelegate) {
        super.init(style: .Grouped)
        
        self.delegate = delegate
        self.color = UIColor()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerClass(MPTableViewCellSlider.self, forCellReuseIdentifier: "Slider")
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
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
        case 0:
            return 8
        
        case 1:
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
        case (0, 0):
            cell.textLabel?.text = "Red"
        case (0, 1):
            cell.textLabel?.text = "Orange"
        case (0, 2):
            cell.textLabel?.text = "Yellow"
        case (0, 3):
            cell.textLabel?.text = "Blue"
        case (0, 4):
            cell.textLabel?.text = "Green"
        case (0, 5):
            cell.textLabel?.text = "Black"
        case (0, 6):
            cell.textLabel?.text = "White"
        case (0, 7):
            cell.textLabel?.text = "Brown"
        
            
        case (1, 0):
            var cell = cell as! MPTableViewCellSlider
            var parts = self.color.getRGBA()
            cell.slider.value = Float(parts.red)
            cell.slider.tintColor = UIColor.redColor()
            cell.didChange = { value in
                self.color = UIColor(red: CGFloat(value), green: CGFloat(parts.green), blue: CGFloat(parts.blue), alpha: CGFloat(parts.alpha))
            }
            
        case (1, 1):
            var cell = cell as! MPTableViewCellSlider
            var parts = self.color.getRGBA()
            cell.slider.value = Float(parts.green)
            cell.slider.tintColor = UIColor.greenColor()
            cell.didChange = { value in
                self.color = UIColor(red: CGFloat(parts.red), green: CGFloat(value), blue: CGFloat(parts.blue), alpha: CGFloat(parts.alpha))
            }
            
        case (1, 2):
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
        case 1:
            return "Red, Green and Blue (RGB) Sliders"
            
        default:
            return "";
        }
    }
    

    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            self.color = UIColor.redColor()
        case (0, 1):
            self.color = UIColor.orangeColor()
        case (0, 2):
            self.color = UIColor.yellowColor()
        case (0, 3):
            self.color = UIColor.blueColor()
        case (0, 4):
            self.color = UIColor.greenColor()
        case (0, 5):
            self.color = UIColor.blackColor()
        case (0, 6):
            self.color = UIColor.whiteColor()
        case (0, 7):
            self.color = UIColor.brownColor()
            
        default:
            break
        }
    }

    
    
}
