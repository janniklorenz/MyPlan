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

@protocol MainTableFile4Delegate <NSObject>
@optional
- (void)changesSwitchTo:(BOOL)switchValue inIndexPath:(NSIndexPath *)ipath;
@end

@interface MainTableFile4 : UITableViewCell {
    IBOutlet UILabel *textLabel;
    IBOutlet UISwitch *tableSwitch;
    NSIndexPath *indexPath;
    id delegate;
}

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UISwitch *tableSwitch;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (readwrite) id delegate;

- (IBAction)changeSwitch:(id)sender;

@end
//CODE MADE BY JANNIK LORENZ