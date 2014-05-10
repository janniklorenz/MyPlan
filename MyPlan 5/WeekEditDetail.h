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

@class MPDate;

@protocol WeekEditDetail <NSObject>
@optional
- (void)doneEditingTimes:(NSMutableArray *)newWeekMaxHouresTimes;
@end

@interface WeekEditDetail : UIViewController <MainTableFileDelegate, MainTableFileDelegate3> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIPickerView *fromPicker;
    IBOutlet UIPickerView *toPicker;
    NSMutableArray *WeekMaxHouresTimes;
    int editingHoure;
    id delegate;
    MPDate *editingDate;
    int editingDateIndex;
}
@property (readwrite) id delegate;

- (IBAction)cancel:(id)sender;
- (void)reloadWithWeekMaxHouresTimes:(NSMutableArray *)newWeekMaxHouresTimes;

@end
