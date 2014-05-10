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
#import "MainTableFile15.h"
#import "Protocol.h"

@class Week;
@class AppData;

@interface NotificationsSettings : UIViewController <MainTableFileDelegate, MainTableFile15Delegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    AppData *appData;
    id delegate;
}
@property (readwrite) id delegate;

- (IBAction)cancel:(id)sender;

@end
