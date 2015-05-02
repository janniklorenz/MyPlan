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
    
    var _fetchedResultsController: NSFetchedResultsController?
    var fetchedResultsController: NSFetchedResultsController {
        
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = NSManagedObjectContext.MR_defaultContext()
        
        let req = NSFetchRequest()
        req.entity = InfoSubject.MR_entityDescription()
        req.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        req.predicate = NSPredicate(format: "(subject == %@)", self.subject!)
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self._fetchedResultsController = aFetchedResultsController
        
        var e: NSError?
        if !self._fetchedResultsController!.performFetch(&e) {
            println("fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self._fetchedResultsController!
    }
    
    
    
    
    // MARK: - Init
    
    required init(subject: Subject) {
        super.init(style: UITableViewStyle.Grouped)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellButton")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellColor")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerClass(MPTableViewCellTextInput.self, forCellReuseIdentifier: "TextInput")
        self.tableView.registerClass(MPTableViewCellSwitch.self, forCellReuseIdentifier: "Switch")
        self.tableView.registerClass(MPTableViewCellTextInputDual.self, forCellReuseIdentifier: "TextInputDual")
        
        self.subject = subject
        
        self.title = self.subject?.fullTitle
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    // MARK: - View Livestyle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add Info
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addInfo" )
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let saveSubject = self.subject {
            if saveSubject.deleted == false {
                MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
                    var s = saveSubject.MR_inContext(localContext) as! Subject
                    
                    s.notify = saveSubject.notify
                    s.usingMarks = saveSubject.usingMarks
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
            return 2
            
        case 3:
            let info = self.fetchedResultsController.sections![0] as! NSFetchedResultsSectionInfo
            return info.numberOfObjects
            
        case 4:
            return 1
            
        default:
            return 0;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String
        switch (indexPath.section, indexPath.row) {
        case (0, 0...1):
            reuseIdentifier = "TextInput"
        
        case (1, 0):
            reuseIdentifier = "CellColor"
        
        case (2, 0...1):
            reuseIdentifier = "Switch"
            
        case (3, 0...self.tableView(self.tableView, numberOfRowsInSection: 3)):
            reuseIdentifier = "TextInputDual"
            
        case (4, 0):
            reuseIdentifier = "CellButton"
            
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = .None
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            var cell = cell as! MPTableViewCellTextInput
            cell.textLabel?.text = NSLocalizedString("Title", comment: "")
            cell.textField.text = subject?.title
            cell.didChange = { text in
                self.subject?.title = text
                self.title = self.subject?.fullTitle
            }
        case (0, 1):
            var cell = cell as! MPTableViewCellTextInput
            cell.textLabel?.text = NSLocalizedString("Short", comment: "")
            cell.textField.text = subject?.titleShort
            cell.didChange = { text in
                self.subject?.titleShort = text
                self.title = self.subject?.fullTitle
            }
           
            
        case (1, 0):
            cell.textLabel?.text = NSLocalizedString("Color", comment: "")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.backgroundColor = subject?.color
            cell.textLabel?.textColor = subject?.color.getReadableTextColor()
            
            
        case (2, 0):
            var cell = cell as! MPTableViewCellSwitch
            cell.textLabel?.text = NSLocalizedString("Notifications", comment: "")
            if let on = subject?.notify.boolValue {
                cell.switchItem.on = on
            }
            cell.didChange = { value in
                subject?.notify = NSNumber(bool: value)
            }
            
            
        case (2, 1):
            var cell = cell as! MPTableViewCellSwitch
            cell.textLabel?.text = NSLocalizedString("Using marks", comment: "")
            if let on = subject?.usingMarks.boolValue {
                cell.switchItem.on = on
            }
            cell.didChange = { value in
                subject?.usingMarks = NSNumber(bool: value)
            }
            
            
        case (3, 0...self.tableView(self.tableView, numberOfRowsInSection: 3)):
            var cell = cell as! MPTableViewCellTextInputDual
            let info = self.fetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0)) as! InfoSubject
            cell.textField.text = info.key
            cell.detailTextField.text = info.value
            cell.didChange = {key, value in
                MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) -> Void in
                    var info = info.MR_inContext(localContext) as! InfoSubject
                    info.key = key
                    info.value = value
                    
                    localContext.MR_saveToPersistentStoreAndWait()
                })
            }
        
        case (4, 0):
            cell.textLabel?.text = NSLocalizedString("Delete Subject", comment: "")
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
            return NSLocalizedString("Title ans Short Version of the Subject", comment: "")
            
        case 1:
            return NSLocalizedString("Color of the Subject", comment: "")
           
        case 3:
            if self.tableView(self.tableView, numberOfRowsInSection: 3) != 0 {
                return NSLocalizedString("Assign the subject different values like room or teacher", comment: "")
            }
            
        case 4:
            return NSLocalizedString("Delete the subject and all related stuff like makrs, houres, and notes.\n Warning: This can't been undo!", comment: "")
            
        default:
            break
        }
        
        return "";
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
            var alert = UIAlertController(
                title: NSLocalizedString("Delete Subject", comment: ""),
                message: NSLocalizedString("Delete the subject and all related stuff like makrs, houres, and notes.\n Warning: This can't been undo!", comment: ""),
                preferredStyle: .ActionSheet
            )
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: UIAlertActionStyle.Destructive, handler: { (action: UIAlertAction!) -> Void in
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
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction!) -> Void in
                
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
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.section {
        case 3:
            return true
            
        default:
            break
        }
        return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if let subject = self.subject {
                MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
                    let info = self.fetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0)).MR_inContext(localContext) as! InfoSubject
                    info.MR_deleteInContext(localContext)
                    
                    localContext.MR_saveToPersistentStoreAndWait()
                }
            }
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
    
    
    
    
    
    
    // MARK: - UI Interaction
    func addInfo() {
        if let subject = self.subject {
            MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
                var info = InfoSubject.MR_createInContext(localContext) as! InfoSubject
                info.subject = subject.MR_inContext(localContext) as! Subject
                info.timestamp = NSDate()
                info.key = "key"
                info.value = "value"
                
                localContext.MR_saveToPersistentStoreAndWait()
            }
        }
    }
    
    
    
    
    
    // MAKR: - MPColorPickerViewControllerDelegate
    func didPickColor(color: UIColor) {
        self.subject?.color = color
        self.tableView.reloadData()
    }
    
    
    
    
    
    
    
    // MARK: - NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController, didChangeObject object: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: newIndexPath!.row, inSection: 3)], withRowAnimation: .Fade)
//        case .Update:
//            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPath!.row, inSection: 3))
//            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: indexPath!.row, inSection: 3)], withRowAnimation: .Fade)
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath!.row, inSection: 3)], withRowAnimation: .Fade)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: newIndexPath!.row, inSection: 3)], withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath!.row, inSection: 3)], withRowAnimation: .Fade)
        default:
            return
        }
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

}
