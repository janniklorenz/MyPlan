//
//  MPMenu.swift
//  MyPlan 5
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

import CoreData

protocol MPMenuViewControllerDelegate {
    func openPerson(person: Person)
    func openPlan(plan: Plan)
    func openMarkGroup(markGroup: MarkGroup)
    func openSettings()
}

class MPMenuViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var delegate: MPMenuViewControllerDelegate?
    
    var _personFetchedResultsController: NSFetchedResultsController?
    var personFetchedResultsController: NSFetchedResultsController {
        
        if self._personFetchedResultsController != nil {
            return self._personFetchedResultsController!
        }
        let managedObjectContext = NSManagedObjectContext.MR_defaultContext()
        
        let sort = NSSortDescriptor(key: "timestamp", ascending: false)
        
        let req = NSFetchRequest()
        req.entity = Person.MR_entityDescription()
        req.sortDescriptors = [sort]
//        req.predicate = NSPredicate(format: "(title=%@)", "Person")
    
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self._personFetchedResultsController = aFetchedResultsController
        
        var e: NSError?
        if !self._personFetchedResultsController!.performFetch(&e) {
            println("fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self._personFetchedResultsController!
    }
    
    
    
    
    required override init() {
        super.init(style: UITableViewStyle.Grouped)
        
        self.title = "Personen"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Person Button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addPerson" )
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let info = self.personFetchedResultsController.sections![0] as NSFetchedResultsSectionInfo
        return info.numberOfObjects+1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.personFetchedResultsController.sections![0] as NSFetchedResultsSectionInfo
        
        switch (section) {
            case info.numberOfObjects:
                return 1;
            default:
                let person = self.personFetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: section, inSection: 0)) as Person
                
                let plans = Plan.MR_countOfEntitiesWithPredicate(NSPredicate(format: "(person == %@)", person))
                let markGroup = MarkGroup.MR_countOfEntitiesWithPredicate(NSPredicate(format: "(person == %@)", person))
                return 1 + Int(plans) + Int(markGroup);
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        let info = self.personFetchedResultsController.sections![0] as NSFetchedResultsSectionInfo
        if (info.numberOfObjects == indexPath.section) {
            cell.textLabel?.text = "Settings"
        }
        else {
            let person = self.personFetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: indexPath.section, inSection: 0)) as Person
            
            let plans = Plan.MR_findAllWithPredicate(NSPredicate(format: "(person == %@)", person))
            let markGroup = MarkGroup.MR_findAllWithPredicate(NSPredicate(format: "(person == %@)", person))
            
            switch (indexPath.row) {
            case 0:
                cell.textLabel?.text = person.title
            case 1..<plans.count+1:
                var plan = plans[indexPath.row-1] as Plan
                cell.textLabel?.text = plan.title
            case plans.count+1..<plans.count+1+markGroup.count:
                var mark = markGroup[(indexPath.row-plans.count-1)] as MarkGroup
                cell.textLabel?.text = mark.title
            default:
                cell.textLabel?.text = ""
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let info = self.personFetchedResultsController.sections![0] as NSFetchedResultsSectionInfo
        if (info.numberOfObjects > indexPath.section) {
            let person = self.personFetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: indexPath.section, inSection: 0)) as Person
            switch (indexPath.row) {
            case 0:
                return 44
            default:
                return 34
            }
        }
        return 44
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.delegate != nil) {
            let person = self.personFetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: indexPath.section, inSection: 0)) as Person
            
            let plans = Plan.MR_findAllWithPredicate(NSPredicate(format: "(person == %@)", person))
            let markGroups = MarkGroup.MR_findAllWithPredicate(NSPredicate(format: "(person == %@)", person))
            
            switch (indexPath.row) {
            case 0:
                print(indexPath.row)
                self.delegate?.openPerson(person)
            case 1..<plans.count+1:
                var plan = plans[indexPath.row-1] as Plan
                self.delegate?.openPlan(plan)
            case plans.count+1..<plans.count+1+markGroups.count:
                var markGroup = markGroups[(indexPath.row-plans.count-1)] as MarkGroup
               self.delegate?.openMarkGroup(markGroup)
            default:
                break
            }
            
            
        }
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
            
            MagicalRecord.saveWithBlock { (var localContext:NSManagedObjectContext!) -> Void in
                let item = self.personFetchedResultsController.objectAtIndexPath(NSIndexPath(forRow: indexPath.section, inSection: 0)) as Person
                item.MR_inContext(localContext).MR_deleteEntity()
                
                localContext.MR_saveToPersistentStoreWithCompletion({ (var success:Bool, var error:NSError!) -> Void in
                    
                })
            }
            
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
    
    
    
    
    
    // MARK: - Add Person
    
    func addPerson() {
        MagicalRecord.saveWithBlock { (var localContext: NSManagedObjectContext!) -> Void in
            var person:Person = Person.MR_createInContext(localContext) as Person!
            person.timestamp = NSDate()
            person.title = "New Person"
            
            
            var subjectDeutsch = Subject.MR_createInContext(localContext) as Subject!
            subjectDeutsch.person = person;
            subjectDeutsch.notify = NSNumber(bool: true);
            subjectDeutsch.title = "Deutsch"
            
            var subjectEnglisch = Subject.MR_createInContext(localContext) as Subject!
            subjectEnglisch.person = person;
            subjectEnglisch.notify = NSNumber(bool: true);
            subjectEnglisch.title = "Englisch"
            
            var subjectMathe = Subject.MR_createInContext(localContext) as Subject!
            subjectMathe.person = person;
            subjectMathe.notify = NSNumber(bool: true);
            subjectMathe.title = "Mathe"
            
            var subjectPhysik = Subject.MR_createInContext(localContext) as Subject!
            subjectPhysik.person = person;
            subjectPhysik.notify = NSNumber(bool: true);
            subjectPhysik.title = "Physik"
            
            
            var plan = Plan.MR_createInContext(localContext) as Plan!
            plan.title = "Plan"
            plan.person = person
            var days = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
            var daysShort = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"]
            for i in 0...6 {
                var day = Day.MR_createInContext(localContext) as Day!
                day.plan = plan
                day.weekIndex = i
                day.title = days[i]
                day.titleShort = daysShort[i]
            }
            
            var markGroup = MarkGroup.MR_createInContext(localContext) as MarkGroup!
            markGroup.title = "Noten"
            markGroup.person = person
            
            localContext.MR_saveToPersistentStoreWithCompletion({ (var success:Bool, var error:NSError!) -> Void in
//                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
            })
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
    
    func controller(controller: NSFetchedResultsController, didChangeObject object: AnyObject, atIndexPath indexPath: NSIndexPath, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath) {
        print(indexPath.row)
        
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: newIndexPath.row), withRowAnimation: .Fade)
        case .Update:
            let cell = self.tableView.cellForRowAtIndexPath(indexPath)
            self.tableView.reloadSections(NSIndexSet(index: newIndexPath.row), withRowAnimation: .Fade)
//        case .Move:
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: indexPath.row), withRowAnimation: .Fade)
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