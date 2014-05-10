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

@protocol MainTableFile17Delegate <NSObject, UITextViewDelegate>
@optional
- (void)didType:(NSString *)string;
- (void)endType;
@end

@interface MainTableFile17 : UITableViewCell {
    IBOutlet UITextView *customTextView;
    id delegate;
}
@property (nonatomic, retain) IBOutlet UITextView *customTextView;
@property (readwrite) id delegate;


@end
//CODE MADE BY JANNIK LORENZ