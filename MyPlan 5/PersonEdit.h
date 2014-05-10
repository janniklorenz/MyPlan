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
#import "FachEdit.h"

@class Person;
@class WeekEditDetail;
@class WeekEditDetail2;
@class FachEdit;

@protocol PersonEditDelegate <NSObject>
- (void)didDeletePersonAtIndex:(int)delIndex;
@end

@interface PersonEdit : UIViewController <MainTableFileDelegate,WeekEditDetail, WeekEditDetail2, UIActionSheetDelegate, FachEditDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    Person *editingPerson;
    BOOL newPerson;
    int editingPersonIndex;
    FachEdit *fachEdit;
    
    id delegate;
}
@property (readwrite) id delegate;

- (void)prepareForNewPerson;
- (void)prepareForPersonEditWithWeekIndex:(int)index;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
