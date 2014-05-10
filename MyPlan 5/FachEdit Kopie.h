//
//  SubAddHoureViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 06.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;

@interface SubAddHoureViewController : UIViewController {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    
    Person *viewingPerson;
}

- (void)reloadWithPerson:(Person *)newPerson;
- (IBAction)cancel:(id)sender;

@end
