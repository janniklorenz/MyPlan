//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "NotificationsSettings.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "AppData.h"
#import "MPNotification.h"

@interface NotificationsSettings ()

@end

@implementation NotificationsSettings

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[NotificationsSettings alloc] initWithNibName:@"NotificationsSettings_iPhone" bundle:nil];
    else self = [[NotificationsSettings alloc] initWithNibName:@"NotificationsSettings_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    appData = [MainData LoadAppData];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            if (appData.HouresOn) return 2;
            else return 1;break;
        case 1:
            if (appData.TermineOn) return 1;
            else return 1;;break;
        default:break;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MainTableFile4 *MainTableCell = [MainData getCellType:4];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.tableSwitch.on = appData.HouresOn;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            MainTableCell.textLabel.text = @"Stundenwechsel";
            return MainTableCell;
        }
        else if (indexPath.row == 1) {
            MainTableFile15 *MainTableCell = [MainData getCellType:15];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.stepper.minimumValue = 0;
            MainTableCell.stepper.maximumValue = 100;
            if (appData.MinutesBevor == 1) MainTableCell.Label1.text = [NSString stringWithFormat:@"1 Minute vor Beginn"];
            else MainTableCell.Label1.text = [NSString stringWithFormat:@"%i Minuten vor Beginn", appData.MinutesBevor];
            MainTableCell.stepper.value = appData.MinutesBevor;
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            return MainTableCell;
        }
        
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MainTableFile4 *MainTableCell = [MainData getCellType:4];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.tableSwitch.on = appData.TermineOn;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            MainTableCell.textLabel.text = @"Termine";
            return MainTableCell;
        }
        
    }
    
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.section == 2) return 54;
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}


- (void)changesSwitchTo:(BOOL)switchValue inIndexPath:(NSIndexPath *)ipath {
    if (ipath.section == 0 && ipath.row == 0) appData.HouresOn = switchValue;
    else if (ipath.section == 1 && ipath.row == 0) appData.TermineOn = switchValue;
    [MainData SaveAppData:appData];
    [table reloadSections:[NSIndexSet indexSetWithIndex:ipath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)valueChangedTo:(int)neValue atIndex:(NSIndexPath *)index {
    if (index.section == 0 && index.row == 1) appData.MinutesBevor = neValue;
    
//    appData.Notifications = [NSMutableArray arrayWithObjects:nil];
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [MainData SaveAppData:appData];
    
    [MPNotification deleteAllNotifications];
    
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}



// Cancel Edit
- (IBAction)cancel:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
