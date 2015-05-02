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
    
    var person: Person?
    var delegate: MPPersonSettingsViewControllerDelegate?
    
    
    
    
    
    // MARK: - Init
    
    required init(person: Person) {
        super.init(style: UITableViewStyle.Grouped)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0, 1, 2:
            return 1
            
        default:
            return 0;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier: String
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            reuseIdentifier = "TextInput"
            
        case (1, 0):
            reuseIdentifier = "Switch"
            
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            var cell = cell as! MPTableViewCellTextInput
            cell.textLabel?.text = NSLocalizedString("Title", comment: "")
            cell.textField.text = person?.title
            cell.didChange = { text in
                self.person?.title = text
                self.title = self.person?.title
            }
            
            
        case (1, 0):
            var cell = cell as! MPTableViewCellSwitch
            cell.textLabel?.text = NSLocalizedString("Notifications", comment: "")
            if let on = person?.notify.boolValue {
                cell.switchItem.on = on
            }
            cell.didChange = { value in
                person?.notify = NSNumber(bool: value)
            }
            
        
        case (2, 0):
            cell.textLabel?.text = "Times"
            cell.accessoryType = .DisclosureIndicator
            
            
        default:
            break
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (2, 0):
            var defaultTimesVC = MPPersonSettingsDefaultTimesViewController(person: self.person!)
            self.navigationController?.pushViewController(defaultTimesVC, animated: true)
            
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Title of the Person"
            
        case  2:
            return "Set custom times to add houres faster"
            
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
