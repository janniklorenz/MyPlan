//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import "MainTableFile17.h"
#import "MainData.h"

@implementation MainTableFile17

@synthesize customTextView;
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

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.delegate endType];
}



-(void)textViewDidChange:(UITextView *)textView {
    [self.delegate didType:customTextView.text];
}

@end
//CODE MADE BY JANNIK LORENZ