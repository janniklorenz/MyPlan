//
//  MPDayViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 17.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

class MPDayViewController: UICollectionViewController, NSFetchedResultsControllerDelegate, MPSubjectsViewControllerDefault, MPCalenderLayoutDelegate {
    
    var cells: [Houre]
    
    var day: Day? {
        didSet {
            if let day = day {
                self.title = day.fullTitle
                self.cells = Houre.MR_findAllSortedBy("houre", ascending: true, withPredicate: NSPredicate(format: "(day == %@)", day)) as! [Houre]
            }
        }
    }
    
    
    
    
    
    // MARK: - Init
    
    required init() {
        var layout = MPCalenderLayout()
        self.cells = [Houre]()
        
        super.init(collectionViewLayout: layout)
        
        var bView = UIView(frame: self.view.frame)
//        bView.autoresizingMask = .FlexibleHeight | .FlexibleWeight
        for i in 0...23 {
            var hView = UIView(frame: CGRectMake(0, CGFloat(i)*layout.houreHeight, bView.frame.size.width, layout.houreHeight))
            hView.backgroundColor = UIColor(red: CGFloat(i)/23, green: 0, blue: 0, alpha: 1)
            
            bView.addSubview(hView)
            
        }
        
        self.collectionView?.addSubview(bView)
        
        layout.delegate = self
        
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackgroundColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        cells = [Houre]()
        
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    
    // MARK: - View Livestyle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.registerClass(MPCollectionViewSubjectCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Add Houre Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addHoure" )
        
    }
    
    
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MPCollectionViewSubjectCell
        
        cell.houre = cells[indexPath.row]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let houre = cells[indexPath.row]
        var houreVC = MPHoureViewController()
        houreVC.houre = houre
        self.navigationController?.pushViewController(houreVC, animated: true)
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
    
    
    
    
    
    // MARK: - addHoure
    
    func addHoure() {
        var person = self.day!.plan.person
        var subjectVC = MPSubjectsViewController()
        subjectVC.person = person
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
            
            localContect.MR_saveToPersistentStoreWithCompletion({ (bool: Bool, error: NSError!) -> Void in
                self.cells.append((houre.MR_inThreadContext() as! Houre))
                self.collectionView?.reloadData()
            })
        }
    }
    
    
    
    
    
    // MARK: - MPSubjectViewControllerDelegate
    
//    func didSelectSubject(subject: Subject, subjectsVC: MPSubjectsViewController) {
//        let subjectVC = MPSubjectViewController(subject: subject)
//        var nav = UINavigationController(rootViewController: subjectVC)
//        subjectsVC.presentViewController(nav, animated: true) {}
//    }
    
    
    
    
    
    
    // MARK: - MPCalenderLayoutDelegate
    
    func dateForRowAtIndexPath(indexPath: NSIndexPath) -> MPDate {
        return MPDate(seconds: cells[indexPath.row].houre.integerValue)
    }
    
    func canMoveRowAtIndexPath(indexPath: NSIndexPath) -> Bool {
        return true
    }
    func didMoveRowAtIndexPath(indexPath: NSIndexPath, toDate: MPDate) {
        println(toDate.description)
    }
    func didDropRowAtIndexPath(indexPath: NSIndexPath, toDate: MPDate) {
        println(toDate.description)
        
        MagicalRecord.saveWithBlock { (localContect: NSManagedObjectContext!) -> Void in
            var houre = self.cells[indexPath.row].MR_inContext(localContect) as! Houre
            houre.houre = NSNumber(integer: toDate.seconds)
            
            localContect.MR_saveToPersistentStoreWithCompletion({ (bool: Bool, error: NSError!) -> Void in
                self.cells[indexPath.row] = houre.MR_inThreadContext() as! Houre
//                self.collectionView?.reloadItemsAtIndexPaths([indexPath])
                self.collectionView?.reloadData()
            })
        }
    }
    
    
    

}
