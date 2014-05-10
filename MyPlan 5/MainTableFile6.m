//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "MainTableFile6.h"
#import <QuartzCore/QuartzCore.h>

@implementation MainTableFile6

@synthesize textView;
@synthesize delegate;
@synthesize index;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setShadow {
    button1.layer.shadowOpacity = 1;
    button1.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7].CGColor;
    button1.layer.shadowOffset = CGSizeMake(1,-2);
    button1.layer.shadowRadius = 4;
    
    button2.layer.shadowOpacity = 1;
    button2.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7].CGColor;
    button2.layer.shadowOffset = CGSizeMake(1,-2);
    button2.layer.shadowRadius = 4;
    
    button3.layer.shadowOpacity = 1;
    button3.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7].CGColor;
    button3.layer.shadowOffset = CGSizeMake(1,-2);
    button3.layer.shadowRadius = 4;
}

- (IBAction)clickAtButton:(id)sender {
    [self.delegate didSelectButton:[sender tag] andIndex:index];
}

@end
//CODE MADE BY JANNIK LORENZ