//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Help.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"

@interface Help ()

@end

@implementation Help

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[Help alloc] initWithNibName:@"Help_iPhone" bundle:nil];
    else self = [[Help alloc] initWithNibName:@"Help_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // Name
        MainTableFile *MainTableCell = [MainData getCellType:1];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
        MainTableCell.textField.placeholder = @"Name:";
        MainTableCell.textField.text = @"";
        return MainTableCell;
    }
    else if (indexPath.section == 2) { // iCloud
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
        MainTableCell.custumTextLabel1.text = @"iCloud:";
        return MainTableCell;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0) return 30;
    else if (indexPath.section == 3 && indexPath.row != 0) return 30;
    else if (indexPath.section == 4 && indexPath.row != 0) return 30;
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
