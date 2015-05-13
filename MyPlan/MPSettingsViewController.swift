//
//  MPSettingsViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

class MPSettingsViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let kSectionNotifications = 0
    let kSectionInfo = 1
    
    
    
    
    
    
    // MARK: - Init
    
    init() {
        super.init(style: .Grouped)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerClass(MPTableViewCellValue1.self, forCellReuseIdentifier: "CellValue1")
        self.tableView.registerClass(MPTableViewCellSwitch.self, forCellReuseIdentifier: "Switch")
        
        self.title = NSLocalizedString("Settings", comment: "")
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    
    // MARK: - View Livestyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reval Button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "RevalIcon"), style: UIBarButtonItemStyle.Bordered, target: self.revealViewController(), action: "revealToggle:")
    }
    
    
    
    
    
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionNotifications:
            return 1
         
        case kSectionInfo:
            return 2
            
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String
        switch indexPath.section {
        case kSectionNotifications:
            reuseIdentifier = "Switch"
            
        case kSectionInfo:
            reuseIdentifier = "CellValue1"
            
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = .None
        
        switch (indexPath.section, indexPath.row) {
        case (kSectionNotifications, 0):
            var cell = cell as! MPTableViewCellSwitch
            cell.textLabel?.text = NSLocalizedString("Notifications", comment: "")
            let settings = Settings.MR_findFirst() as! Settings
            cell.switchItem.on = settings.notifications.boolValue
            cell.didChange = { value in
                MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) -> Void in
                    let settings = settings.MR_inContext(localContext) as! Settings
                    settings.notifications = NSNumber(bool: value)
                    
                    localContext.MR_saveToPersistentStoreAndWait()
                })
                
            }
         
        case (kSectionInfo, 0):
            cell.textLabel?.text = "Version"
            cell.detailTextLabel?.text = (NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String)
            
        case (kSectionInfo, 1):
            cell.textLabel?.text = "Build"
            cell.detailTextLabel?.text = (NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String)
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch (section) {
        case kSectionNotifications:
            return ""
            
        default:
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
            
        default:
            break
        }
    }
    
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.section {
            
        default:
            return false
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    
    
    
    
}
