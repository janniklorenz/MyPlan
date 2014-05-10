//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FachEditDetail.h"
#import "MainTableFile2.h"
#import "MainTableFile8.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Info.h"
#import "Subject.h"


@interface FachEditDetail ()

@end

@implementation FachEditDetail

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FachEditDetail alloc] initWithNibName:@"FachEditDetail_iPhone" bundle:nil];
    else self = [[FachEditDetail alloc] initWithNibName:@"FachEditDetail_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    WeekDays = [NSMutableArray arrayWithObjects:@"Montag", @"Dienstag", @"Mittwoch", @"Donnerstag", @"Freitag", @"Samstag", @"Sonntag", nil];
    
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    self.navigationController.navigationBarHidden = NO;
    self.title = [WeekDays objectAtIndex:editingDayIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)reloadViewsWithSubject:(Subject *)eSubject andDayIndex:(int)dindex {
    editingDayIndex = dindex;
    editingSubject = eSubject;
    [table reloadData];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [editingSubject.Infos count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"Infos - %@", [WeekDays objectAtIndex:editingDayIndex]];
            return MainTableCell;
        }
        else {
            MainTableFile8 *MainTableCell = [MainData getCellType:8];
            MainTableCell.backgroundView = [MainData getViewType:4];
            
            MainTableCell.NameLabel.text = [[editingSubject.Infos objectAtIndex:indexPath.row-1] InfoName];
            MainTableCell.InfoLabel.text = [[editingSubject.Infos objectAtIndex:indexPath.row-1] getInfoForDay:editingDayIndex];
            
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            
            return MainTableCell;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0) return 34;
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}






- (void)typeName:(NSString *)name index:(NSIndexPath *)index {
    [[editingSubject.Infos objectAtIndex:index.row-1] changeNameTo:name];
}
- (void)typeInfo:(NSString *)info index:(NSIndexPath *)index {
    [[editingSubject.Infos objectAtIndex:index.row-1] changeInfoForDay:editingDayIndex to:info];
}
- (void)didEndNameAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    
}
- (void)didEndInfoAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    
}
- (void)didStartNameAtIndex:(NSIndexPath *)indexp {
    [table scrollToRowAtIndexPath:indexp atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (void)didStartInfoAtIndex:(NSIndexPath *)indexp {
    [table scrollToRowAtIndexPath:indexp atScrollPosition:UITableViewScrollPositionTop animated:YES];
}







- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}



@end
