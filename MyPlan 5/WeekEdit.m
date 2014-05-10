//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "WeekEdit.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Week.h"
#import "Subject.h"
#import "MPDate.h"
#import "WeekEditDetail.h"
#import "WeekEditDetail2.h"
#import "Day.h"
#import "Person.h"

@interface WeekEdit ()

@end

@implementation WeekEdit

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[WeekEdit alloc] initWithNibName:@"WeekEdit_iPhone" bundle:nil];
    else self = [[WeekEdit alloc] initWithNibName:@"WeekEdit_iPad" bundle:nil];
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


// ------------- Prepare ------------
- (void)prepareForNewWeek {
    navBar.topItem.title = @"Woche erstellen";
    editingWeek = [Week newWeekWithName:@"Neue Woche"];
    newWeek = YES;
    [table reloadData];
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
- (void)prepareForWeekEditWithWeekIndex:(int)index andPersonIndex:(int)personin {
    NSMutableArray *Weeks = [MainData LoadMain];
    editingWeek = [[[Weeks objectAtIndex:personin] Weeks] objectAtIndex:index];
    editingWeekIndex = index;
    editingPersonIndex = personin;
    newWeek = NO;
    navBar.topItem.title = editingWeek.WeekName;
    [table reloadData];
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
// ----------------------------------




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (newWeek) return 2;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return 2;break; // Name
        case 1:return [editingWeek.WeekDurationNames count]+1;break; // Zeiten
        case 2:return 1;break; // Fertig
        default:break;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // Name
        if (indexPath.row == 0) {
            MainTableFile *MainTableCell = [MainData getCellType:1];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            MainTableCell.textField.placeholder = @"Name";
            MainTableCell.textField.text = editingWeek.WeekName;
            return MainTableCell;
        }
        else if (indexPath.row == 1) {
            MainTableFile5 *MainTableCell = [MainData getCellType:5];
            MainTableCell.backgroundView = [MainData getViewType:6];
            MainTableCell.textView.text = @"zum bearbeiten klicken";
            return MainTableCell;
        }
    }
    else if (indexPath.section == 1) { // Wochendauer
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            MainTableCell.custumTextLabel1.text = @"Zeiten bearbeiten";
            MainTableCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return MainTableCell;
        }
        else {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.custumTextLabel1.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
            MainTableCell.custumTextLabel1.text = [[editingWeek.WeekDurationNames objectAtIndex:indexPath.row - 1] DayName];
            MainTableCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return MainTableCell;
        }
    }
    else if (indexPath.section == 2) { // Fertig
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.custumTextLabel1.textColor = [UIColor whiteColor];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.custumTextLabel1.highlightedTextColor = [UIColor whiteColor];
        MainTableCell.backgroundView = [MainData getViewType:5];
        MainTableCell.custumTextLabel1.text = @"Woche löschen";
        
        return MainTableCell;
    }
    return 0;
}

- (void)doneEditingTimes:(NSMutableArray *)newWeekMaxHouresTimes {
    editingWeek.WeekMaxHouresTimes = newWeekMaxHouresTimes;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (weekEditDetail == nil) weekEditDetail = [[WeekEditDetail alloc] init];
            weekEditDetail.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            weekEditDetail.modalPresentationStyle = UIModalPresentationFormSheet;
            weekEditDetail.delegate = self;
            [weekEditDetail reloadWithWeekMaxHouresTimes:editingWeek.WeekMaxHouresTimes];
            [self presentViewController:weekEditDetail animated:YES completion:NULL];
        }
        else {
            if (weekEditDetail2 == nil) weekEditDetail2 = [[WeekEditDetail2 alloc] init];
            weekEditDetail2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            weekEditDetail2.modalPresentationStyle = UIModalPresentationFormSheet;
            weekEditDetail2.delegate = self;
            [weekEditDetail2 reloadWithDay:[editingWeek.WeekDurationNames objectAtIndex:(int)indexPath.row-1] andIndex:(int)indexPath.row-1];
            [self presentViewController:weekEditDetail2 animated:YES completion:NULL];
        }
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            if (!newWeek) {
                UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"Woche löschen" otherButtonTitles:nil];
                really.tag = 2;
                [really showInView:self.view];
            }
        }
    }
}

- (void)typeText:(NSString *)text index:(NSIndexPath *)index {
    if (index.section == 0 && index.row == 0) editingWeek.WeekName = text;
}
- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    if (index.section == 0 && index.row == 0) editingWeek.WeekName = string;
}
- (void)keyboardVisible:(BOOL)visible {
    
}
- (void)startTypingAtIndexPath:(NSIndexPath *)indexp {
    
}

- (IBAction)done:(id)sender {
    if (newWeek) {
        NSMutableArray *Weeks = [MainData LoadMain];
        [[[Weeks objectAtIndex:editingPersonIndex] Weeks] addObject:editingWeek];
        [MainData SaveMain:Weeks];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        NSMutableArray *Weeks = [MainData LoadMain];
        [[[Weeks objectAtIndex:editingPersonIndex] Weeks] removeObjectAtIndex:editingWeekIndex];
        [[[Weeks objectAtIndex:editingPersonIndex] Weeks] insertObject:editingWeek atIndex:editingWeekIndex];
        [MainData SaveMain:Weeks];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)doneEditing:(Day *)day andIndex:(int)index {
    [editingWeek.WeekDurationNames removeObjectAtIndex:index];
    [editingWeek.WeekDurationNames insertObject:day atIndex:index];
    [table reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0) return 30;
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//	return NO;
//}






// ---------- Cancel Edit ----------
- (IBAction)cancel:(id)sender {
    NSMutableArray *Weeks = [MainData LoadMain];
    if (![[[[Weeks objectAtIndex:editingPersonIndex] Weeks] objectAtIndex:editingWeekIndex] isEqual:editingWeek]) {
        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"Änderungen verwerfen" otherButtonTitles:nil];
        really.tag = 10;
        [really showInView:self.view];
    }
    else [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 10 && buttonIndex == 0) [self dismissViewControllerAnimated:YES completion:NULL];
    else if (actionSheet.tag == 2 && buttonIndex == 0) {
        NSMutableArray *Weeks = [MainData LoadMain];
        [[[Weeks objectAtIndex:editingPersonIndex] Weeks] removeObjectAtIndex:editingWeekIndex];
        [MainData SaveMain:Weeks];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
// ---------------------------------




@end
