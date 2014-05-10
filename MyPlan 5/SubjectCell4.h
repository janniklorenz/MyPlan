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

@protocol SubjectCell4Delegate <NSObject>
- (void)changeSubjectTo:(int)index;
@end

@interface SubjectCell4 : UITableViewCell <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    NSMutableArray *usedSubjects;
    int currendHoure;
    id delegate;
    CGRect setFrame;
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) id delegate;

- (void)setUpScrollViewForSubjects:(NSMutableArray *)array andCurrend:(int)curr andFrame:(CGRect)newFrame;

@end
//CODE MADE BY JANNIK LORENZ