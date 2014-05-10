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
#import "MainTableFile3.h"
#import "MainTableFile4.h"

#import "Protocol.h"

@class Day;
@class MPDate;

@protocol WeekEditDetail2 <NSObject>
@optional
- (void)doneEditing:(Day *)day andIndex:(int)index;
@end

@interface WeekEditDetail2 : UIViewController <MainTableFile4Delegate, MainTableFileDelegate, MainTableFileDelegate3> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIPickerView *fromPicker;
    IBOutlet UIPickerView *toPicker;
    Day *editingDay;
    int editingIndex;
    MPDate *editingDate;
    int editingDateIndex;
    BOOL onn;
    id delegate;
}
@property (readwrite) id delegate;

- (IBAction)cancel:(id)sender;
- (void)reloadWithDay:(Day *)day andIndex:(int)day;

@end
