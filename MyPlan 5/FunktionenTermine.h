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
#import "TKCalendarMonthView.h"

@class Week;
@class WeekEditDetail;
@class WeekEditDetail2;
@class FunktionenTermineDetail;
@class Person;

@interface FunktionenTermine : UIViewController <MainTableFileDelegate,WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate, TKCalendarMonthViewDelegate, TKCalendarMonthViewDataSource> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    int viewingIndex;
    Person *viewingPerson;
    Week *viewingWeek;
    
    FunktionenTermineDetail *funktionenTermineDetail;
    
    TKCalendarMonthView *calendar;
    IBOutlet UIView *calendarView;
    IBOutlet UIView *ipadCalendarFrame;
    IBOutlet UINavigationBar *toolbar;
    IBOutlet UIBarButtonItem *changeShowItem;
    BOOL calendarShown;
    
    NSMutableArray *ContendArray;
}

- (IBAction)changeShown:(id)sender;

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek;

@end
