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

@protocol MainTableFileDelegate13 <NSObject>
@optional
- (void)typeText:(NSString *)text index:(NSIndexPath *)index;
- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string;
- (void)keyboardVisible:(BOOL)visible;
- (void)startTypingAtIndexPath:(NSIndexPath *)indexp;
@end

@interface MainTableFile13 : UITableViewCell {
    IBOutlet UITextField *textField;
    NSIndexPath *indexPath;
    id delegate;
    IBOutlet UIButton *b1;
    IBOutlet UIButton *b2;
    IBOutlet UIButton *b3;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (readwrite) id delegate;

- (IBAction)type:(id)sender;
- (IBAction)didEndOnExit:(id)sender;
- (IBAction)getKeyboard:(id)sender;
- (void)hideControls:(BOOL)hide;
- (IBAction)startEdit:(id)sender;

- (IBAction)del:(id)sender;
@end
//CODE MADE BY JANNIK LORENZ