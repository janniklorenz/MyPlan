//
//  MPSubjectViewController.swift
//  MyPlan
//
//  Show the details of one subject and edit them
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//
/*

- Title
- Short

- Color

- Notifications

- Subject Key Values
- ...
- ...

- Delete

*/

import UIKit

import CoreData

class MPSubjectViewController: UITableViewController, NSFetchedResultsControllerDelegate, MPColorPickerViewControllerDelegate {
    
    var _subject: Subject?
    var subject: Subject? {
        set(newSubject) {
            _subject = newSubject
            
            self.title = self.subject?.title
            self.tableView.reloadData()
        }
        get {
            return _subject
        }
    }
    
    
    
    
    required init(subject: Subject) {
        super.init(style: UITableViewStyle.Grouped)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerClass(MPTableViewCellTextImput.self, forCellReuseIdentifier: "TextInput")
        self.tableView.registerClass(MPTableViewCellSwitch.self, forCellReuseIdentifier: "Switch")
        
        self.subject = subject
        
        self.title = self.subject?.fullTitle
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    override func viewDidDisappear(animated: Bool) {
        if let saveSubject = self.subject {
            if saveSubject.deleted == false {
                MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
                    var s = saveSubject.MR_inContext(localContext) as! Subject
                    
                    s.notify = saveSubject.notify
                    s.title = saveSubject.title
                    s.titleShort = saveSubject.titleShort
                    s.color = saveSubject.color
                    
                    localContext.MR_saveToPersistentStoreAndWait()
                }
            }
        }
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 2
            
        case 1:
            return 1
            
        case 2:
            return 1
            
        case 3:
            return 0
            
        case 4:
            return 1
            
        default:
            return 0;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String
        switch (indexPath.section, indexPath.row) {
        case (0, 0), (0, 1):
            reuseIdentifier = "TextInput"
            
        case (2, 0):
            reuseIdentifier = "Switch"
            
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = .None
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            var cell = cell as! MPTableViewCellTextImput
            cell.textLabel?.text = "Title"
            cell.textField.text = subject?.title
            cell.didChange = { text in
                self.subject?.title = text
                self.title = self.subject?.fullTitle
            }
        case (0, 1):
            var cell = cell as! MPTableViewCellTextImput
            cell.textLabel?.text = "Short"
            cell.textField.text = subject?.titleShort
            cell.didChange = { text in
                self.subject?.titleShort = text
                self.title = self.subject?.fullTitle
            }
           
            
        case (1, 0):
            cell.textLabel?.text = "Color"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.backgroundColor = subject?.color
            cell.textLabel?.textColor = subject?.color.getReadableTextColor()
            
            
        case (2, 0):
            var cell = cell as! MPTableViewCellSwitch
            cell.textLabel?.text = "Notifications"
            if let on = subject?.notify.boolValue {
                cell.switchItem.on = on
            }
            
            cell.didChange = { value in
                subject?.notify = NSNumber(bool: value)
            }
            
            
        case (4, 0):
            cell.textLabel?.text = "Delete Subject"
            cell.textLabel?.textAlignment = .Center
            cell.textLabel?.textColor = UIColor.redColor()
            
            
        default:
            break
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Title ans Short Version of the Subject"
            
        case 1:
            return "Color of the Subject"
            
        case 2:
            return "Recive notification from this subject"
            
        case 4:
            return "Delete the subject and all related stuff like makrs, houres, and notes."
            
        default:
            return "";
        }
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            if let subject = self.subject {
                var colorPickerVC = MPColorPickerViewController(delegate: self)
                self.navigationController?.pushViewController(colorPickerVC, animated: true)
                colorPickerVC.color = subject.color
            }
            
        case (4, 0):
            var alert = UIAlertController(title: "Delete Subject", message: "Delete the subject and all related stuff like makrs, houres, and notes.\n Warning: This can't been undo!", preferredStyle: .ActionSheet)
            
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: { (action: UIAlertAction!) -> Void in
                if let subject = self.subject {
                    MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) -> Void in
                        var subject = subject.MR_inContext(localContext) as! Subject
                        subject.MR_deleteInContext(localContext)
                        localContext.MR_saveToPersistentStoreWithCompletion({ (bool: Bool, error: NSError!) -> Void in
                            self.navigationController?.popViewControllerAnimated(true)
                        })
                    })
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction!) -> Void in
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow() {
            var cell = self.tableView(tableView, cellForRowAtIndexPath: selectedIndexPath)
            cell.setSelected(false, animated: true)
        }
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
    
    
    
    
    // MAKR: - MPColorPickerViewControllerDelegate
    func didPickColor(color: UIColor) {
        self.subject?.color = color
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - removeSubject
    func removeSubject() {
        
//        let actionSheetController: UIAlertController = UIAlertController(title: "Delete", message: "Delete \(self.mark?.title) ?", preferredStyle: .Alert)
//        actionSheetController.addAction( UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in } )
//        actionSheetController.addAction( UIAlertAction(title: "Delete", style: .Default) { action -> Void in
//            MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
//                var mark = self.mark?.MR_inContext(localContext) as Mark
//                mark.MR_deleteEntity()
//                
//                localContext.MR_saveToPersistentStoreAndWait()
//            }
//            self.navigationController?.popViewControllerAnimated(true)
//        })
//        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    
    

}
