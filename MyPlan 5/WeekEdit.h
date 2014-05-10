//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "MainTableFile.h"
#import "WeekEditDetail.h"
#import "WeekEditDetail2.h"

@class Week;
@class WeekEditDetail;
@class WeekEditDetail2;

@interface WeekEdit : UIViewController <MainTableFileDelegate,WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    Week *editingWeek;
    BOOL newWeek;
    int editingWeekIndex;
    int editingPersonIndex;
    WeekEditDetail *weekEditDetail;
    WeekEditDetail2 *weekEditDetail2;
}

- (void)prepareForNewWeek;
- (void)prepareForWeekEditWithWeekIndex:(int)index andPersonIndex:(int)personin;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
