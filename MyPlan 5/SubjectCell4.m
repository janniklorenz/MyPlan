//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "SubjectCell4.h"
#import "Subject.h"
#import "MainData.h"
#import <QuartzCore/QuartzCore.h>

@implementation SubjectCell4

@synthesize scrollView;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUpScrollViewForSubjects:(NSMutableArray *)array andCurrend:(int)curr andFrame:(CGRect)newFrame {
    usedSubjects = array;
    currendHoure = curr;
    setFrame = newFrame;
    
    for (int i = 0; i < [array count]; i++) {
        UIView *sub1 = [[UIView alloc] initWithFrame:CGRectMake(i*(newFrame.size.width), 0, newFrame.size.width, newFrame.size.height)];
        sub1.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
        UILabel *subjectnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, newFrame.size.width, newFrame.size.height)];
        subjectnameLabel.textAlignment = NSTextAlignmentCenter;
        subjectnameLabel.text = [NSString stringWithFormat:@"%i. %@",i+1, [[array objectAtIndex:i] SubjectNameAndShort]];
        subjectnameLabel.textColor = [MainData getTextColorForBackgroundColor:[[array objectAtIndex:i] SubjectColor]];
        subjectnameLabel.backgroundColor = [[array objectAtIndex:i] SubjectColor];
        [sub1 addSubview:subjectnameLabel];
        
        if ([[array objectAtIndex:i] isVertretung]) {
            UIImageView *vertretungIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20*newFrame.size.height/44, newFrame.size.height)];
            vertretungIV.image = [MainData getVertretungImgForBackgroundColor:[[array objectAtIndex:i] SubjectColor]];
            [sub1 addSubview:vertretungIV];
        }
        
        [scrollView addSubview:sub1];
    }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    self.layer.shadowOpacity = 1;
    self.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7].CGColor;
    self.layer.shadowOffset = CGSizeMake(1,-1);
    self.layer.shadowRadius = 4;
    
	scrollView.contentSize = CGSizeMake(newFrame.size.width*[array count], newFrame.size.height);
	[scrollView setContentOffset:CGPointMake(newFrame.size.width*curr, 0) animated:NO];
    NSLog(@"%f %i %f", newFrame.size.width*[array count], curr, newFrame.size.width*curr);
}

- (void)orientationChanged:(NSNotification *)notification {
//    [self setUpScrollViewForSubjects:usedSubjects andCurrend:currendHoure andFrame:setFrame];
}

- (void)scrollViewDidScroll:(UIScrollView *)sView {
//    NSLog(@"a%f", scrollView.contentOffset.x);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollVie {
    int x = scrollView.contentOffset.x/setFrame.size.width;
    if (currendHoure != x) {
        currendHoure = x;
        CGPoint oldPoint = scrollView.contentOffset;
        [self.delegate changeSubjectTo:currendHoure];
        [scrollView setContentOffset:oldPoint animated:NO];
    }
}

@end
