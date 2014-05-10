//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "MainTableFile.h"
#import "Protocol.h"

#import "MBProgressHUD.h"

@class Week;

@interface MyPlanPro : UIViewController <MainTableFileDelegate, UINavigationControllerDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;

    id delegate;
    MBProgressHUD *_hud;
    UIRefreshControl *refreshControl;
}
@property (readwrite) id delegate;
@property (retain) MBProgressHUD *hud;
@property (readwrite) UIRefreshControl *refreshControl;

- (IBAction)cancel:(id)sender;

@end
