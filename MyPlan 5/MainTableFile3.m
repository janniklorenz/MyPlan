//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "MainTableFile3.h"

@implementation MainTableFile3

@synthesize textLabel;
@synthesize textField;
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

- (IBAction)type:(id)sender {
    [self.delegate typeText:textField.text index:indexPath];
}

- (IBAction)didEndOnExit:(id)sender {
    [textField resignFirstResponder];
    [self.delegate keyboardVisible:NO];
    [self.delegate doneTypingAtIndex:indexPath withText:textField.text];
}

- (void)hideControls:(BOOL)hide {
    b1.hidden = hide;
    b2.hidden = hide;
    b3.hidden = hide;
}


- (IBAction)getKeyboard:(id)sender {
    [textField becomeFirstResponder];
    [self.delegate keyboardVisible:YES];
}


- (IBAction)startEdit:(id)sender {
    [self.delegate startTypingAtIndexPath:indexPath];
}

- (IBAction)del:(id)sender {
    textField.text = @"";
    [self.delegate typeText:textField.text index:indexPath];
}

@end
//CODE MADE BY JANNIK LORENZ