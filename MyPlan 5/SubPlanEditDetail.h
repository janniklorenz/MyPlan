//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "SubAddHoureViewController.h"

@class Person;
@class Week;
@class Day;
@class SubAddHoureViewController;

@interface SubPlanEditDetail : UIViewController <SubAddHoureViewControllerDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    IBOutlet UIBarButtonItem *editingButton;
    BOOL adding;
    
    int viewingIndex;
    Person *viewingPerson;
    Week *viewingWeek;
    Day *viewingDay;
    int viewingDayIndex;
    
    SubAddHoureViewController *subAddHoureViewController;
}
- (IBAction)doEditing:(id)sender;

- (void)reloadViewsWithPersonIndex:(int)index andDayIndex:(int)dindex;

@end
