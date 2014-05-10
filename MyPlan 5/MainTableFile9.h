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

@protocol MainTableFile9Delegate <NSObject>
@optional
- (void)changeSegmentedControlTo:(int)index;
@end

@interface MainTableFile9 : UITableViewCell {
    IBOutlet UILabel *Label1;
    IBOutlet UISegmentedControl *segControl;
    NSIndexPath *indexPath;
    id delegate;
}
@property (nonatomic, retain) IBOutlet UILabel *Label1;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segControl;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) id delegate;

- (IBAction)changeSegControl:(id)sender;

@end
//CODE MADE BY JANNIK LORENZ