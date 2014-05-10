//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import <UIKit/UIKit.h>

@protocol MainTableFile6Delegate <NSObject>
- (void)didSelectButton:(int)buttonIndex andIndex:(NSIndexPath *)indexPath;
@end


@interface MainTableFile6 : UITableViewCell {
    IBOutlet UITextView *textView;
    id delegate;
    NSIndexPath *index;
    
    IBOutlet UIButton *button1;
    IBOutlet UIButton *button2;
    IBOutlet UIButton *button3;
}
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (readwrite) id delegate;
@property (readwrite) NSIndexPath *index;

- (IBAction)clickAtButton:(id)sender;

- (void)setShadow;

@end
//CODE MADE BY JANNIK LORENZ