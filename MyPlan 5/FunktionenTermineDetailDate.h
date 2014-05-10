//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;
@class Termin;
@class SubAddHoureViewController;
@class MPPictureView;
@class Week;

@protocol FunktionenTermineDetailDate <NSObject>
- (void)doneWithDate:(NSDate *)newDate;
@end

@interface FunktionenTermineDetailDate : UIViewController {
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIImageView *backImg;
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *timeLabel;
    
    id delegate;
}
@property (readwrite) id delegate;

- (void)reloadWithDate:(NSDate *)newDate;

- (IBAction)changeDate:(id)sender;
- (IBAction)done:(id)sender;

@end
