//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateDelegate <NSObject>
- (void)doneIsFirst:(BOOL)isFirstStart;
@end

@interface Update : UIViewController {
    IBOutlet UIImageView *backImg;
    IBOutlet UIWebView *webView;
    BOOL isFirst;
    id delegate;
}
@property (readwrite) BOOL isFirst;
@property (readwrite) id delegate;

- (IBAction)cancel:(id)sender;

@end
