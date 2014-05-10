//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "SubjectCell2.h"
#import "MPDate.h"
#import "MainData.h"

@implementation SubjectCell2

@synthesize progressView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setMPDate:(MPDate *)usedDate {
    usingDate = usedDate;
    
    if (usedDate.isClear) progressView.progress = 0;
    else if (usedDate.toSec < [MainData daySeconds]) progressView.progress = 1;
    else if (usedDate.toSec > [MainData daySeconds] && usedDate.fromSec < [MainData daySeconds]) {
        
        float rest = usedDate.toSec - [MainData daySeconds];
        float dauer = usedDate.toSec - usedDate.fromSec;
        float um = (dauer-rest)/dauer;
        
        progressView.progress = um;
        
        refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(doTimer:) userInfo:nil repeats:NO];
    }
    else if (usedDate.fromSec > [MainData daySeconds]) progressView.progress = 0;
}

- (void)doTimer:(NSTimer *)timer {
    [self setMPDate:usingDate];
}

@end
//CODE MADE BY JANNIK LORENZ