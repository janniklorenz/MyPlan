//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "MainTableFile8.h"

@implementation MainTableFile8

@synthesize NameLabel;
@synthesize InfoLabel;
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

- (IBAction)tName:(id)sender {
    [self.delegate typeName:NameLabel.text index:indexPath];
}
- (IBAction)tInfo:(id)sender {
    [self.delegate typeInfo:InfoLabel.text index:indexPath];
}
- (IBAction)dStartName:(id)sender {
    [self.delegate didStartNameAtIndex:indexPath];
}
- (IBAction)dStartInfo:(id)sender {
    [self.delegate didStartInfoAtIndex:indexPath];
}
- (IBAction)dEndName:(id)sender {
    [self.delegate didEndNameAtIndex:indexPath withText:NameLabel.text];
}
- (IBAction)dEndInfo:(id)sender {
    [self.delegate didEndInfoAtIndex:indexPath withText:InfoLabel.text];
}


@end
//CODE MADE BY JANNIK LORENZ