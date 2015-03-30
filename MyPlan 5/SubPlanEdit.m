//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "SubPlanEdit.h"
#import "MainTableFile2.h"
#import "MainTableFile7.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Person.h"
#import "Week.h"
#import "Day.h"
#import "SubPlanEditDetail.h"

@interface SubPlanEdit ()

@end

@implementation SubPlanEdit

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[SubPlanEdit alloc] initWithNibName:@"SubPlanEdit_iPhone" bundle:nil];
    else self = [[SubPlanEdit alloc] initWithNibName:@"SubPlanEdit_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [table addGestureRecognizer:swipe];
}

- (void)swipeBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    
    if ([[MainData LoadMain] count] > 0) {
        [self reloadViewsWithIndex:viewingIndex];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)reloadViewsWithIndex:(int)index {
    viewingIndex = index;
    viewingPerson = [[MainData LoadMain] objectAtIndex:index];
    for (int i = 0; i < [viewingPerson.Weeks count]; i++) {
        if ([[[viewingPerson.Weeks objectAtIndex:i] WeekID] isEqualToString:viewingPerson.selectedWeekID]) {
            viewingWeek = [viewingPerson.Weeks objectAtIndex:i];
        }
    }
    self.title = viewingWeek.WeekName;
    [table reloadData];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [viewingWeek.WeekDurationNames count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_14.png"];
        MainTableCell.custumTextLabel1.text = viewingWeek.WeekName;
        return MainTableCell;
    }
    else {
        MainTableFile7 *MainTableCell = [MainData getCellType:7];
        MainTableCell.backgroundView = [MainData getViewType:4];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.DayLabel.text = [[viewingWeek.WeekDurationNames objectAtIndex:indexPath.row-1] DayName];
        MainTableCell.HouresLabel.text = [NSString stringWithFormat:@"Stunden: %lu", (unsigned long)[[[viewingWeek.WeekDurationNames objectAtIndex:indexPath.row-1] Subjects] count]];
        return MainTableCell;
    }
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row != 0) {
            if (subPlanEditDetail == nil) subPlanEditDetail = [[SubPlanEditDetail alloc] init];
            [subPlanEditDetail reloadViewsWithPersonIndex:viewingIndex andDayIndex:(int)indexPath.row-1];
            [self.navigationController pushViewController:subPlanEditDetail animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) return 34;
    return 44;
}

- (void)didSelectButton:(int)buttonIndex andIndex:(NSIndexPath *)indexPath {
    
}




@end
