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

class MPPersonSettingsViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var person: Person?
    
    
    required init(person: Person) {
        super.init(style: UITableViewStyle.Grouped)
        
        self.person = person
        
        self.title = self.person?.title
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
    
    
    

}
