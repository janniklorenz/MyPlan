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
#import "MainTableFile13.h"
#import "WeekEditDetail.h"
#import "WeekEditDetail2.h"
#import "MainTableFile15.h"
#import "FunktionenTermineDetailDate.h"

#import "Protocol.h"

@class Person;
@class Termin;
@class SubAddHoureViewController;
@class MPPictureView;
@class Week;
@class FunktionenTermineDetailDate;

@interface FunktionenTermineDetail : UIViewController <MainTableFileDelegate, MainTableFileDelegate13, WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate, MainTableFile15Delegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FunktionenTermineDetailDate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    
    int viewingIndex;
    Person *viewingPerson;
    int viewingTerminIndex;
    Termin *viewingTermin;
    Week *viewingWeek;
    
    BOOL isNew;
    
    SubAddHoureViewController *subAddHoureViewController;
    MPPictureView *pictureView;
    
    FunktionenTermineDetailDate *funktionenTermineDetailDate;
    
    id delegate;
}
@property (readwrite) id delegate;

- (void)reloadWithNewTerminOnDate:(NSDate *)newDate withSubjectID:(NSString *)newSubjectID ViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek;
- (void)reloadWithNewTerminOnDate:(NSDate *)newDate ViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek;
- (void)reloadWithTerminAtIndex:(int)terminIndex ViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
