//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenHausaufgabe.h"
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
#import "FunktionenHausaufgabeDetail.h"
#import "Homework.h"

@interface FunktionenHausaufgabe ()

@end

@implementation FunktionenHausaufgabe

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenHausaufgabe alloc] initWithNibName:@"FunktionenHausaufgabe_iPhone" bundle:nil];
    else self = [[FunktionenHausaufgabe alloc] initWithNibName:@"FunktionenHausaufgabe_iPad" bundle:nil];
    return self;
}




- (void)viewDidLoad {
    self.title = @"Hausaufgabe";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addHomework:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [table addGestureRecognizer:swipe];
}

- (void)swipeBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addHomework:(id)sender {
    if (funktionenHausaufgabeDetail == nil) funktionenHausaufgabeDetail = [[FunktionenHausaufgabeDetail alloc] init];
    [funktionenHausaufgabeDetail reloadWithNewHomeworkViewingIndex:viewingIndex andPerson:viewingPerson];
    funktionenHausaufgabeDetail.modalPresentationStyle = UIModalPresentationFormSheet;
    funktionenHausaufgabeDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    funktionenHausaufgabeDetail.delegate = self;
    [self presentViewController:funktionenHausaufgabeDetail animated:YES completion:NULL];
}

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    
    [self reloadContendArray];
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    [self reloadContendArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)reloadContendArray {
    ContendArray = [NSMutableArray arrayWithObjects:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, dd.MM.yyyy"];
    for (int i = 0; i < [viewingPerson.Homeworks count]; i++) {
        BOOL Found = NO;
        int FoundIndex = 0;
        int ii;
        for (ii = 0; ii < [ContendArray count] && Found == NO; ii++) {
            NSString *stringFromDate = [formatter stringFromDate:[[viewingPerson.Homeworks objectAtIndex:i] HomeworkDate]];
            
            if ([stringFromDate isEqual:[[ContendArray objectAtIndex:ii] objectAtIndex:0]]) {
                Found = YES;
                FoundIndex = ii;
            }
        }
        if (Found) {
            [[ContendArray objectAtIndex:FoundIndex] addObject:[viewingPerson.Homeworks objectAtIndex:i]];
        }
        else {
            NSString *stringFromDate = [formatter stringFromDate:[[viewingPerson.Homeworks objectAtIndex:i] HomeworkDate]];
            NSMutableArray *VertretungsDay = [NSMutableArray arrayWithObjects: stringFromDate, [viewingPerson.Homeworks objectAtIndex:i], nil];
            [ContendArray addObject:VertretungsDay];
            
        }
    }
    if ([ContendArray count] > 0) {
        NSMutableArray *new = [NSMutableArray arrayWithObjects:[ContendArray objectAtIndex:0], nil];
        for (int i = 1; i < [ContendArray count]; i++) {
            BOOL x = NO;
            int y = 0;
            for (int ii = 0; ii < [new count] && x == NO; ii++) {
                if ([[formatter dateFromString:[[new objectAtIndex:ii] objectAtIndex:0]] timeIntervalSince1970] > [[formatter dateFromString:[[ContendArray objectAtIndex:i] objectAtIndex:0]] timeIntervalSince1970]) {
                    x = YES;
                    y = ii;
                }
            }
            if (x) [new insertObject:[ContendArray objectAtIndex:i] atIndex:y];
            else [new addObject:[ContendArray objectAtIndex:i]];
        }
        ContendArray = new;
    }
    [table reloadData];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ContendArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ContendArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.custumTextLabel1.text = [[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_19.png"];
        return MainTableCell;
    }
    else {
        SubjectCell1 *MainTableCell = [MainData getCellType:101];
        if ([[[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] ConnectedSubjectID] isEqualToString:@""]) {
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.SubjectNameLabel.textColor = [UIColor blackColor];
            MainTableCell.SubjectTimeLabel.textColor = [UIColor blackColor];
        }
        else {
            UIColor *SubjectColor = [[viewingPerson getSubjectForID:[[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] ConnectedSubjectID]] SubjectColor];
            MainTableCell.backgroundView = [MainData getViewWithColor:SubjectColor];
            MainTableCell.SubjectNameLabel.textColor = [MainData getTextColorForBackgroundColor:SubjectColor];
            MainTableCell.SubjectTimeLabel.textColor = [MainData getTextColorForBackgroundColor:SubjectColor];
            
        }
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.SubjectNameLabel.text = [[viewingPerson.Homeworks objectAtIndex:indexPath.row-1] HomeworkName];
        Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingPerson.Homeworks objectAtIndex:indexPath.row-1] ConnectedSubjectID]];
        if ([[[viewingPerson.Homeworks objectAtIndex:indexPath.row-1] ConnectedSubjectID] isEqualToString:@""]) MainTableCell.SubjectTimeLabel.text = @"";
        else MainTableCell.SubjectTimeLabel.text = rowSubject.SubjectName;
        return MainTableCell;

    }
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) {
        if (funktionenHausaufgabeDetail == nil) funktionenHausaufgabeDetail = [[FunktionenHausaufgabeDetail alloc] init];
        
        int index = [viewingPerson.Homeworks indexOfObject:[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        
        [funktionenHausaufgabeDetail reloadWithHomeworkAtIndex:index ViewingIndex:viewingIndex andPerson:viewingPerson];
        funktionenHausaufgabeDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        funktionenHausaufgabeDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        funktionenHausaufgabeDetail.delegate = self;
        [self presentViewController:funktionenHausaufgabeDetail animated:YES completion:NULL];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) return 34;
    return 44;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int index = [viewingPerson.Homeworks indexOfObject:[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    [[viewingPerson.Homeworks objectAtIndex:index] prepareDelete];
    [viewingPerson.Homeworks removeObjectAtIndex:index];
    
    [self reloadContendArray];
    
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) return YES;
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


@end
