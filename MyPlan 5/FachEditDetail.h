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
#import "MainTableFile8.h"

@class Subject;

@interface FachEditDetail : UIViewController <MainTableFile8Delegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    int editingDayIndex;
    Subject *editingSubject;
    NSMutableArray *WeekDays;
}
- (void)reloadViewsWithSubject:(Subject *)eSubject andDayIndex:(int)dindex;

@end
