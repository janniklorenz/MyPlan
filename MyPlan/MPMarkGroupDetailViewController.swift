//
//  MPMarkViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

import CoreData

class MPMarkGroupDetailViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let kSectionMarks = 0
    
    var markGroup: MarkGroup?
    var subject: Subject? {
        didSet {
            self.title = subject?.title
        }
    }
    
    var fetchedResultsController: NSFetchedResultsController {
        
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = NSManagedObjectContext.MR_defaultContext()
        
        let sort = NSSortDescriptor(key: "title", ascending: false)
        
        let req = NSFetchRequest()
        req.entity = Mark.MR_entityDescription()
        req.sortDescriptors = [sort]
        req.predicate = NSPredicate(format: "(subject == %@) AND (markGroup == %@)", self.subject!, self.markGroup!)
        
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
    
    
    
    
    
    // MARK: - Init
    
    required init() {
        super.init(style: UITableViewStyle.Grouped)
        
        self.tableView.registerClass(MPTableViewCellSubtitle.self, forCellReuseIdentifier: "CellSubtitle")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    // MARK: - View Livestyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add mark
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addMark")
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case kSectionMarks:
            let info = self.fetchedResultsController.sections![0] as! NSFetchedResultsSectionInfo
            return info.numberOfObjects
        default: return 0;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier: String
        switch (indexPath.section, indexPath.row) {
        case (kSectionMarks, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionMarks)):
            reuseIdentifier = "CellSubtitle"
            
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        switch (indexPath.section, indexPath.row) {
        case (kSectionMarks, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionMarks)):
            let mark = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Mark
            cell.textLabel?.text = mark.title
            cell.detailTextLabel?.text = mark.mark.stringValue
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (kSectionMarks, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionMarks)):
            let mark = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Mark
            let markVC = MPMarkViewController()
            markVC.mark = mark
            self.navigationController?.pushViewController(markVC, animated: true)
            
        default:
            break
        }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch (indexPath.section, indexPath.row) {
        case (kSectionMarks, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionMarks)):
            return true
            
        default:
            return false
        }
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) -> Void in
                let mark = self.fetchedResultsController.objectAtIndexPath(indexPath).MR_inContext(localContext) as! Mark
                mark.MR_deleteInContext(localContext)
                
                localContext.MR_saveToPersistentStoreAndWait()
            })
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
    
    
    
    
    
    // MARK: - addMark
    func addMark() {
        MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
            var mark = Mark.MR_createInContext(localContext) as! Mark
            mark.timestamp = NSDate()
            mark.markGroup = self.markGroup?.MR_inContext(localContext) as! MarkGroup
            mark.subject = self.subject?.MR_inContext(localContext) as! Subject
            
            mark.mark = NSNumber(integer: Int(arc4random_uniform(7)))
            mark.judging = NSNumber(integer: 1)
            mark.title = "Test Mark"
            mark.text = "Lorem Ipsum"
            
            localContext.MR_saveToPersistentStoreAndWait()
        }
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
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    

}
