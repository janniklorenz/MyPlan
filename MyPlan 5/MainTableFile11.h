//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import <UIKit/UIKit.h>

@protocol MainTableFile11Delegate <NSObject>
@optional
- (void)valueChangedToDate:(NSDate *)dateChange atIndex:(NSIndexPath *)index;
@end

@interface MainTableFile11 : UITableViewCell {
    IBOutlet UILabel *Label1;
    IBOutlet UIStepper *stepper;
    NSIndexPath *indexPath;
    NSDate *setDate;
    id delegate;
}
@property (nonatomic, retain) IBOutlet UILabel *Label1;
@property (nonatomic, retain) IBOutlet UIStepper *stepper;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) id delegate;

- (void)setToDate:(NSDate *)newDate;
- (IBAction)valueChanged:(id)sender;

@end
//CODE MADE BY JANNIK LORENZ