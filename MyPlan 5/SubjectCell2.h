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

@interface SubjectCell2 : UITableViewCell {
    IBOutlet UIProgressView *progressView;
    
    NSTimer *refreshTimer;
    MPDate *usingDate;
}
@property (nonatomic, retain) IBOutlet UIProgressView *progressView;

- (void)setMPDate:(MPDate *)usedDate;

@end
//CODE MADE BY JANNIK LORENZ