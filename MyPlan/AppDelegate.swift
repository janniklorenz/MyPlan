//
//  AppDelegate.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit




import CoreData
extension NSManagedObject {
    func addObject(value: NSManagedObject, forKey: String) {
        var items = self.mutableSetValueForKey(forKey);
        items.addObject(value)
    }
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MPMenuViewControllerDelegate {
    
    var window: UIWindow?
    var revealViewController: SWRevealViewController?
    
    var menuNavigationController: UINavigationController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        MagicalRecord.setupCoreDataStackWithStoreNamed("Data.xcdatamodeld")
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        var menuViewController = MPMenuViewController()
        
        if (Person.MR_countOfEntities() == 0) {
            MagicalRecord.saveWithBlockAndWait({ (localContext: NSManagedObjectContext!) -> Void in
                var person = Person.MR_createEntity() as! Person
                person.timestamp = NSDate()
                
                person.title = "Person"
                
                
                localContext.MR_saveToPersistentStoreAndWait()
            })
        }
        
        
        var personViewController = MPPersonViewController(person: Person.MR_findFirst() as! Person)
        menuViewController.delegate = self
        
        menuNavigationController = UINavigationController(rootViewController: menuViewController)
        var personNavigationController = UINavigationController(rootViewController: personViewController)
        
        revealViewController = SWRevealViewController(rearViewController: menuNavigationController, frontViewController: personNavigationController)
        
        
        revealViewController?.rearViewRevealWidth = 250;
        revealViewController?.rearViewRevealOverdraw = 0;
        revealViewController?.bounceBackOnOverdraw = true;
        revealViewController?.stableDragOnOverdraw = true;
//        revealViewController?.delegate = self;
        
        window?.rootViewController = revealViewController
        
        window?.makeKeyAndVisible()
        
        
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    
    // MARK: - MPMenuViewDelegate
    
    func openPerson(person:Person) {
        var personViewController = MPPersonViewController(person: person)
        var nav = UINavigationController(rootViewController: personViewController)
        self.revealViewController?.setFrontViewController(nav, animated: true)
        self.revealViewController?.revealToggleAnimated(true)
    }
    func openPlan(plan: Plan) {
        var planVC = MPPlanViewController(plan: plan)
        var nav = UINavigationController(rootViewController: planVC)
        self.revealViewController?.setFrontViewController(nav, animated: true)
        self.revealViewController?.revealToggleAnimated(true)
    }
    func openMarkGroup(markGroup: MarkGroup) {
        var marksVC = MPMarkGroupViewController(markGroup: markGroup)
        var nav = UINavigationController(rootViewController: marksVC)
        self.revealViewController?.setFrontViewController(nav, animated: true)
        self.revealViewController?.revealToggleAnimated(true)
    }
    func openSettings() {
        
    }
    
}

