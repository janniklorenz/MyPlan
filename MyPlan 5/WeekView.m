//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "WeekView.h"
#import "MainTableFile2.h"
#import "MainTableFile6.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Person.h"
#import "Week.h"
#import "SubPlanEdit.h"
#import "ViewJetzt.h"
#import "ViewTag.h"
#import "ViewWeek.h"
#import "FunktionenHausaufgabe.h"
#import "FunktionenNoten.h"
#import "FunktionenExport.h"
#import "FunktionenTermine.h"
#import "FunktionenVertretungsplan.h"
#import "FunktionenFotos.h"
#import "FunktionenNotizen.h"
#import "AppData.h"
#import "MPNotification.h"
#import "Day.h"

@interface WeekView ()

@end

@implementation WeekView

@synthesize viewTag;
@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[WeekView alloc] initWithNibName:@"WeekView_iPhone" bundle:nil];
    else self = [[WeekView alloc] initWithNibName:@"WeekView_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backItem.title = @"zurück";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(toggle:)];
    self.navigationItem.leftBarButtonItem = rightButton;
    
    // Enable Dragging
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    table.backgroundView = nil;
    table.backgroundColor = [UIColor clearColor];
    table.layer.borderWidth = 0;
    
}


- (void)viewDidAppear:(BOOL)animated {
    
    // --------- Houre Notification ---------
    int setDayInddex = [MainData dayIndex];
    for (int i = 0; i < 6; i++) {
        Day *viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:[MainData dayIndex]];
        for (int ii = 0; ii < [viewingDay.Subjects count]; ii++) {
            [MPNotification notificationForHoureIndex:ii onDay:setDayInddex andDaysFromNow:i inWeek:viewingWeek andPerson:viewingPerson andDay:viewingDay];
        }
        if (setDayInddex == 6) setDayInddex = 0;
        else setDayInddex++;
    }
    // --------------------------------------
    
    
    /*
    // -------- Termin Notification --------
    for (int i = 0; i < [viewingPerson.Termine count]; i++) {
        
    }
    // -------------------------------------
    */
    
    
    
    
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    // Set title
    self.navigationItem.title = @"Menü";
}

- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    self.navigationController.navigationBarHidden = NO;
    
    if ([[MainData LoadMain] count] > 0) {
        [self reloadViewsWithIndex:viewingIndex];
    }
    
    
    
    if ([[MainData LoadAppData] AdFree]) {
        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.5];
        [table setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        backImg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        
        NSLog(@"%f", self.view.frame.size.height);
        NSLog(@"%f", table.frame.size.height);
        
        NSLog(@"YYYAAA");
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
    self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@", viewingPerson.PersonName, viewingWeek.WeekName];
    
    
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return 1;break;
        case 1:return 8;break;// 8 (5.0.2)
        case 2:return 3;break;
        default:break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MainTableFile6 *MainTableCell = [MainData getCellType:6];
        MainTableCell.backgroundView = [MainData getViewType:6];
        MainTableCell.backgroundColor = [UIColor clearColor];
        MainTableCell.index = indexPath;
        MainTableCell.delegate = self;
        [MainTableCell setShadow];
        return MainTableCell;
    }
    else if (indexPath.section == 1) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        if (indexPath.row == 0) {
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_7.png"];
            MainTableCell.custumTextLabel1.text = @"Funktionen";
        }
        else {
            MainTableCell.backgroundColor = [UIColor clearColor];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            if (indexPath.row == 1) {
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_13.png"];
                MainTableCell.custumTextLabel1.text = @"Hausaufgaben";
            }
            else if (indexPath.row == 2) {
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_12.png"];
                MainTableCell.custumTextLabel1.text = @"Noten";
            }
            else if (indexPath.row == 3) {
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_9.png"];
                MainTableCell.custumTextLabel1.text = @"Export";
            }
            else if (indexPath.row == 4) {
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_10.png"];
                MainTableCell.custumTextLabel1.text = @"Termine";
            }
            else if (indexPath.row == 5) {
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_11.png"];
                MainTableCell.custumTextLabel1.text = @"Vertretungsplan";
            }
            else if (indexPath.row == 6) {
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_24.png"];
                MainTableCell.custumTextLabel1.text = @"Fotos";
            }
            else if (indexPath.row == 7) {
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_26.png"];
                MainTableCell.custumTextLabel1.text = @"Notizen";
            }
        }
        return MainTableCell;
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_2.png"];
            MainTableCell.custumTextLabel1.text = @"Einstellungen";
            return MainTableCell;
        }
        else if (indexPath.row == 1) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_14.png"];
            MainTableCell.custumTextLabel1.text = @"Stundenplan bearbeiten";
            return MainTableCell;
        }
        else if (indexPath.row == 2) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_15.png"];
            MainTableCell.custumTextLabel1.text = @"Generell (Zeiten, ...)";
            return MainTableCell;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tab didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 1) { // hausaufgaben
            if (funktionenHausaufgabe == nil) funktionenHausaufgabe = [[FunktionenHausaufgabe alloc] init];
            [funktionenHausaufgabe reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
            [self.navigationController pushViewController:funktionenHausaufgabe animated:YES];
        }
        else if (indexPath.row == 2) { // Noten
            if (funktionenNoten == nil) funktionenNoten = [[FunktionenNoten alloc] init];
            [funktionenNoten reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
            [self.navigationController pushViewController:funktionenNoten animated:YES];
        }
        else if (indexPath.row == 3) { // Export
            if (funktionenExport == nil) funktionenExport = [[FunktionenExport alloc] init];
            [funktionenExport reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
            [self.navigationController pushViewController:funktionenExport animated:YES];
        }
        else if (indexPath.row == 4) { // Termine
            if (funktionenTermine == nil) funktionenTermine = [[FunktionenTermine alloc] init];
            [funktionenTermine reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
            [self.navigationController pushViewController:funktionenTermine animated:YES];
        }
        else if (indexPath.row == 5) { // Vertretungsplan
            if (funktionenVertretungsplan == nil) funktionenVertretungsplan = [[FunktionenVertretungsplan alloc] init];
            [funktionenVertretungsplan reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
            [self.navigationController pushViewController:funktionenVertretungsplan animated:YES];
        }
        else if (indexPath.row == 6) { // Fotos
            if (funktionenFotos == nil) funktionenFotos = [[FunktionenFotos alloc] init];
            [funktionenFotos reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
            [self.navigationController pushViewController:funktionenFotos animated:YES];
        }
        else if (indexPath.row == 7) { // Notizen
            if (funktionenNotizen == nil) funktionenNotizen = [[FunktionenNotizen alloc] init];
            [funktionenNotizen reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
            [self.navigationController pushViewController:funktionenNotizen animated:YES];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            if (subPlanEdit == nil) subPlanEdit = [[SubPlanEdit alloc] init];
            [subPlanEdit reloadViewsWithIndex:viewingIndex];
            [self.navigationController pushViewController:subPlanEdit animated:YES];
        }
        else if (indexPath.row == 2) {
            [self.delegate didSelectWeekEditWithRow:(int)[viewingPerson.Weeks indexOfObject:viewingWeek] andPersonRow:viewingIndex];
        }
    }
    [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:return 78;break;
        case 1:
            if (indexPath.row == 0)return 44;
            else return 34;break;
        case 2:
            if (indexPath.row == 0)return 44;
            else return 34;break;;break;
        default:break;
    }
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

- (void)didSelectButton:(int)buttonIndex andIndex:(NSIndexPath *)indexPath {
    if (buttonIndex == 0) {
        if (viewJetzt == nil) viewJetzt = [[ViewJetzt alloc] init];
        [viewJetzt reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
        [self.navigationController pushViewController:viewJetzt animated:YES];
    }
    else if (buttonIndex == 1) {
        if (viewTag == nil) viewTag = [[ViewTag alloc] init];
        [viewTag reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
        [self.navigationController pushViewController:viewTag animated:YES];
    }
    else if (buttonIndex == 2) {
        if (viewWeek == nil) viewWeek = [[ViewWeek alloc] init];
        [viewWeek reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
        [self.navigationController pushViewController:viewWeek animated:YES];
    }
}






// Shows WeekMenu
- (IBAction)toggle:(id)sender {
    [self.revealViewController revealToggle:nil];
}



@end
