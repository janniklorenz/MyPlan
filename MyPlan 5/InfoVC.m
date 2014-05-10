//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "InfoVC.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile16.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "AppData.h"

@interface InfoVC ()

@end

@implementation InfoVC

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[InfoVC alloc] initWithNibName:@"InfoVC_iPhone" bundle:nil];
    else self = [[InfoVC alloc] initWithNibName:@"InfoVC_iPad" bundle:nil];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    if (section == 1) return 4;
    if (section == 2) return 1;
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MainTableFile16 *MainTableCell = [MainData getCellType:16];
        MainTableCell.iv.image = [UIImage imageNamed:@"MyPlan_Large.png"];
        MainTableCell.label1.text = @"MyPlan 5";
        MainTableCell.label2.text = [NSString stringWithFormat:@"(%@)", [[MainData LoadAppData] AppVersion]];
        return MainTableCell;
    }
    else if (indexPath.section == 1) { // iCloud
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_3.png"];
            MainTableCell.custumTextLabel1.text = @"Mehr Infos:";
            return MainTableCell;
        }
        else {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            if (indexPath.row == 1) MainTableCell.custumTextLabel1.text = @"AppStore";
            else if (indexPath.row == 2) MainTableCell.custumTextLabel1.text = @"Website";
            else if (indexPath.row == 3) MainTableCell.custumTextLabel1.text = @"YouTube";
            return MainTableCell;
        }
    }
    else if (indexPath.section == 2) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:6];
        MainTableCell.selectedBackgroundView = [MainData getViewType:6];
        MainTableCell.custumTextLabel1.textColor = [UIColor whiteColor];
        MainTableCell.custumTextLabel1.text = @"© 2013 Jannik Lorenz";
        return MainTableCell;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 1) { // AppStore
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/myplan-5/id620776357?l=de&ls=1&mt=8"]];
        }
        else if (indexPath.row == 2) { // Website
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jlproduction.de/"]];
        }
        else if (indexPath.row == 3) { // YouTube
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/user/janniklorenz?feature=mhee"]];
        }
    }
    [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 120;
    if (indexPath.section == 1 && indexPath.row != 0) return 34;
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
