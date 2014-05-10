//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "MainTableFile11.h"
#import "MainData.h"

@implementation MainTableFile11

@synthesize Label1;
@synthesize stepper;
@synthesize indexPath;
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

- (void)setToDate:(NSDate *)newDate {
    setDate = newDate;
    
    float x = ([setDate timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970]) / (60*60*24);
    stepper.value = [MainData runden:x stellen:0];
    
    NSDateFormatter *UhrH = [[NSDateFormatter alloc] init];
    [UhrH setDateFormat:@"EEEE, dd.MM.yyyy"];
    Label1.text = [NSString stringWithFormat:@"%@", [UhrH stringFromDate:setDate]];
}

- (IBAction)valueChanged:(id)sender {
    [self.delegate valueChangedToDate:[NSDate dateWithTimeIntervalSinceNow:stepper.value*60*60*24] atIndex:indexPath];
}


@end
//CODE MADE BY JANNIK LORENZ