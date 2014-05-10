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

@class MPDate;

@interface SubjectCell3 : UITableViewCell {
    IBOutlet UILabel *FromLabel;
    IBOutlet UILabel *MiddleLabel;
    IBOutlet UILabel *ToLabel;
    
    NSTimer *refreshTimer;
    MPDate *usingDate;
}
- (void)setMPDate:(MPDate *)usedDate;
- (void)setMPDateWithDuration:(MPDate *)usedDate;

@end
//CODE MADE BY JANNIK LORENZ