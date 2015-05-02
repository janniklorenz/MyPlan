//
//  MPPersonSettingsViewController.swift
//  MyPlan
//
//  Show the details of one subject and edit them
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

import CoreData

protocol MPPersonSettingsViewControllerDelegate {
    func didFinishEditingPerson(person: Person)
    func didDeletePerson(person: Person)
}

class MPPersonSettingsViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let kSectionTitle = 0
    let kSectionIO = 1
    let kSectionTimes = 2
    let kSectionDeletePerson = 3
    
    var person: Person?
    var delegate: MPPersonSettingsViewControllerDelegate?
    
    
    
    
    
    // MARK: - Init
    
    required init(person: Person) {
        super.init(style: UITableViewStyle.Grouped)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellButton")
        self.tableView.registerClass(MPTableViewCellTextInput.self, forCellReuseIdentifier: "TextInput")
        self.tableView.registerClass(MPTableViewCellSwitch.self, forCellReuseIdentifier: "Switch")
        
        self.person = person
        
        self.title = self.person?.title
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    // MARK: - View Livestyle
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let savePerson = self.person {
            if savePerson.deleted == false {
                MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
                    var p = savePerson.MR_inContext(localContext) as! Person
                    
                    p.title = savePerson.title
                    p.notify = savePerson.notify
                    
                    localContext.MR_saveToPersistentStoreAndWait()
                }
                self.delegate?.didFinishEditingPerson(savePerson)
            }
            else {
                self.delegate?.didDeletePerson(savePerson)
            }
        }
    }
    
    
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case kSectionTitle, kSectionIO, kSectionTimes:
            return 1
            
        case kSectionDeletePerson:
            if (Person.MR_countOfEntities() > 1) {
                return 1
            }
            
        default:
            break
        }
        
        return 0;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier: String
        switch (indexPath.section, indexPath.row) {
        case (kSectionTitle, 0):
            reuseIdentifier = "TextInput"
            
        case (kSectionIO, 0):
            reuseIdentifier = "Switch"
        
        case (kSectionDeletePerson, 0):
            reuseIdentifier = "CellButton"
            
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = .None
        
        switch (indexPath.section, indexPath.row) {
        case (kSectionTitle, 0):
            var cell = cell as! MPTableViewCellTextInput
            cell.textLabel?.text = NSLocalizedString("Title", comment: "")
            cell.textField.text = person?.title
            cell.didChange = { text in
                self.person?.title = text
                self.title = self.person?.title
            }
            
            
        case (kSectionIO, 0):
            var cell = cell as! MPTableViewCellSwitch
            cell.textLabel?.text = NSLocalizedString("Notifications", comment: "")
            if let on = person?.notify.boolValue {
                cell.switchItem.on = on
            }
            cell.didChange = { value in
                person?.notify = NSNumber(bool: value)
            }
            
        
        case (kSectionTimes, 0):
            cell.textLabel?.text = NSLocalizedString("Times", comment: "")
            cell.accessoryType = .DisclosureIndicator
            
            
        case (kSectionDeletePerson, 0):
            cell.textLabel?.text = NSLocalizedString("Delete Person", comment: "")
            cell.textLabel?.textAlignment = .Center
            cell.textLabel?.textColor = UIColor.redColor()
            
            
        default:
            break
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (kSectionTimes, 0):
            var defaultTimesVC = MPPersonSettingsDefaultTimesViewController(person: self.person!)
            self.navigationController?.pushViewController(defaultTimesVC, animated: true)
            
        case (kSectionDeletePerson, 0):
            let alert = UIAlertController(
                title: NSLocalizedString("Delete Person", comment: ""),
                message: NSLocalizedString("__Delete_Person_Ask", comment: ""),
                preferredStyle: .ActionSheet
            )
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: UIAlertActionStyle.Destructive, handler: { (action: UIAlertAction!) -> Void in
                if let person = self.person {
                    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.deletePerson(person)
                }
            }))
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction!) -> Void in
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch (section) {
        case kSectionTitle:
            return NSLocalizedString("__Foother_PersonSettings_Title", comment: "")
            
        case kSectionTimes:
            return NSLocalizedString("__Foother_PersonSettings_Times", comment: "")
            
        case kSectionDeletePerson:
            if (Person.MR_countOfEntities() > 1) {
                return NSLocalizedString("__Delete_Person_Ask", comment: "")
            }
            
        default:
            break
        }
        
        return "";
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    
    
    
    
    

}
