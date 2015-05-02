//
//  MPDatePickerViewController.swift
//  MyPlan
//
//  Created by Jannik Lorenz on 01.05.15.
//  Copyright (c) 2015 Jannik Lorenz. All rights reserved.
//

import UIKit

protocol MPDatePickerViewControllerDelegate {
    func didPickDate(color: UIColor)
}

class MPDatePickerViewController: UITableViewController {

    var delegate: MPDatePickerViewControllerDelegate?
    
    var dateFrom: MPDate
    var dateTo: MPDate
    
    
    
    
    
    // MARK: - Init
    
    init(delegate: MPDatePickerViewControllerDelegate, dateFrom: MPDate, dateTo: MPDate) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        
        super.init(style: .Grouped)
        
        self.delegate = delegate
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.dateFrom = MPDate()
        self.dateTo = MPDate()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    
    
    
    // MARK: - View Livestyle
    
    override func viewWillDisappear(animated: Bool) {
//       self.delegate?.didPickDate()
    }
    
    
    
    

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
            
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
        case (0, 0):
            cell.textLabel?.text = "From"
        case (0, 1):
            cell.textLabel?.text = "To"
        
            
        default:
            break
        }
        
        

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch (section) {
        default:
            return "";
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
            
        default:
            break
        }
    }

    
    
}
