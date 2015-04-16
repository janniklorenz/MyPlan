//
//  AppDelegate.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SWRevealViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, SWRevealViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly) SWRevealViewController *revealViewController;

@end
