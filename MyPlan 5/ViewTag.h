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
@class Person;
@class Day;
@class ViewJetzt;

@interface ViewTag : UIViewController <MainTableFileDelegate,WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    NSMutableArray *WeekDays;
    
    int DayIndex;
    IBOutlet UISegmentedControl *DayIndexSegmentedControl;
    
    int viewingIndex;
    Person *viewingPerson;
    Week *viewingWeek;
    Day *viewingDay;
    
    BOOL showInfos;
    
    NSMutableArray *TodayArray;
    
    NSTimer *refreshTimer;
    
    ViewJetzt *viewJetzt;
}
- (IBAction)ChangDayIndex:(id)sender;

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek;


@end
