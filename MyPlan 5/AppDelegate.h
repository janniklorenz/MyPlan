//
//  AppDelegate.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "WeekMenu.h"
#import "PersonEdit.h"
#import "Update.h"
#import "BackgroundSettings.h"
#import "NotificationsSettings.h"
#import "MainSettings.h"

@class WeekMenu;
@class WeekView;
@class WeekEdit;
@class MainSettings;
@class PersonEdit;
@class BackgroundSettings;
@class Update;
@class NotificationsSettings;
@class Help;
@class InfoVC;
@class MyPlanPro;

@interface AppDelegate : UIResponder <UIApplicationDelegate, SWRevealViewControllerDelegate, WeekMenuDelegate, PersonEditDelegate, UIActionSheetDelegate, UpdateDelegate, iPadViewDidDoad> {
    NSURL *oppenedURL;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *weekViewNav;
@property (strong, nonatomic) WeekMenu *weekMenu;
@property (strong, nonatomic) WeekView *weekView;
@property (strong, nonatomic) WeekEdit *weekEdit;
@property (strong, nonatomic) PersonEdit *personEdit;
@property (strong, nonatomic) MainSettings *mainSettings;
@property (strong, nonatomic) SWRevealViewController *revealSideViewController;
@property (strong, nonatomic) BackgroundSettings *backgroundSettings;
@property (strong, nonatomic) Update *update;
@property (strong, nonatomic) NotificationsSettings *notificationsSettings;
@property (strong, nonatomic) Help *help;
@property (strong, nonatomic) InfoVC *infoVC;
@property (strong, nonatomic) MyPlanPro *myPlanPro;

@property (readwrite) NSURL *ubiquitousURL;
@property (readwrite) NSMetadataQuery *metadataQuery;

@end
