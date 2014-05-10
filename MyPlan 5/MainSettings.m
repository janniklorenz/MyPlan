//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "MainSettings.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "SubjectCell5.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "AppData.h"

@interface MainSettings ()

@end

@implementation MainSettings

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[MainSettings alloc] initWithNibName:@"MainSettings_iPhone" bundle:nil];
    else self = [[MainSettings alloc] initWithNibName:@"MainSettings_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    appData = [MainData LoadAppData];
    
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            if (appData.StartAnsichtOn)return 2;
            else return 1;break;
        default:break;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // Name
        if (indexPath.row == 0) {
            MainTableFile4 *MainTableCell = [MainData getCellType:4];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.tableSwitch.on = appData.StartAnsichtOn;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            MainTableCell.textLabel.text = @"Start Ansicht";
            return MainTableCell;
        }
        else if (indexPath.row == 1) {
            SubjectCell5 *MainTableCell = [MainData getCellType:105];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            MainTableCell.segControl.selectedSegmentIndex = appData.StartAnsichtIndex;
            return MainTableCell;
        }
        
    }
    
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)changesSwitchTo:(BOOL)switchValue inIndexPath:(NSIndexPath *)ipath {
    if (ipath.section == 0 && ipath.row == 0) {
        appData.StartAnsichtOn = switchValue;
        [MainData SaveAppData:appData];
    }
    [table reloadSections:[NSIndexSet indexSetWithIndex:ipath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)changeSelectionTo:(int)index {
    appData.StartAnsichtIndex = index;
    [MainData SaveAppData:appData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0) return 34;
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


- (void)typeText:(NSString *)text index:(NSIndexPath *)index {
    
}
- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    
}
- (void)keyboardVisible:(BOOL)visible {
    
}
- (void)startTypingAtIndexPath:(NSIndexPath *)indexp {
    
}





// Cancel Edit
- (IBAction)cancel:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
