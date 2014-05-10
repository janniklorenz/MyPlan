//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "WeekEditDetail.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "Week.h"
#import "Day.h"
#import "MPDate.h"

@interface WeekEditDetail ()

@end

@implementation WeekEditDetail

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[WeekEditDetail alloc] initWithNibName:@"WeekEditDetail_iPhone" bundle:nil];
    else self = [[WeekEditDetail alloc] initWithNibName:@"WeekEditDetail_iPad" bundle:nil];
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
    table.backgroundView = nil;
}


- (void)viewDidAppear:(BOOL)animated {
    
    editingDate = [WeekMaxHouresTimes objectAtIndex:0];
    editingDateIndex = 0;
    [fromPicker selectRow:[editingDate startHoure] inComponent:0 animated:YES];
    [fromPicker selectRow:[editingDate startMinute] inComponent:1 animated:YES];
    [toPicker selectRow:[editingDate stopHoure] inComponent:0 animated:YES];
    [toPicker selectRow:[editingDate stopMinute] inComponent:1 animated:YES];
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)reloadWithWeekMaxHouresTimes:(NSMutableArray *)newWeekMaxHouresTimes {
    WeekMaxHouresTimes = newWeekMaxHouresTimes;
    [table reloadData];
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [WeekMaxHouresTimes count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MainTableFile3 *MainTableCell = [MainData getCellType:3];
        MainTableCell.delegate = self;
        MainTableCell.indexPath = indexPath;
        MainTableCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        MainTableCell.textLabel.text = @"Zeiten:";
        MainTableCell.textField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[WeekMaxHouresTimes count]];
        return MainTableCell;
    }
    else {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:4];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.delegate = self;
        MainTableCell.indexPath = indexPath;
        MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"%li. Stunde von %@ bis %@", (long)indexPath.row, [[WeekMaxHouresTimes objectAtIndex:indexPath.row - 1] from], [[WeekMaxHouresTimes objectAtIndex:indexPath.row - 1] to]];;
        return MainTableCell;
    }
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0) {
        fromPicker.hidden = NO;
        toPicker.hidden = NO;
        editingDate = [WeekMaxHouresTimes objectAtIndex:indexPath.row-1];
        editingDateIndex = (int)indexPath.row-1;
        [fromPicker selectRow:[editingDate startHoure] inComponent:0 animated:YES];
        [fromPicker selectRow:[editingDate startMinute] inComponent:1 animated:YES];
        [toPicker selectRow:[editingDate stopHoure] inComponent:0 animated:YES];
        [toPicker selectRow:[editingDate stopMinute] inComponent:1 animated:YES];
    }
}

- (void)longPressAtIndexPath:(NSIndexPath *)ipath andSender:(id)sender {
//    [self.delegate didSelectRowAtIndexPath:ipath Long:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) return 44;
    return 34;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}




- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    if (index.section == 0 && index.row == 0) {
        if ([string intValue] < 1) string = @"1";
        if ([string intValue] > [WeekMaxHouresTimes count]) {
            for (int i = [string intValue]; i > [WeekMaxHouresTimes count];) [WeekMaxHouresTimes addObject:[MPDate newTimeFromHoure:0 andMinute:0 toHoure:0 andMinute:0]];
            [table reloadData];
        }
        else if ([string intValue] < [WeekMaxHouresTimes count]) {
            for (int i = [string intValue]; i < [WeekMaxHouresTimes count];) [WeekMaxHouresTimes removeLastObject];
            [table reloadData];
        }
    }
}
- (void)typeText:(NSString *)text index:(NSIndexPath *)index {
    
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
    [WeekMaxHouresTimes removeObjectAtIndex:editingDateIndex];
    [WeekMaxHouresTimes insertObject:new atIndex:editingDateIndex];
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table selectRowAtIndexPath:[NSIndexPath indexPathForRow:editingDateIndex+1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}



// Cancel Edit
- (IBAction)cancel:(id)sender {
    [self.delegate doneEditingTimes:WeekMaxHouresTimes];
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
