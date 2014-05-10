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

@interface SubjectCell1 : UITableViewCell {
    IBOutlet UILabel *SubjectNameLabel;
    IBOutlet UILabel *SubjectTimeLabel;
    IBOutlet UIImageView *SubjectColorView;
}
@property (nonatomic, retain) IBOutlet UILabel *SubjectNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *SubjectTimeLabel;
@property (nonatomic, retain) IBOutlet UIImageView *SubjectColorView;

@end
//CODE MADE BY JANNIK LORENZ