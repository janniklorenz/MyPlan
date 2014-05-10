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
#import "SubjectCell4.h"

@class Week;
@class WeekEditDetail;
@class WeekEditDetail2;
@class Person;
@class SubFunktionenNotenDetail;
@class FunktionenHausaufgabeDetail;
@class FunktionenTermineDetail;
@class FunktionenNotizDetail;

@interface ViewJetzt : UIViewController <MainTableFileDelegate,WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate, SubjectCell4Delegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    int viewingIndex;
    Person *viewingPerson;
    Week *viewingWeek;
    Day *viewingDay;
    int DayIndex;
    int viewingHoure;
    
    IBOutlet UISegmentedControl *DayIndexSegmentedControl;
    BOOL hideProgress;
    
    NSMutableArray *WeekDays;
    NSMutableArray *DaySubjets;
    
    SubFunktionenNotenDetail *subFunktionenNotenDetail;
    FunktionenHausaufgabeDetail *funktionenHausaufgabeDetail;
    FunktionenTermineDetail *funktionenTermineDetail;
    FunktionenNotizDetail *funktionenNotizDetail;
    
    BOOL OppendInfos;
    BOOL OppendNoten;
    BOOL OppendHausaufgaben;
    BOOL OppendTermine;
    BOOL OppendNotizen;
    
}
@property (readwrite) BOOL hideProgress;

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek;
- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek andDay:(int)newDay andHoure:(int)newHoure;


- (IBAction)changeSegmentedControl:(id)sender;

@end
