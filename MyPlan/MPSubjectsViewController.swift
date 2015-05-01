//
//  MPSubjectsViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

import CoreData

protocol MPSubjectsViewControllerDefault {
    func didSelectSubject(subject: Subject, subjectsVC: MPSubjectsViewController)
}

class MPSubjectsViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var person: Person?
    var delegate: MPSubjectsViewControllerDefault?
    
    var fetchedResultsController: NSFetchedResultsController {
        
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = NSManagedObjectContext.MR_defaultContext()
        
        let req = NSFetchRequest()
        req.entity = Subject.MR_entityDescription()
        req.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true), NSSortDescriptor(key: "titleShort", ascending: true)]
        req.predicate = NSPredicate(format: "(person == %@)", self.person!)
        
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
    var _fetchedResultsController: NSFetchedResultsController?
    
    
    required init(person: Person) {
        super.init(style: UITableViewStyle.Grouped)
        
        self.tableView.registerClass(MPTableViewCellSubject.self, forCellReuseIdentifier: "Subject")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.person = person
        
        self.title = "Subjects"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.navigationController?.viewControllers.count == 1 {
            // Close Button
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "close" )
        }
        
        // Add Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addSubject" )
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            let info = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
            return info.numberOfObjects

        default: return 0;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            reuseIdentifier = "Cell"
            
        default:
            reuseIdentifier = "Subject"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        switch (indexPath.section) {
        case 0:
            var cell = cell as! MPTableViewCellSubject
            let subject = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Subject
            cell.subject = subject
            
        default:
            break
        }
        
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section) {
        case 0:
            let subject = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Subject
            self.delegate?.didSelectSubject(subject, subjectsVC: self)
            
        default:
            break
        }
        
        
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return true
            
        default:
            return false
        }
    }
    

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            var alert = UIAlertController(title: "Delete Subject", message: "Delete the subject and all related stuff like makrs, houres, and notes.\n Warning: This can't been undo!", preferredStyle: .ActionSheet)
            
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: { (action: UIAlertAction!) -> Void in
                let subject = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Subject
                MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) -> Void in
                    var subject = subject.MR_inContext(localContext) as! Subject
                    subject.MR_deleteInContext(localContext)
                    localContext.MR_saveToPersistentStoreAndWait()
                })
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction!) -> Void in
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
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
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addSubject() {
        if let person = self.person {
            MagicalRecord.saveWithBlockAndWait { (var localContext: NSManagedObjectContext!) -> Void in
                var newSubject = Subject.MR_createInContext(localContext) as! Subject!
                newSubject.person = person.MR_inContext(localContext) as! Person
                newSubject.notify = NSNumber(bool: true);
                newSubject.title = "New Subject"
                newSubject.titleShort = ""
                newSubject.color = UIColor.whiteColor()
                
                localContext.MR_saveToPersistentStoreWithCompletion({ (let succsess: Bool, let error: NSError!) -> Void in
                    let subjectVC = MPSubjectViewController(subject: (newSubject.MR_inThreadContext() as! Subject!))
                    self.navigationController?.pushViewController(subjectVC, animated: true)
                })
            }
        }
    }
    
    
    
    
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    /* called first
    begins update to `UITableView`
    ensures all updates are animated simultaneously */
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    /* called:
    - when a new model is created
    - when an existing model is updated
    - when an existing model is deleted */
    func controller(controller: NSFetchedResultsController, didChangeObject object: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
            switch type {
            case .Insert:
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Update:
                let cell = self.tableView.cellForRowAtIndexPath(indexPath!)
                self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Move:
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            default:
                return
            }
    }
    
    /* called last
    tells `UITableView` updates are complete */
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    

}
