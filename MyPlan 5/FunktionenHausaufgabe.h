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
@class FunktionenHausaufgabeDetail;
@class Homework;

@interface FunktionenHausaufgabe : UIViewController <MainTableFileDelegate,WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    int viewingIndex;
    Person *viewingPerson;
    Week *viewingWeek;
    
    NSMutableArray *ContendArray;
    
    FunktionenHausaufgabeDetail *funktionenHausaufgabeDetail;
}
- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek;

@end
