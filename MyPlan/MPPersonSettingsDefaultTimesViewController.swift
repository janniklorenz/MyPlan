//
//  MPPersonSettingsDefaultTimesViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

class MPPersonSettingsDefaultTimesViewController: UITableViewController, NSFetchedResultsControllerDelegate, MPDatePickerViewControllerDelegate {
    
    let kSectionDefaultTime = 0
    
    var person: Person?
    
    var selectedDateCell: NSIndexPath?
    
    var _fetchedResultsController: NSFetchedResultsController?
    var fetchedResultsController: NSFetchedResultsController {
        
        if let f = self._fetchedResultsController {
            return f
        }
        let managedObjectContext = NSManagedObjectContext.MR_defaultContext()
        
        let req = NSFetchRequest()
        req.entity = DefaultTime.MR_entityDescription()
        req.sortDescriptors = [NSSortDescriptor(key: "beginDateData", ascending: true)]
        if let person = self.person {
            req.predicate = NSPredicate(format: "(person == %@)", person)
        }
        
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
    
    init(person: Person) {
        super.init(style: .Grouped)
        
        self.person = person
        
        self.tableView.registerClass(MPTableViewCellTimePicker.self, forCellReuseIdentifier: "DateCell")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.title = NSLocalizedString("Times", comment: "")
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
        
        // Add mark
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addDefaultTime")
    }
    
    override func viewWillDisappear(animated: Bool) {
//       self.delegate?.didPickDate()
    }
    
    
    
    
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionDefaultTime:
            let info = self.fetchedResultsController.sections![kSectionDefaultTime] as! NSFetchedResultsSectionInfo
            return info.numberOfObjects
            
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String
        switch indexPath.section {
        default:
            reuseIdentifier = "DateCell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        switch (indexPath.section, indexPath.row) {
        case (kSectionDefaultTime, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionDefaultTime)):
            var cell = cell as! MPTableViewCellTimePicker
            let defaultTime = self.fetchedResultsController.objectAtIndexPath(indexPath) as! DefaultTime
            
            cell.dateFrom = defaultTime.beginDate
            cell.dateTo = defaultTime.endDate
            
            cell.didChangeFrom = { date in
                MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) -> Void in
                    let defaultTime = defaultTime.MR_inContext(localContext) as! DefaultTime
                    defaultTime.beginDate = date
                    
                    localContext.MR_saveToPersistentStoreAndWait()
                })
            }
            cell.didChangeTo = { date in
                MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) -> Void in
                    let defaultTime = defaultTime.MR_inContext(localContext) as! DefaultTime
                    defaultTime.endDate = date
                    
                    localContext.MR_saveToPersistentStoreAndWait()
                })
            }
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch (section) {
        default:
            return "";
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (kSectionDefaultTime, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionDefaultTime)):
            if selectedDateCell != indexPath {
                selectedDateCell = indexPath
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            else {
                self.tableView(tableView, didDeselectRowAtIndexPath: indexPath)
            }
            
        default:
            break
        }
    }
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (kSectionDefaultTime, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionDefaultTime)):
            var cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as! MPTableViewCellTimePicker
            selectedDateCell = nil
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        default:
            break
        }
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (kSectionDefaultTime, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionDefaultTime)):
            if indexPath == selectedDateCell {
                return 44+216
            }
            else {
                println("\(indexPath.section) \(indexPath.row)")
            }
            
        default:
            break
        }
        
        return 44
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.section {
        case kSectionDefaultTime:
            return true
            
        default:
            return false
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let defaultTime = self.fetchedResultsController.objectAtIndexPath(indexPath) as! DefaultTime
            MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) -> Void in
                var defaultTime = defaultTime.MR_inContext(localContext) as! DefaultTime
                defaultTime.MR_deleteInContext(localContext)
                
                localContext.MR_saveToPersistentStoreAndWait()
            })
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    
    
    
    
    // MARK: - UI Interaction
    
    func addDefaultTime() {
        if let person = self.person {
            MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
                var defaultTime = DefaultTime.MR_createInContext(localContext) as! DefaultTime
                defaultTime.person = person.MR_inContext(localContext) as! Person
                defaultTime.beginDate = MPDate()
                defaultTime.endDate = MPDate()
                
                localContext.MR_saveToPersistentStoreWithCompletion({ (bool: Bool, error: NSError!) -> Void in
                    
                })
            }
        }
    }
    
    
    
    
    
    // MARK: - MPDatePickerViewControllerDelegate
    
    func didPickDate(color: UIColor) {
        
    }
    
    
    
    
    
    
    
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject object: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Update:
            let cell = self.tableView.cellForRowAtIndexPath(indexPath!)
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .None)
        case .Move:
            if selectedDateCell == indexPath {
                selectedDateCell = newIndexPath
            }
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    
    
    
}
