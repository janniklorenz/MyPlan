//
//  MPMenu.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

import CoreData

protocol MPMenuViewControllerDelegate {
    func openPerson(person: Person)
    func openSettings()
}

class MPMenuViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let kSectionPersons = 0
    let kSectionSettings = 1
    
    var delegate: MPMenuViewControllerDelegate?
    
    var _fetchedResultsController: NSFetchedResultsController?
    var fetchedResultsController: NSFetchedResultsController {
        
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = NSManagedObjectContext.MR_defaultContext()
        
        let req = NSFetchRequest()
        req.entity = Person.MR_entityDescription()
        req.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
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
        
        self.title = NSLocalizedString("Persons", comment: "")
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
        
        // Add Person Button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addPerson" )
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case kSectionPersons:
            let info = self.fetchedResultsController.sections![kSectionPersons] as! NSFetchedResultsSectionInfo
            return info.numberOfObjects
            
        case kSectionSettings:
            return 1
            
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier: String
        switch indexPath.section {
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = .None
        
        switch (indexPath.section, indexPath.row) {
        case (kSectionPersons, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionPersons)):
            let person = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Person
            cell.textLabel?.text = person.title
            
        case (kSectionSettings, 0):
            cell.textLabel?.text = NSLocalizedString("Settings", comment: "")
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (kSectionPersons, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionPersons)):
            let person = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Person
            self.delegate?.openPerson(person)
            
        case (kSectionSettings, 0):
            self.delegate?.openSettings()
            
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch (indexPath.section, indexPath.row) {
        case (kSectionPersons, 0...self.tableView(self.tableView, numberOfRowsInSection: kSectionPersons)):
            return true
            
        default:
            return false
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            MagicalRecord.saveWithBlock { (var localContext:NSManagedObjectContext!) -> Void in
                let person = self.fetchedResultsController.objectAtIndexPath(indexPath).MR_inContext(localContext) as! Person
                person.MR_deleteInContext(localContext)
                
                localContext.MR_saveToPersistentStoreAndWait()
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
    
    
    
    
    
    
    // MARK: - Add Person
    
    func addPerson() {
        MagicalRecord.saveWithBlock { (var localContext: NSManagedObjectContext!) -> Void in
            var person:Person = Person.MR_createInContext(localContext) as! Person!
            person.timestamp = NSDate()
            person.title = NSLocalizedString("New Person", comment: "")
            
            
            var subjectDeutsch = Subject.MR_createInContext(localContext) as! Subject!
            subjectDeutsch.timestamp = NSDate()
            subjectDeutsch.person = person;
            subjectDeutsch.notify = NSNumber(bool: true);
            subjectDeutsch.usingMarks = NSNumber(bool: true);
            subjectDeutsch.title = "Deutsch"
            subjectDeutsch.titleShort = "D"
            subjectDeutsch.color = UIColor.blackColor()
            
            var subjectEnglisch = Subject.MR_createInContext(localContext) as! Subject!
            subjectEnglisch.timestamp = NSDate()
            subjectEnglisch.person = person;
            subjectEnglisch.notify = NSNumber(bool: true);
            subjectEnglisch.usingMarks = NSNumber(bool: true);
            subjectEnglisch.title = "Englisch"
            subjectEnglisch.titleShort = "E"
            subjectEnglisch.color = UIColor.redColor()
            
            var subjectMathe = Subject.MR_createInContext(localContext) as! Subject!
            subjectMathe.timestamp = NSDate()
            subjectMathe.person = person;
            subjectMathe.notify = NSNumber(bool: true);
            subjectMathe.usingMarks = NSNumber(bool: true);
            subjectMathe.title = "Mathe"
            subjectMathe.titleShort = "M"
            subjectMathe.color = UIColor.blueColor()
            
            var subjectPhysik = Subject.MR_createInContext(localContext) as! Subject!
            subjectPhysik.timestamp = NSDate()
            subjectPhysik.person = person;
            subjectPhysik.notify = NSNumber(bool: true);
            subjectPhysik.usingMarks = NSNumber(bool: true);
            subjectPhysik.title = "Physik"
            subjectPhysik.titleShort = "Ph"
            subjectPhysik.color = UIColor.whiteColor()
            
            var plan = Plan.MR_createInContext(localContext) as! Plan!
            plan.title = "Plan"
            plan.person = person
            var days = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
            var daysShort = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"]
            for i in 0...6 {
                var day = Day.MR_createInContext(localContext) as! Day!
                day.plan = plan
                day.weekIndex = i
                day.title = days[i]
                day.titleShort = daysShort[i]
            }
            
            var markGroup = MarkGroup.MR_createInContext(localContext) as! MarkGroup!
            markGroup.title = "Noten"
            markGroup.person = person
            
            var time0 = DefaultTime.MR_createInContext(localContext) as! DefaultTime
            time0.person = person
            time0.beginDate = MPDate(houre: 7, minute: 45, seconds: 00)
            time0.endDate = MPDate(houre: 9, minute: 15, seconds: 00)
            
            var time1 = DefaultTime.MR_createInContext(localContext) as! DefaultTime
            time1.person = person
            time1.beginDate = MPDate(houre: 9, minute: 35, seconds: 00)
            time1.endDate = MPDate(houre: 11, minute: 05, seconds: 00)
            
            var time2 = DefaultTime.MR_createInContext(localContext) as! DefaultTime
            time2.person = person
            time2.beginDate = MPDate(houre: 11, minute: 25, seconds: 00)
            time2.endDate = MPDate(houre: 12, minute: 55, seconds: 00)
            
            localContext.MR_saveToPersistentStoreWithCompletion({ (var success:Bool, var error:NSError!) -> Void in
//                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
            })
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
