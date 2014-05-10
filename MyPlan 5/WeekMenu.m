//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "WeekMenu.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Week.h"
#import "Person.h"
#import "AppData.h"

@interface WeekMenu ()

@end

@implementation WeekMenu

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[WeekMenu alloc] initWithNibName:@"WeekMenu_iPhone" bundle:nil];
    else self = [[WeekMenu alloc] initWithNibName:@"WeekMenu_iPad" bundle:nil];
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    appData = [MainData LoadAppData];
    Persons = [MainData LoadMain];
    for (int i = 0; i < [Persons count]; i++) {
        if ([[[Persons objectAtIndex:i] PersonID] isEqualToString:appData.selectedPersonID]) openedIndex = i + 1;
    }
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    menuContend = [self menuArray];
    [table reloadData];
}




- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (NSMutableArray *)menuArray {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:nil];
    [array addObject:[NSMutableArray arrayWithObjects:@"Person erstellen", nil]];
    
    for (int i = 0; i < [Persons count]; i++) {
        NSMutableArray *subWeeks = [NSMutableArray arrayWithObjects:nil];
        [subWeeks addObject:[[Persons objectAtIndex:i] PersonName]];
        for (int ii = 0; ii < [[[Persons objectAtIndex:i] Weeks] count]; ii++) [subWeeks addObject:[[[[Persons objectAtIndex:i] Weeks] objectAtIndex:ii] WeekName]];
        [subWeeks addObject:@"Woche erstellen"];
        [subWeeks addObject:@"Person bearbeiten"];
        [array addObject:subWeeks];
    }
    
    
    [array addObject:[NSMutableArray arrayWithObjects:@"Einstellungen", @"Generell", @"Hintergrund", @"Benachrichtigungen", @"Infos", nil]];
    return array;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [menuContend count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section + 1 != [menuContend count] && section != 0 && openedIndex != section) return 1;// [[menuContend objectAtIndex:section] count];
    return [[menuContend objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.delegate = self;
        MainTableCell.indexPath = indexPath;
        if (indexPath.section == 0 && indexPath.row == 0) {
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_3.png"];
        }
        else if (indexPath.section != 0 && indexPath.section + 1 != [menuContend count] && indexPath.row == 0) {
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_1.png"];
            if ([[[Persons objectAtIndex:indexPath.section - 1] PersonID] isEqualToString:[appData selectedPersonID]]) {
                MainTableCell.accessoryType = UITableViewCellAccessoryCheckmark;
                openedIndex = (int)indexPath.section;
            }
        }
        else if (indexPath.section + 1 == [menuContend count] && indexPath.row == 0) {
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_2.png"];
        }
        MainTableCell.custumTextLabel1.text = [[menuContend objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return MainTableCell;
    }
    else {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:4];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.delegate = self;
        MainTableCell.indexPath = indexPath;
        [MainTableCell longPress:YES];
        if (indexPath.section != 0 && indexPath.section + 1 != [menuContend count] && indexPath.row != 0) {
            if ([[[Persons objectAtIndex:indexPath.section - 1] Weeks] count] > indexPath.row-1) {
                if ([[[Persons objectAtIndex:indexPath.section - 1] selectedWeekID] isEqualToString:[[[[Persons objectAtIndex:indexPath.section - 1] Weeks] objectAtIndex:indexPath.row-1] WeekID]]) {
                    MainTableCell.accessoryType = UITableViewCellAccessoryCheckmark;
                    openedIndex = (int)indexPath.section;
                }
            }
            else if ([[[Persons objectAtIndex:indexPath.section - 1] Weeks] count] == indexPath.row-1) {
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_5.png"];
            }
            else {
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_6.png"];
            }
        }
        MainTableCell.custumTextLabel1.text = [[menuContend objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return MainTableCell;
    }

    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0 && indexPath.section != 0) return 34;
    return 44;
}
- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) [self.delegate didSelectAddPerson];
    else if (indexPath.section + 1 == [menuContend count]) [self.delegate didSelectSettingsWithRow:(int)indexPath.row];
    else {
        if (indexPath.section + 1 != [menuContend count] && indexPath.section != 0) {
            openedIndex = (int)indexPath.section;
        }
        if (indexPath.row + 2 == [[menuContend objectAtIndex:indexPath.section] count]) [self.delegate didSelectCreateWeek];
        else if (indexPath.row + 1 == [[menuContend objectAtIndex:(int)indexPath.section] count]) [self.delegate didSelectPersonEditWithRow:(int)indexPath.section-1];
        else if (indexPath.row == 0) [self.delegate didSelectPerson:(int)indexPath.section-1];
        else [self.delegate didSelectWeekWithRow:(int)indexPath.row-1 andPersonRow:(int)indexPath.section-1];
        [self.delegate enablePersonAtIndex:(int)indexPath.section-1];
        
        appData = [MainData LoadAppData];
        Persons = [MainData LoadMain];
        [table reloadData];
    }
    [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}
- (void)longPressAtIndexPath:(NSIndexPath *)indexPath andSender:(id)sender {
    if (indexPath.section == 0) ;
    else if (indexPath.section + 1 == [menuContend count]) ;
    else if (indexPath.row + 2 == [[menuContend objectAtIndex:indexPath.section] count]) ;
    else if (indexPath.row + 1 == [[menuContend objectAtIndex:indexPath.section] count]) ;
    else if (indexPath.row == 0) ;
    else {
        if (indexPath.section + 1 != [menuContend count] && indexPath.section != 0) {
            openedIndex = (int)indexPath.section;
        }
        if (indexPath.row + 1 != [[menuContend objectAtIndex:(int)indexPath.section] count] && indexPath.row + 2 != [[menuContend objectAtIndex:(int)indexPath.section] count]) [self.delegate didSelectWeekEditWithRow:(int)indexPath.row-1 andPersonRow:(int)indexPath.section-1];
        [self.delegate enablePersonAtIndex:(int)indexPath.section-1];
        appData = [MainData LoadAppData];
        [table reloadData];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}




@end
