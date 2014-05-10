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
#import "MainTableFile11.h"

#import "Protocol.h"

@class Week;
@class WeekEditDetail;
@class WeekEditDetail2;
@class Person;
@class Homework;
@class SubAddHoureViewController;
@class MPPictureView;

@interface FunktionenHausaufgabeDetail : UIViewController <MainTableFileDelegate, MainTableFileDelegate13, WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate, MainTableFile11Delegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    
    int viewingIndex;
    Person *viewingPerson;
    int viewingHomeworkIndex;
    Homework *viewingHomework;
    
    BOOL isNew;
    
    SubAddHoureViewController *subAddHoureViewController;
    MPPictureView *pictureView;
    
    id delegate;
}
@property (readwrite) id delegate;

- (void)reloadWithNewHomeworkWithSubjectID:(NSString *)newSubjectID ViewingIndex:(int)vindex andPerson:(Person *)vperson;
- (void)reloadWithNewHomeworkViewingIndex:(int)vindex andPerson:(Person *)vperson;
- (void)reloadWithHomeworkAtIndex:(int)homeworkIndex ViewingIndex:(int)vindex andPerson:(Person *)vperson;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
