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
#import "SubVertretung.h"

@class Week;
@class WeekEditDetail;
@class WeekEditDetail2;
@class Person;
@class SubVertretung;
@class Vertretung;

@interface FunktionenVertretungsplan : UIViewController <MainTableFileDelegate,WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate, SubVertretungDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    int viewingIndex;
    Person *viewingPerson;
    Week *viewingWeek;
    
    NSMutableArray *VertretungenOrderd;
    
    SubVertretung *subVertretung;
    UINavigationController *subVertretungNavController;
}

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek;

@end
