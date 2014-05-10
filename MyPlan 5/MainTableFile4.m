//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "MainTableFile4.h"

@implementation MainTableFile4

@synthesize textLabel;
@synthesize tableSwitch;
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

- (IBAction)changeSwitch:(id)sender {
    [self.delegate changesSwitchTo:tableSwitch.on inIndexPath:indexPath];
}

@end
//CODE MADE BY JANNIK LORENZ