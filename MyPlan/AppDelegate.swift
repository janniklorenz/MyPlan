//
//  AppDelegate.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 07.04.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MPMenuViewControllerDelegate {
    
    var window: UIWindow?
    var revealViewController: SWRevealViewController?
    
    var menuNavigationController: UINavigationController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        MagicalRecord.setupCoreDataStackWithStoreNamed("Data.xcdatamodeld")
        
        if (Settings.MR_countOfEntities() == 0) {
            MagicalRecord.saveWithBlockAndWait({ (localContext: NSManagedObjectContext!) -> Void in
                var person: Person = Person.MR_createInContext(localContext) as! Person!
                person.setDefaults(localContext)
                
                var settings = Settings.MR_createInContext(localContext) as! Settings
                settings.setDefaults()
                settings.currentPerson = person.MR_inContext(localContext) as! Person
                
                localContext.MR_saveToPersistentStoreAndWait()
            })
        }
        
        let settings = Settings.MR_findFirst() as! Settings
        
        let menuViewController = MPMenuViewController()
        menuViewController.delegate = self
        
        menuNavigationController = UINavigationController(rootViewController: menuViewController)
        
        revealViewController = SWRevealViewController(rearViewController: menuNavigationController, frontViewController: nil)
        revealViewController?.rearViewRevealWidth = 250;
        revealViewController?.rearViewRevealOverdraw = 0;
        revealViewController?.bounceBackOnOverdraw = true;
        revealViewController?.stableDragOnOverdraw = true;
        
        openPerson(settings.currentPerson)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
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
        MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
            if let settings = (Settings.MR_findFirstInContext(localContext) as? Settings)  {
                settings.currentPerson = person.MR_inContext(localContext) as! Person
                
                localContext.MR_saveToPersistentStoreAndWait()
            }
        }
        
        let personVC = MPPersonViewController()
        personVC.person = person
        let nav = UINavigationController(rootViewController: personVC)
        self.revealViewController?.setFrontViewController(nav, animated: true)
        self.revealViewController?.revealToggleAnimated(true)
    }
    
    func openSettings() {
        let settingsVC = MPSettingsViewController()
        let nav = UINavigationController(rootViewController: settingsVC)
        self.revealViewController?.setFrontViewController(nav, animated: true)
        self.revealViewController?.revealToggleAnimated(true)
    }
    
    func deletePerson(person:Person) {
        MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
            let person = person.MR_inContext(localContext) as? Person
            person?.MR_deleteInContext(localContext)
            
            localContext.MR_saveToPersistentStoreWithCompletion({ (bool: Bool, error: NSError!) -> Void in
                self.openPerson(Person.MR_findFirstWithPredicate(NSPredicate(format: "(self != %@)", person!)) as! Person)
            })
        }
    }
    
    
    
    
    
}

