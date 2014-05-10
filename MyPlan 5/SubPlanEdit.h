//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@class Person;
@class Week;
@class SubPlanEditDetail;

@interface SubPlanEdit : UIViewController {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    int viewingIndex;
    Person *viewingPerson;
    Week *viewingWeek;
    
    SubPlanEditDetail *subPlanEditDetail;
}

- (void)reloadViewsWithIndex:(int)index;

@end
