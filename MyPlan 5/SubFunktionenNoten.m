//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "SubFunktionenNoten.h"
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
#import "Note.h"
#import "SubFunktionenNotenDetail.h"

@interface SubFunktionenNoten ()

@end

@implementation SubFunktionenNoten

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[SubFunktionenNoten alloc] initWithNibName:@"SubFunktionenNoten_iPhone" bundle:nil];
    else self = [[SubFunktionenNoten alloc] initWithNibName:@"SubFunktionenNoten_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek andSubjectIndex:(int)vSubjectIndex {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    viewungSubjectIndex = vSubjectIndex;
    
    viewingSubject = [viewingPerson.Subjects objectAtIndex:viewungSubjectIndex];
    
    self.title = viewingSubject.SubjectNameAndShort;
    
    [table reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
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
        case 0:return [viewingSubject.Noten count]+2;break;
        case 1:return 1;break;
        default:
            break;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_16.png"];
            MainTableCell.custumTextLabel1.text = viewingSubject.SubjectName;
            return MainTableCell;
        }
        else if (indexPath.row < [viewingSubject.Noten count]+1) {
            SubjectCell1 *MainTableCell = [MainData getCellType:101];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.SubjectNameLabel.text = [[viewingSubject.Noten objectAtIndex:indexPath.row-1] NoteNotiz];
            MainTableCell.SubjectTimeLabel.text = [NSString stringWithFormat:@"%g", [MainData runden:[[viewingSubject.Noten objectAtIndex:indexPath.row-1] NoteWert] stellen:2]];
            return MainTableCell;
        }
        else {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_5.png"];
            MainTableCell.custumTextLabel1.text = @"Neue Note";
            return MainTableCell;
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SubjectCell1 *MainTableCell = [MainData getCellType:101];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.SubjectNameLabel.text = @"Gesamt";
            MainTableCell.SubjectTimeLabel.text = [viewingSubject getCompleteNote];
            return MainTableCell;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0 && indexPath.row < [viewingSubject.Noten count]+1) {
        if (subFunktionenNotenDetail == nil) subFunktionenNotenDetail = [[SubFunktionenNotenDetail alloc] init];
        [subFunktionenNotenDetail reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andSubjectIndex:viewungSubjectIndex andNotenIndex:indexPath.row-1];
        subFunktionenNotenDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        subFunktionenNotenDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        subFunktionenNotenDetail.delegate = self;
        [self presentViewController:subFunktionenNotenDetail animated:YES completion:NULL];
    }
    else if (indexPath.section == 0 && indexPath.row != 0 && indexPath.row == [viewingSubject.Noten count]+1) {
        if (subFunktionenNotenDetail == nil) subFunktionenNotenDetail = [[SubFunktionenNotenDetail alloc] init];
        [subFunktionenNotenDetail reloadNewWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andSubjectIndex:viewungSubjectIndex];
        subFunktionenNotenDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        subFunktionenNotenDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        subFunktionenNotenDetail.delegate = self;
        [self presentViewController:subFunktionenNotenDetail animated:YES completion:NULL];
    }
    [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0) return 34;
    else if (indexPath.section == 1 && indexPath.row != 0) return 34;
    return 44;
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[viewingSubject.Noten objectAtIndex:indexPath.row-1] prepareDelete];
    [viewingSubject.Noten removeObjectAtIndex:indexPath.row-1];
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0 && indexPath.row < [viewingSubject.Noten count]+1) return YES;
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


@end
