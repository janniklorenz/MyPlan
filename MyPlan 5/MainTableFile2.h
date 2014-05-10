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

@protocol MaintableFileDelegate <NSObject>
- (void)longPressAtIndexPath:(NSIndexPath *)ipath andSender:(id)sender;
@end

@interface MainTableFile2 : UITableViewCell {
    IBOutlet UILabel *custumTextLabel1;
    IBOutlet UIImageView *custumImageView;
    NSIndexPath *indexPath;
    id delegate;
}
@property (readwrite) id delegate;
@property (nonatomic, retain) IBOutlet UILabel *custumTextLabel1;
@property (readwrite) IBOutlet UIImageView *custumImageView;
@property (readwrite) NSIndexPath *indexPath;

- (void)longPress:(BOOL)on;

@end
//CODE MADE BY JANNIK LORENZ