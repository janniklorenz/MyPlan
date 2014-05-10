//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "MainTableFile2.h"

@implementation MainTableFile2

@synthesize custumTextLabel1;
@synthesize delegate;
@synthesize indexPath;
@synthesize custumImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

// --------- Long Press -----------
- (void)longPress:(BOOL)on {
    if (on == YES) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        longPress.minimumPressDuration = 1.0;
        [self addGestureRecognizer:longPress];
    }
}
- (void)handleLongPress: (UIGestureRecognizer *)longPress {
    if (longPress.state==UIGestureRecognizerStateBegan) {
        [self.delegate longPressAtIndexPath:indexPath andSender:self];
//        [self setSelected:NO];
    }
}
// --------------------------------


@end