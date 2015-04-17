//
//  MPSubjectViewController.swift
//  MyPlan 5
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

import CoreData

protocol MPSubjectViewControllerDelegate {
    func didSaveSubject(subject: Subject)
}

class MPSubjectViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var delegate: MPSubjectViewControllerDelegate?
    
    var _subject: Subject?
    var subject: Subject? {
        set {
            _subject = subject
            
            self.title = self.subject?.title
        }
        get {
            return _subject
        }
    }
    
//    var fetchedResultsController: NSFetchedResultsController {
//        
//        if self._fetchedResultsController != nil {
//            return self._fetchedResultsController!
//        }
//        let managedObjectContext = NSManagedObjectContext.MR_defaultContext()
//        
//        let sort = NSSortDescriptor(key: "title", ascending: false)
//        
//        let req = NSFetchRequest()
//        req.entity = Mark.MR_entityDescription()
//        req.sortDescriptors = [sort]
//        req.predicate = NSPredicate(format: "(subject == %@) AND (markGroup == %@)", self.subject!, self.markGroup!)
//        
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
//        aFetchedResultsController.delegate = self
//        self._fetchedResultsController = aFetchedResultsController
//        
//        var e: NSError?
//        if !self._fetchedResultsController!.performFetch(&e) {
//            println("fetch error: \(e!.localizedDescription)")
//            abort();
//        }
//        
//        return self._fetchedResultsController!
//    }
//    var _fetchedResultsController: NSFetchedResultsController?
    
    
    required override init() {
        super.init(style: UITableViewStyle.Grouped)
        
        self.title = self.subject?.title
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Close Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "close" )
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
//        case 0:
//            let info = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
//            return info.numberOfObjects
        default: return 0;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
//        let mark = self.fetchedResultsController.objectAtIndexPath(indexPath) as Mark
//        cell.textLabel?.text = mark.title
//        cell.detailTextLabel?.text = mark.mark.stringValue
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
    
    
    
    
    
    
    // MARK: - close
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
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
    func controller(controller: NSFetchedResultsController, didChangeObject object: AnyObject, atIndexPath indexPath: NSIndexPath, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath) {
            switch type {
            case .Insert:
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            case .Update:
                let cell = self.tableView.cellForRowAtIndexPath(indexPath)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            case .Move:
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
