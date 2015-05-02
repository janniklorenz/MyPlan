//
//  MPPlanSettingsViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

protocol MPPlanSettingsViewControllerDelegate {
    func didFinishEditing(plan: Plan)
    func didDeletePlan(plan: Plan)
}

class MPPlanSettingsViewController: UITableViewController {
    
    let kSectionTitle = 0
    
    var delegate: MPPlanSettingsViewControllerDelegate?
    
    var plan: Plan?
    
    
    
    
    
    
    // MARK: - Init
    
    init(plan: Plan) {
        super.init(style: .Grouped)
        
        self.plan = plan
        
        self.tableView.registerClass(MPTableViewCellTextInput.self, forCellReuseIdentifier: "TextInput")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    
    // MARK: - View Livestyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let savePlan = self.plan {
            if savePlan.deleted == false {
                MagicalRecord.saveWithBlock { (localContext: NSManagedObjectContext!) -> Void in
                    var p = savePlan.MR_inContext(localContext) as! Plan
                    
                    p.title = savePlan.title
                    
                    localContext.MR_saveToPersistentStoreAndWait()
                }
                self.delegate?.didFinishEditing(savePlan)
            }
            else {
                self.delegate?.didDeletePlan(savePlan)
            }
        }
    }
    
    
    
    
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case kSectionTitle:
            return 1
            
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String
        switch (indexPath.section, indexPath.row) {
        case (kSectionTitle, 0):
            reuseIdentifier = "TextInput"
            
        default:
            reuseIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.selectionStyle = .None
        
        switch (indexPath.section, indexPath.row) {
        case (kSectionTitle, 0):
            var cell = cell as! MPTableViewCellTextInput
            cell.textLabel?.text = NSLocalizedString("Title", comment: "")
            cell.textField.text = plan?.title
            cell.didChange = { text in
                self.plan?.title = text
                self.title = self.plan?.title
            }
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch (section) {
        case kSectionTitle:
            return NSLocalizedString("Title of the Plan", comment: "")
            
        default:
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
            
        default:
            break
        }
    }
    
    
    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        switch indexPath.section {
//        default:
//            return false
//        }
//    }
//    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            
//        }
//        else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }

    
    
    
    
    
}
