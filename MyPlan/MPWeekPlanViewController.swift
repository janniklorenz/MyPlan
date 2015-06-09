//
//  MPWeekPlanViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

import CoreData

class MPWeekPlanViewController: UITableViewController, NSFetchedResultsControllerDelegate, MPWeekPlanSettingsViewControllerDelegate {
    
    let kSectionDays = 0
    let kSectionSettings = 1
    
    var plan: WeekPlan? {
        didSet {
            self.title = plan?.title
        }
    }
    
    var _fetchedResultsController: NSFetchedResultsController?
    var fetchedResultsController: NSFetchedResultsController {
        
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = NSManagedObjectContext.MR_defaultContext()
        
        let req = NSFetchRequest()
        req.entity = Day.MR_entityDescription()
        req.sortDescriptors = [NSSortDescriptor(key: "weekIndex", ascending: true)]
        req.predicate = NSPredicate(format: "(plan == %@)", self.plan!)
        
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
    
    required init() {
        super.init(style: UITableViewStyle.Grouped)
        
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
        
        if self.navigationController?.viewControllers.count == 1 {
            // Reval Button
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "RevalIcon"), style: UIBarButtonItemStyle.Bordered, target: self.revealViewController(), action: "revealToggle:")
        }
    }
    
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case kSectionDays:
            let info = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
            return info.numberOfObjects
            
        case kSectionSettings:
            return 1
            
        default:
            return 0;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier: String
        switch (indexPath.section, indexPath.row) {
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        switch (indexPath.section, indexPath.row) {
        case (kSectionDays, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionDays)):
            let day = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Day
            cell.textLabel?.text = day.title
            cell.detailTextLabel?.text = String(day.houres.count) + " Stunde(n)"
            cell.detailTextLabel?.textColor = UIColor.grayColor()
            
        case (kSectionSettings, 0):
            cell.textLabel?.text = NSLocalizedString("Settings", comment: "")
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch (section) {
        case kSectionSettings:
            return NSLocalizedString("__Foother_Plan_Settings", comment: "")
            
        default:
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (kSectionDays, 0...self.tableView(self.tableView, numberOfRowsInSection: 0)):
            let day = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Day
            var dayVC = MPDayViewController()
            dayVC.day = day
            self.navigationController?.pushViewController(dayVC, animated: true)
            
        case (1, 0):
            if let plan = self.plan {
                let settingsVC = MPWeekPlanSettingsViewController()
                settingsVC.plan = plan
                settingsVC.delegate = self
                self.navigationController?.pushViewController(settingsVC, animated: true)
            }
            
        default:
            break
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
    
    
    
    
    
    
    // MARK: - MPPlanSettingsViewControllerDelegate
    
    func didFinishEditing(plan: WeekPlan) {
        self.plan = plan
    }
    func didDeletePlan(plan: WeekPlan) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    

}
