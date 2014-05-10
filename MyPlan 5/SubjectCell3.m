//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "SubjectCell3.h"
#import "MPDate.h"
#import "MainData.h"

@implementation SubjectCell3

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
    
    FromLabel.text = [usedDate from];
    
    if (usedDate.isClear) MiddleLabel.text = @"";
    else if (usedDate.toSec < [MainData daySeconds]) {
        float rest = [MainData daySeconds] - usedDate.toSec;
        refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(doTimer:) userInfo:nil repeats:NO];
        MiddleLabel.text = [NSString stringWithFormat:@"vor %@", [MPDate getMinSecFormated:rest]];
    }
    else if (usedDate.toSec > [MainData daySeconds] && usedDate.fromSec < [MainData daySeconds]) {
        float rest = usedDate.toSec - [MainData daySeconds];
        refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(doTimer:) userInfo:nil repeats:NO];
        MiddleLabel.text = [NSString stringWithFormat:@"noch %@", [MPDate getMinSecFormated:rest]];
    }
    else if (usedDate.fromSec > [MainData daySeconds]) {
        float rest = usedDate.fromSec - [MainData daySeconds];
        refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(doTimer:) userInfo:nil repeats:NO];
        MiddleLabel.text = [NSString stringWithFormat:@"in %@", [MPDate getMinSecFormated:rest]];
    }
    
    ToLabel.text = [usedDate to];
}



- (void)setMPDateWithDuration:(MPDate *)usedDate {
    usingDate = usedDate;
    
    FromLabel.text = [usedDate from];
    
    if (usedDate.isClear) MiddleLabel.text = @"";
    else {
        float rest = usedDate.toSec-usedDate.fromSec-1;
        MiddleLabel.text = [MPDate getMinSecFormated:rest];
    }
   
    
    ToLabel.text = [usedDate to];
}


- (void)doTimer:(NSTimer *)timer {
    [self setMPDate:usingDate];
}


@end
