//
//  MPDayViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

import CoreData

class MPDayViewController: UITableViewController, NSFetchedResultsControllerDelegate, MPSubjectsViewControllerDefault {
    
    var day: Day?
    
    var fetchedResultsController: NSFetchedResultsController {
        
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = NSManagedObjectContext.MR_defaultContext()
        
        let sort = NSSortDescriptor(key: "houre", ascending: true)
        
        let req = NSFetchRequest()
        req.entity = Houre.MR_entityDescription()
        req.sortDescriptors = [sort]
        req.predicate = NSPredicate(format: "(day == %@)", self.day!)
        
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
    
    
    required init(day: Day) {
        super.init(style: UITableViewStyle.Grouped)
        
        self.day = day
        
        self.title = self.day?.title
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Houre Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addHoure" )
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
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        let houre = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Houre
        cell.textLabel?.text = houre.houre.stringValue + ". " + houre.subject.title
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let houre = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Houre
        var houreVC = MPHoureViewController(houre: houre)
        self.navigationController?.pushViewController(houreVC, animated: true)
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) -> Void in
                let houre = self.fetchedResultsController.objectAtIndexPath(indexPath).MR_inContext(localContext) as! Houre
                houre.MR_deleteInContext(localContext)
                
                localContext.MR_saveToPersistentStoreAndWait()
            })
        } else if editingStyle == .Insert {
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

    
    
    
    
    // MARK: - addHoure
    
    func addHoure() {
        var person = self.day!.plan.person
        var subjectVC = MPSubjectsViewController(person: person)
        subjectVC.delegate = self
        var nav = UINavigationController(rootViewController: subjectVC)
        self.presentViewController(nav, animated: true) { () -> Void in
            
        }
    }
    
    
    
    // MARK: - MPSubjectsViewControllerDefault
    
    func didSelectSubject(subject: Subject, subjectsVC: MPSubjectsViewController) {
        
        subjectsVC.dismissViewControllerAnimated(true) {}
        
        MagicalRecord.saveWithBlock { (localContect: NSManagedObjectContext!) -> Void in
            var houre = Houre.MR_createInContext(localContect) as! Houre
            houre.subject = subject.MR_inContext(localContect) as! Subject
            houre.day = self.day!.MR_inContext(localContect) as! Day
            
            // DEBUG ONLY
            let info = self.fetchedResultsController.sections![0] as! NSFetchedResultsSectionInfo
            houre.houre = NSNumber(integer: info.numberOfObjects)
            
            localContect.MR_saveToPersistentStoreAndWait()
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
