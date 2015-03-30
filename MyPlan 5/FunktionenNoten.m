//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenNoten.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import "SubjectCell1.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Week.h"
#import "Subject.h"
#import "MPDate.h"
#import "WeekEditDetail.h"
#import "WeekEditDetail2.h"
#import "Day.h"
#import "Person.h"
#import "SubFunktionenNoten.h"

@interface FunktionenNoten ()

@end

@implementation FunktionenNoten

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenNoten alloc] initWithNibName:@"FunktionenNoten_iPhone" bundle:nil];
    else self = [[FunktionenNoten alloc] initWithNibName:@"FunktionenNoten_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    self.title = @"Noten";
    
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [table addGestureRecognizer:swipe];
}

- (void)swipeBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    
    [table reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    [table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return [viewingPerson.Subjects count]+1;break;
        case 1:return 3;break;
        default:
            break;
    };
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_16.png"];
            MainTableCell.custumTextLabel1.text = @"Fächer";
            return MainTableCell;
        }
        else {
            SubjectCell1 *MainTableCell = [MainData getCellType:101];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.SubjectNameLabel.text = [[viewingPerson.Subjects objectAtIndex:indexPath.row-1] SubjectName];
            MainTableCell.SubjectTimeLabel.text = [[viewingPerson.Subjects objectAtIndex:indexPath.row-1] getCompleteNote];
            return MainTableCell;
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_16.png"];
            MainTableCell.custumTextLabel1.text = @"Gesamt";
            return MainTableCell;
        }
        else if (indexPath.row == 1) {
            SubjectCell1 *MainTableCell = [MainData getCellType:101];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.SubjectNameLabel.text = @"Hauptfächer:";
            MainTableCell.SubjectTimeLabel.text = [viewingPerson getHauptFaecherNoten];
            return MainTableCell;
        }
        else if (indexPath.row == 2) {
            SubjectCell1 *MainTableCell = [MainData getCellType:101];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.SubjectNameLabel.text = @"Gesamt:";
            MainTableCell.SubjectTimeLabel.text = [viewingPerson getMainNoten];
            return MainTableCell;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (subFunktionenNoten == nil) subFunktionenNoten = [[SubFunktionenNoten alloc] init];
    [subFunktionenNoten reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andSubjectIndex:(int)indexPath.row-1];
    [self.navigationController pushViewController:subFunktionenNoten animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0) return 34;
    else if (indexPath.section == 1 && indexPath.row != 0) return 34;
    return 50;
}



@end
