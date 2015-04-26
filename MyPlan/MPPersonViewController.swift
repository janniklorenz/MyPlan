//
//  MPPersonViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"



enum Dash {
    case ShowPlan(Plan)
    case ShowMarkGroup(MarkGroup)
    case Settings
    case Subjects
}





class MPPersonViewController: UICollectionViewController, NSFetchedResultsControllerDelegate, MPSubjectsViewControllerDefault {
    
    var cells: [Dash] = []
    
    var _person: Person?
    var person: Person? {
        set(newPerson) {
            if (_person != newPerson) {
                _person = newPerson
                
                cells = [.Settings, .Subjects]
                for plan in _person?.plans.allObjects as! [Plan] {
                    cells.append(.ShowPlan(plan))
                }
                for markGroup in _person?.markGroups.allObjects as! [MarkGroup] {
                    cells.append(.ShowMarkGroup(markGroup))
                }
                
                [self.collectionView?.reloadData()]
                
                println(_person?.objectID)
                
                self.title = self.person?.title
            }
        }
        get {
            if (_person == nil) {
                _person = Person.MR_findFirst() as! Person?
            }
            return _person!
        }
    }
    
    
    required init(person : Person) {
        var layout = UICollectionViewFlowLayout() //DMRCollectionViewLayout()
        layout.itemSize = CGSize(width: 85, height: 100)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        super.init(collectionViewLayout: layout)
        
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        self.person = person
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(DMRCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        // Reval Button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "RevalIcon"), style: UIBarButtonItemStyle.Bordered, target: self.revealViewController(), action: "revealToggle:")
        
        // Add mark
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "add")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DMRCollectionViewCell
        
        switch cells[indexPath.row] {
        case .ShowMarkGroup(let markGroup):
            cell.titleLabel.text = markGroup.title
            
        case .ShowPlan(let plan):
            cell.titleLabel.text = plan.title
            
        case .Settings:
            cell.titleLabel.text = "Settings"
            
        case .Subjects:
            cell.titleLabel.text = "Subjects"
            
            
        }
        
        
        
        // Configure the cell
        cell.backgroundColor = UIColor.whiteColor()
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch cells[indexPath.row] {
        case .ShowMarkGroup(let markGroup):
            let markGroupVC = MPMarkGroupViewController(markGroup: markGroup)
            self.navigationController?.pushViewController(markGroupVC, animated: true)
            
        case .ShowPlan(let plan):
            let planVC = MPPlanViewController(plan: plan)
            self.navigationController?.pushViewController(planVC, animated: true)
            
        case .Settings:
            if let person = self.person {
                let settingsVC = MPPersonSettingsViewController(person: person)
                var nav = UINavigationController(rootViewController: settingsVC)
                self.presentViewController(nav, animated: true) {}
            }
            
        case .Subjects:
            if let person = self.person {
                let subjectsVC = MPSubjectsViewController(person: person)
                subjectsVC.delegate = self
                var nav = UINavigationController(rootViewController: subjectsVC)
                self.presentViewController(nav, animated: true) {}
            }
            
        }
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    
    
    
    // MARK: - Add
    
    func add() {
        
        let alertController = UIAlertController(title: "New...", message: "Add something to the person", preferredStyle: .ActionSheet)
        
        let newPlan = UIAlertAction(title: "New Plan", style: .Default) { (action) in
            if let person = self.person {
                MagicalRecord.saveWithBlockAndWait { (var localContext: NSManagedObjectContext!) -> Void in
                    var plan = Plan.MR_createInContext(localContext) as! Plan
                    plan.title = "Plan"
                    plan.person = person.MR_inContext(localContext) as! Person
                    var days = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
                    var daysShort = ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"]
                    for i in 0...6 {
                        var day = Day.MR_createInContext(localContext) as! Day
                        day.plan = plan
                        day.weekIndex = i
                        day.title = days[i]
                        day.titleShort = daysShort[i]
                    }
                    
                    localContext.MR_saveToPersistentStoreWithCompletion({ (let succsess: Bool, let error: NSError!) -> Void in
                        self.cells.append(.ShowPlan((plan.MR_inThreadContext() as! Plan)))
                        self.collectionView?.insertItemsAtIndexPaths([NSIndexPath(forRow: self.cells.count-1, inSection: 0)])
                    })
                }
            }
        }
        alertController.addAction(newPlan)
        
        let newMarkGroup = UIAlertAction(title: "New Mark Group", style: .Default) { (action) in
            if let person = self.person {
                MagicalRecord.saveWithBlockAndWait { (var localContext: NSManagedObjectContext!) -> Void in
                    var markGroup = MarkGroup.MR_createInContext(localContext) as! MarkGroup
                    markGroup.title = "Noten"
                    markGroup.person = person.MR_inContext(localContext) as! Person
                    
                    localContext.MR_saveToPersistentStoreWithCompletion({ (let succsess: Bool, let error: NSError!) -> Void in
                        self.cells.append(.ShowMarkGroup((markGroup.MR_inThreadContext() as! MarkGroup)))
                        self.collectionView?.insertItemsAtIndexPaths([NSIndexPath(forRow: self.cells.count-1, inSection: 0)])
                    })
                }
            }
        }
        alertController.addAction(newMarkGroup)
        
        let newSubject = UIAlertAction(title: "New Subject", style: .Default) { (action) in
            if let person = self.person {
                MagicalRecord.saveWithBlockAndWait { (var localContext: NSManagedObjectContext!) -> Void in
                    var newSubject = Subject.MR_createInContext(localContext) as! Subject!
                    newSubject.person = person.MR_inContext(localContext) as! Person
                    newSubject.notify = NSNumber(bool: true);
                    newSubject.title = "New Subject"
                    
                    localContext.MR_saveToPersistentStoreWithCompletion({ (let succsess: Bool, let error: NSError!) -> Void in
                        let subjectVC = MPSubjectViewController(subject: (newSubject.MR_inThreadContext() as! Subject!))
                        var nav = UINavigationController(rootViewController: subjectVC)
                        self.presentViewController(nav, animated: true) {
                            
                        }
                    })
                }
            }
        }
        alertController.addAction(newSubject)
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            println(action)
        }
        alertController.addAction(cancel)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }

    }
    
    
    
    
    
    
    // MARK: - MPSubjectViewControllerDelegate
    
    func didSelectSubject(subject: Subject, subjectsVC: MPSubjectsViewController) {
        let subjectVC = MPSubjectViewController(subject: subject)
        var nav = UINavigationController(rootViewController: subjectVC)
        subjectsVC.presentViewController(nav, animated: true) {}
    }
    
        
    
    
    
    

}
