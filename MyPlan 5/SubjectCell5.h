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

@protocol SubjectCell5Delegate <NSObject>
- (void)changeSelectionTo:(int)index;
@end

@interface SubjectCell5 : UITableViewCell <UIScrollViewDelegate> {
    IBOutlet UISegmentedControl *segControl;
    NSIndexPath *indexPath;
    id delegate;
}
@property (nonatomic, retain) IBOutlet UISegmentedControl *segControl;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) id delegate;

- (IBAction)changeSel:(id)sender;

@end
//CODE MADE BY JANNIK LORENZ