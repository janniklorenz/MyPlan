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
#import "MainTableFile3.h"

#import "Protocol.h"

@class Week;
@class WeekEditDetail;
@class WeekEditDetail2;
@class Person;
@class Subject;
@class Note;
@class MPPictureView;

@interface SubFunktionenNotenDetail : UIViewController <MainTableFileDelegate3, WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    
    int viewingIndex;
    Person *viewingPerson;
    Week *viewingWeek;
    int viewungSubjectIndex;
    Subject *viewingSubject;
    int viewingNotenIndex;
    Note *viewingNote;
    
    NSMutableArray *PossibleNotes;
    
    BOOL isNew;
    
    MPPictureView *pictureView;
    
    id delegate;
}
@property (readwrite) id delegate;

- (void)reloadNewWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek andSubjectIndex:(int)vSubjectIndex;
- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek andSubjectIndex:(int)vSubjectIndex andNotenIndex:(int)vNotenIndex;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
    

@end
