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

@interface MainTableFile12 : UITableViewCell {
    IBOutlet UILabel *textLabel;
    IBOutlet UILabel *timesLabel;
    IBOutlet UIImageView *imgImageView;
    IBOutlet UIImageView *subjectBackgroundView;
}

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *timesLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imgImageView;
@property (nonatomic, retain) IBOutlet UIImageView *subjectBackgroundView;
@property (readwrite) id delegate;

@end
