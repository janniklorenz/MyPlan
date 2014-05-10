//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "WeekEditDetail2.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "Week.h"
#import "Day.h"
#import "MPDate.h"

@interface WeekEditDetail2 ()

@end

@implementation WeekEditDetail2

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[WeekEditDetail2 alloc] initWithNibName:@"WeekEditDetail2_iPhone" bundle:nil];
    else self = [[WeekEditDetail2 alloc] initWithNibName:@"WeekEditDetail2_iPad" bundle:nil];
    return self;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) return UIInterfaceOrientationMaskPortrait;
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    navBar.topItem.title = editingDay.DayName;
    
    if (editingDay.sameTimes) {
        fromPicker.hidden = YES;
        toPicker.hidden = YES;
    }
    else {
        fromPicker.hidden = NO;
        toPicker.hidden = NO;
        editingDate = [editingDay.WeekMaxHouresTimes objectAtIndex:0];
        editingDateIndex = 0;
        [fromPicker selectRow:[editingDate startHoure] inComponent:0 animated:YES];
        [fromPicker selectRow:[editingDate startMinute] inComponent:1 animated:YES];
        [toPicker selectRow:[editingDate stopHoure] inComponent:0 animated:YES];
        [toPicker selectRow:[editingDate stopMinute] inComponent:1 animated:YES];
//        [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)reloadWithDay:(Day *)day andIndex:(int)index; {
    editingDay = day;
    editingIndex = index;
    navBar.topItem.title = editingDay.DayName;
    [table reloadData];
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (editingDay.sameTimes) return 1;
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    else if (section == 1) return [editingDay.WeekMaxHouresTimes count] + 1;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MainTableFile4 *MainTableCell = [MainData getCellType:4];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        
        MainTableCell.textLabel.text = @"Gleiche Zeiten";
        MainTableCell.tableSwitch.on = editingDay.sameTimes;
        
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        
        return MainTableCell;
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MainTableFile3 *MainTableCell = [MainData getCellType:3];
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            MainTableCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            MainTableCell.textLabel.text = @"Zeiten:";
            MainTableCell.textField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[editingDay.WeekMaxHouresTimes count]];
            return MainTableCell;
        }
        else {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"%li. Stunde von %@ bis %@", (long)indexPath.row, [[editingDay.WeekMaxHouresTimes objectAtIndex:indexPath.row - 1] from], [[editingDay.WeekMaxHouresTimes objectAtIndex:indexPath.row - 1] to]];;
            return MainTableCell;
        }
    }
    
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0) {
        editingDate = [editingDay.WeekMaxHouresTimes objectAtIndex:indexPath.row - 1];
        editingDateIndex = (int)indexPath.row-1;
        [fromPicker selectRow:[editingDate startHoure] inComponent:0 animated:YES];
        [fromPicker selectRow:[editingDate startMinute] inComponent:1 animated:YES];
        [toPicker selectRow:[editingDate stopHoure] inComponent:0 animated:YES];
        [toPicker selectRow:[editingDate stopMinute] inComponent:1 animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 44;
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) return 44;
        return 34;
    }
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}


- (void)changesSwitchTo:(BOOL)switchValue inIndexPath:(NSIndexPath *)ipath {
    editingDay.sameTimes = switchValue;
    if (editingDay.sameTimes) {
        [table deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        fromPicker.hidden = YES;
        toPicker.hidden = YES;
    }
    else {
        fromPicker.hidden = NO;
        toPicker.hidden = NO;
        [table insertSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        [table selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1] animated:YES scrollPosition:UITableViewScrollPositionTop];
        editingDate = [editingDay.WeekMaxHouresTimes objectAtIndex:0];
        editingDateIndex = 0;
        [fromPicker selectRow:[editingDate startHoure] inComponent:0 animated:YES];
        [fromPicker selectRow:[editingDate startMinute] inComponent:1 animated:YES];
        [toPicker selectRow:[editingDate stopHoure] inComponent:0 animated:YES];
        [toPicker selectRow:[editingDate stopMinute] inComponent:1 animated:YES];
    }
//    [table reloadData];
}



- (void)typeText:(NSString *)text index:(NSIndexPath *)index {
    
}
- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    if (index.section == 0 && index.row == 0) {
        editingDay.DayName = string;
        navBar.topItem.title = editingDay.DayName;
    }
    else if (index.section == 1 && index.row == 0) {
        if ([string intValue] < 1) string = @"1";
        if ([string intValue] > [editingDay.WeekMaxHouresTimes count]) {
            for (int i = [string intValue]; i > [editingDay.WeekMaxHouresTimes count]; ) [editingDay.WeekMaxHouresTimes addObject:[MPDate newTimeFromHoure:0 andMinute:0 toHoure:0 andMinute:0]];
            [table reloadData];
        }
        else if ([string intValue] < [editingDay.WeekMaxHouresTimes count]) {
            for (int i = [string intValue]; i < [editingDay.WeekMaxHouresTimes count];) [editingDay.WeekMaxHouresTimes removeLastObject];
            [table reloadData];
        }
    }
}
- (void)keyboardVisible:(BOOL)visible {
    
}
- (void)startTypingAtIndexPath:(NSIndexPath *)indexp {
    
}







- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) return 24;
    else return 60;
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    return 60;
//}

- (NSString *)makeZeros:(int)value {
    if (value < 10) return [NSString stringWithFormat:@"0%i", value];
    return [NSString stringWithFormat:@"%i", value];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == 0) return [NSString stringWithFormat:@"%@", [self makeZeros:(int)row]];
    else return [NSString stringWithFormat:@"%@", [self makeZeros:(int)row]];
    return 0;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    MPDate *new;
    if (thePickerView == fromPicker) {
        if (component == 0) new = [MPDate newTimeFromHoure:(int)row andMinute:editingDate.startMinute toHoure:editingDate.stopHoure andMinute:editingDate.stopMinute];
        else new = [MPDate newTimeFromHoure:editingDate.startHoure andMinute:(int)row toHoure:editingDate.stopHoure andMinute:editingDate.stopMinute];
    }
    if (thePickerView == toPicker) {
        if (component == 0) new = [MPDate newTimeFromHoure:editingDate.startHoure andMinute:editingDate.startMinute toHoure:(int)row andMinute:editingDate.stopMinute];
        else new = [MPDate newTimeFromHoure:editingDate.startHoure andMinute:editingDate.startMinute toHoure:editingDate.stopHoure andMinute:(int)row];
    }
    editingDate = new;
    [editingDay.WeekMaxHouresTimes removeObjectAtIndex:editingDateIndex];
    [editingDay.WeekMaxHouresTimes insertObject:new atIndex:editingDateIndex];
    [table reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table selectRowAtIndexPath:[NSIndexPath indexPathForRow:editingDateIndex+1 inSection:1] animated:NO scrollPosition:UITableViewScrollPositionNone];
}





// Cancel Edit
- (IBAction)cancel:(id)sender {
    [self.delegate doneEditing:editingDay andIndex:editingIndex];
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
