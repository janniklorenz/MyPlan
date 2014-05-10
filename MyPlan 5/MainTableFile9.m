//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "MainTableFile9.h"

@implementation MainTableFile9

@synthesize Label1;
@synthesize segControl;
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

- (IBAction)changeSegControl:(id)sender {
    [self.delegate changeSegmentedControlTo:(int)segControl.selectedSegmentIndex];
}

@end
//CODE MADE BY JANNIK LORENZ