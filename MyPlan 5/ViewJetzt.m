//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "ViewJetzt.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import "MainTableFile8.h"
#import "SubjectCell1.h"
#import "SubjectCell2.h"
#import "SubjectCell3.h"
#import "SubjectCell4.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Week.h"
#import "Subject.h"
#import "MPDate.h"
#import "WeekEditDetail.h"
#import "WeekEditDetail2.h"
#import "Day.h"
#import "Person.h"
#import "AppData.h"
#import "Houre.h"
#import "Notiz.h"
#import "Info.h"
#import "Note.h"
#import "SubFunktionenNotenDetail.h"
#import "Homework.h"
#import "FunktionenHausaufgabeDetail.h"
#import "Termin.h"
#import "FunktionenTermineDetail.h"
#import "FunktionenNotizDetail.h"

@interface ViewJetzt ()

@end

@implementation ViewJetzt

@synthesize hideProgress;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[ViewJetzt alloc] initWithNibName:@"ViewJetzt_iPhone" bundle:nil];
    else self = [[ViewJetzt alloc] initWithNibName:@"ViewJetzt_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    [self reloadTitle];
    
    OppendInfos = YES;
    OppendNoten = NO;
    OppendHausaufgaben = NO;
    OppendTermine = NO;
    OppendNotizen = NO;
    
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeL.direction = UISwipeGestureRecognizerDirectionRight;
    [table addGestureRecognizer:swipeL];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [super viewDidLoad];
    
    banner2 = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    self.navigationController.navigationBarHidden = NO;
    DayIndexSegmentedControl.selectedSegmentIndex = DayIndex;
    
    [table reloadData];
    
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
//    else {
//        table.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-banner2.frame.size.height);
//        backImg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-banner2.frame.size.height);
//        
//        
//        NSLog(@"NOOOO");
//    }
    
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
    [table setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backImg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (![[MainData LoadAppData] AdFree]) {
        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.5];
        table.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-banner2.frame.size.height);
        backImg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-banner2.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)swipeLeft:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadTitle {
    WeekDays = [NSMutableArray arrayWithObjects:@"Montag", @"Dienstag", @"Mittwoch", @"Donnerstag", @"Freitag", @"Samstag", @"Sonntag", nil];
    self.title = [NSString stringWithFormat:@"%@ (%lu. Stunden)", [WeekDays objectAtIndex:DayIndex], (unsigned long)[DaySubjets count]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek andDay:(int)newDay andHoure:(int)newHoure {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    DayIndex = newDay;
    DayIndexSegmentedControl.selectedSegmentIndex = DayIndex;
    viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:DayIndex];
    if (DayIndex == [MainData dayIndex]) hideProgress = YES;
    else hideProgress = NO;
    
    viewingHoure = newHoure;
    
    DaySubjets = [NSMutableArray arrayWithObjects:nil];
    for (int i = 0; i < [viewingDay.Subjects count]; i++) [DaySubjets addObject:[viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:i] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:i inWeek:viewingWeek]];
    
    [self reloadTitle];
    [table reloadData];
}
- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    
    DayIndex = [MainData dayIndex];
    DayIndexSegmentedControl.selectedSegmentIndex = DayIndex;
    viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:DayIndex];
    if (DayIndex == [MainData dayIndex]) hideProgress = YES;
    else hideProgress = NO;
    
    viewingHoure = [self getCurrendHoure];
    
    DaySubjets = [NSMutableArray arrayWithObjects:nil];
    for (int i = 0; i < [viewingDay.Subjects count]; i++) [DaySubjets addObject:[viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:i] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:i inWeek:viewingWeek]];
    
    
    [table reloadData];
}




- (void)orientationChanged:(NSNotification *)notification {
    [table reloadData];
}

- (int)getCurrendHoure {
    for (int i = 0; i < [viewingDay.Subjects count]; i++) {
        MPDate *usedDate = [viewingWeek getDateForDay:DayIndex andHoure:i];
        if (usedDate.isClear) {}
        else if (usedDate.toSec < [MainData daySeconds]) {}
        else if (usedDate.toSec > [MainData daySeconds] && usedDate.fromSec < [MainData daySeconds]) {
            return i;
        }
        else if (usedDate.fromSec > [MainData daySeconds]) {}
    }
    
    return 0;//[viewingDay.Subjects count] - 1; // erkennen lassen ob alle rum oder 
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    Subject *rowSubject = [Subject clearSubject];
    if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
    
    if ([viewingDay.Subjects count] == 0) return 1;
    if (rowSubject.isFree) return 1;
    return 6; // 6 (5.0.2)
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([viewingDay.Subjects count] == 0) return 1;
    else {
        Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
        switch (section) {
            case 0:
                if (hideProgress) return 2;
                else return 3;break;
            case 1:
                if (OppendInfos) return [rowSubject.Infos count]+1;
                else return 1;break;
            case 2:
                if (OppendNoten) return [rowSubject.Noten count]+2;
                else return 1;break;
            case 3:
                if (OppendHausaufgaben) return [[rowSubject homeworksInPerson:viewingPerson] count]+2;
                else return 1;break;
            case 4:
                if (OppendTermine) return [[rowSubject termineInPerson:viewingPerson] count]+2;
                else return 1;break;
            case 5:
                if (OppendNotizen) return [[rowSubject NotizenWithViewingPerson:viewingPerson] count]+2;
                else return 1;break;
            default:break;
        }
    }
    
    
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([viewingDay.Subjects count] == 0) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.custumTextLabel1.text = @"keine Stunden";
        return MainTableCell;
    }
    else {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                SubjectCell4 *MainTableCell = [MainData getCellType:104];
                MainTableCell.backgroundView = [MainData getViewType:6];
                MainTableCell.delegate = self;
                
                CGRect rec = CGRectMake(0, 0, self.view.frame.size.width-90, 50);
                
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) rec = CGRectMake(0, 0, self.view.frame.size.width-20, 50);
                
                [MainTableCell setUpScrollViewForSubjects:DaySubjets andCurrend:viewingHoure andFrame:rec];
                return MainTableCell;
                
            }
            else if (indexPath.row == 1) {
                SubjectCell3 *MainTableCell = [MainData getCellType:103];
                MainTableCell.backgroundView = [MainData getViewType:4];
                if (DayIndex == [MainData dayIndex]) [MainTableCell setMPDate:[viewingWeek getDateForDay:DayIndex andHoure:viewingHoure]];
                else [MainTableCell setMPDateWithDuration:[viewingWeek getDateForDay:DayIndex andHoure:viewingHoure]];
                return MainTableCell;
            }
            else if (indexPath.row == 2) {
                SubjectCell2 *MainTableCell = [MainData getCellType:102];
                MainTableCell.backgroundView = [MainData getViewType:4];
                [MainTableCell setMPDate:[viewingWeek getDateForDay:DayIndex andHoure:viewingHoure]];
                return MainTableCell;
            }
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:0];
                MainTableCell.custumTextLabel1.text = @"Infos";
                return MainTableCell;
            }
            else {
                MainTableFile8 *MainTableCell = [MainData getCellType:8];
                MainTableCell.backgroundView = [MainData getViewType:4];
                
                Subject *rowSubject = [Subject clearSubject];
                if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
                
                MainTableCell.NameLabel.text = [[rowSubject.Infos objectAtIndex:indexPath.row-1] InfoName];
                MainTableCell.InfoLabel.text = [[rowSubject.Infos objectAtIndex:indexPath.row-1] getInfoForDay:DayIndex];
                MainTableCell.NameLabel.enabled = NO;
                MainTableCell.InfoLabel.enabled = NO;// maybe enable for changing things
                
                MainTableCell.delegate = self;
                MainTableCell.indexPath = indexPath;
                
                return MainTableCell;
            }
        }
        else if (indexPath.section == 2) {
            Subject *rowSubject = [Subject clearSubject];
            if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
            if (indexPath.row == 0) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:0];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_16.png"];
                if ([[rowSubject getCompleteNote] floatValue] == 0) MainTableCell.custumTextLabel1.text = @"Noten";
                else MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"Noten (%@)", [rowSubject getCompleteNote]];
                return MainTableCell;
            }
            else if (indexPath.row < [rowSubject.Noten count]+1) {
                SubjectCell1 *MainTableCell = [MainData getCellType:101];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.SubjectNameLabel.text = [[rowSubject.Noten objectAtIndex:indexPath.row-1] NoteNotiz];
                MainTableCell.SubjectTimeLabel.text = [NSString stringWithFormat:@"%g", [MainData runden:[[rowSubject.Noten objectAtIndex:indexPath.row-1] NoteWert] stellen:2]];
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
        else if (indexPath.section == 3) {
            Subject *rowSubject = [Subject clearSubject];
            if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
            if (indexPath.row == 0) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:0];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_19.png"];
                if ([[rowSubject homeworksInPerson:viewingPerson] count] == 0) MainTableCell.custumTextLabel1.text = @"Hausaufgaben";
                else MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"Hausaufgaben (%lu)", (unsigned long)[[rowSubject homeworksInPerson:viewingPerson] count]];
                return MainTableCell;
            }
            else if (indexPath.row < [[rowSubject homeworksInPerson:viewingPerson] count]+1) {
                SubjectCell1 *MainTableCell = [MainData getCellType:101];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.SubjectNameLabel.text = [[[rowSubject homeworksInPerson:viewingPerson] objectAtIndex:indexPath.row-1] HomeworkName];
                MainTableCell.SubjectTimeLabel.text = [[[rowSubject homeworksInPerson:viewingPerson] objectAtIndex:indexPath.row-1] getRest];
                return MainTableCell;
            }
            else {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_5.png"];
                MainTableCell.custumTextLabel1.text = @"Neue Hausaufgabe";
                return MainTableCell;
            }
        }
        else if (indexPath.section == 4) {
            Subject *rowSubject = [Subject clearSubject];
            if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
            if (indexPath.row == 0) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:0];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_10.png"];
                if ([[rowSubject termineInPerson:viewingPerson] count] == 0) MainTableCell.custumTextLabel1.text = @"Termine";
                else MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"Termine (%i)", (int)[[rowSubject termineInPerson:viewingPerson] count]];
                return MainTableCell;
            }
            else if (indexPath.row < [[rowSubject termineInPerson:viewingPerson] count]+1) {
                SubjectCell1 *MainTableCell = [MainData getCellType:101];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.SubjectNameLabel.text = [[[rowSubject termineInPerson:viewingPerson] objectAtIndex:indexPath.row-1] TerminName];
                MainTableCell.SubjectTimeLabel.text = [[[rowSubject termineInPerson:viewingPerson] objectAtIndex:indexPath.row-1] getRest];
                return MainTableCell;
            }
            else {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_5.png"];
                MainTableCell.custumTextLabel1.text = @"Neuer Termin";
                return MainTableCell;
            }
        }
        
        
        
        
        
        
        else if (indexPath.section == 5) {
            Subject *rowSubject = [Subject clearSubject];
            if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
            if (indexPath.row == 0) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:0];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_25.png"];
                MainTableCell.custumTextLabel1.text = @"Notizen";
                return MainTableCell;
            }
            else if (indexPath.row < [[rowSubject NotizenWithViewingPerson:viewingPerson] count]+1) {
                SubjectCell1 *MainTableCell = [MainData getCellType:101];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.SubjectNameLabel.text = [[[rowSubject NotizenWithViewingPerson:viewingPerson] objectAtIndex:indexPath.row-1] NotizName];
                MainTableCell.SubjectTimeLabel.text = [[[rowSubject NotizenWithViewingPerson:viewingPerson] objectAtIndex:indexPath.row-1] getRest];
                return MainTableCell;
            }
            else {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_5.png"];
                MainTableCell.custumTextLabel1.text = @"Neue Notiz";
                return MainTableCell;
            }
        }
        
        
        
        
        
        
    }
    
    
    return 0;
}

- (void)changeSubjectTo:(int)index {
    viewingHoure = index;
//    [table reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table reloadData];
}


- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section > 0 && indexPath.row == 0) {
        if (indexPath.section == 1) {
            if (OppendInfos) OppendInfos = NO;
            else OppendInfos = YES;
        }
        else if (indexPath.section == 2) {
            if (OppendNoten) OppendNoten = NO;
            else OppendNoten = YES;
        }
        else if (indexPath.section == 3) {
            if (OppendHausaufgaben) OppendHausaufgaben = NO;
            else OppendHausaufgaben = YES;
        }
        else if (indexPath.section == 4) {
            if (OppendTermine) OppendTermine = NO;
            else OppendTermine = YES;
        }
        else if (indexPath.section == 5) {
            if (OppendNotizen) OppendNotizen = NO;
            else OppendNotizen = YES;
        }
        [table reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
    
    
    Subject *rowSubject = [Subject clearSubject];
    if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
    if (indexPath.section == 2 && indexPath.row != 0 && indexPath.row < [rowSubject.Noten count]+1) {
        if (subFunktionenNotenDetail == nil) subFunktionenNotenDetail = [[SubFunktionenNotenDetail alloc] init];
        [subFunktionenNotenDetail reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andSubjectIndex:[viewingPerson getSubjectIndexForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID]] andNotenIndex:(int)indexPath.row-1];
        subFunktionenNotenDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        subFunktionenNotenDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        subFunktionenNotenDetail.delegate = self;
        [self presentViewController:subFunktionenNotenDetail animated:YES completion:NULL];
    }
    else if (indexPath.section == 2 && indexPath.row != 0 && indexPath.row == [rowSubject.Noten count]+1) {
        if (subFunktionenNotenDetail == nil) subFunktionenNotenDetail = [[SubFunktionenNotenDetail alloc] init];
        [subFunktionenNotenDetail reloadNewWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andSubjectIndex:[viewingPerson getSubjectIndexForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID]]];
        subFunktionenNotenDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        subFunktionenNotenDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        subFunktionenNotenDetail.delegate = self;
        [self presentViewController:subFunktionenNotenDetail animated:YES completion:NULL];
    }
    if (indexPath.section == 3 && indexPath.row != 0 && indexPath.row < [[rowSubject homeworksInPerson:viewingPerson] count]+1) {
        if (funktionenHausaufgabeDetail == nil) funktionenHausaufgabeDetail = [[FunktionenHausaufgabeDetail alloc] init];
        [funktionenHausaufgabeDetail reloadWithHomeworkAtIndex:(int)indexPath.row-1 ViewingIndex:viewingIndex andPerson:viewingPerson];
        funktionenHausaufgabeDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        funktionenHausaufgabeDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        funktionenHausaufgabeDetail.delegate = self;
        [self presentViewController:funktionenHausaufgabeDetail animated:YES completion:NULL];
    }
    else if (indexPath.section == 3 && indexPath.row != 0 && indexPath.row == [[rowSubject homeworksInPerson:viewingPerson] count]+1) {
        if (funktionenHausaufgabeDetail == nil) funktionenHausaufgabeDetail = [[FunktionenHausaufgabeDetail alloc] init];
        [funktionenHausaufgabeDetail reloadWithNewHomeworkWithSubjectID:rowSubject.SubjectID ViewingIndex:viewingIndex andPerson:viewingPerson];
        funktionenHausaufgabeDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        funktionenHausaufgabeDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        funktionenHausaufgabeDetail.delegate = self;
        [self presentViewController:funktionenHausaufgabeDetail animated:YES completion:NULL];
    }
    
    
    
    if (indexPath.section == 4 && indexPath.row != 0 && indexPath.row < [[rowSubject termineInPerson:viewingPerson] count]+1) {
        if (funktionenTermineDetail == nil) funktionenTermineDetail = [[FunktionenTermineDetail alloc] init];
        int index = (int)[viewingPerson.Termine indexOfObject:[[rowSubject termineInPerson:viewingPerson] objectAtIndex:(int)indexPath.row-1]];
        [funktionenTermineDetail reloadWithTerminAtIndex:index ViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
        funktionenTermineDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        funktionenTermineDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        funktionenTermineDetail.delegate = self;
        [self presentViewController:funktionenTermineDetail animated:YES completion:NULL];
    }
    else if (indexPath.section == 4 && indexPath.row != 0 && indexPath.row == [[rowSubject termineInPerson:viewingPerson] count]+1) {
        if (funktionenTermineDetail == nil) funktionenTermineDetail = [[FunktionenTermineDetail alloc] init];
        [funktionenTermineDetail reloadWithNewTerminOnDate:[NSDate date] withSubjectID:rowSubject.SubjectID ViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
        funktionenTermineDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        funktionenTermineDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        funktionenTermineDetail.delegate = self;
        [self presentViewController:funktionenTermineDetail animated:YES completion:NULL];
    }
    
    
    
    if (indexPath.section == 5 && indexPath.row != 0 && indexPath.row < [[rowSubject NotizenWithViewingPerson:viewingPerson] count]+1) {
        if (funktionenNotizDetail == nil) funktionenNotizDetail = [[FunktionenNotizDetail alloc] init];
        int notizIndex = (int)[viewingPerson.Notizen indexOfObject:[[rowSubject NotizenWithViewingPerson:viewingPerson] objectAtIndex:(int)indexPath.row-1]];
        [funktionenNotizDetail reloadWithNotiz:[[rowSubject NotizenWithViewingPerson:viewingPerson] objectAtIndex:indexPath.row-1] andIndex:notizIndex andWeek:viewingWeek AndPerson:viewingPerson AndViewingIndex:viewingIndex];
        funktionenNotizDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        funktionenNotizDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        funktionenNotizDetail.delegate = self;
        [self presentViewController:funktionenNotizDetail animated:YES completion:NULL];
    }
    else if (indexPath.section == 5 && indexPath.row != 0 && indexPath.row == [[rowSubject NotizenWithViewingPerson:viewingPerson] count]+1) {
        if (funktionenNotizDetail == nil) funktionenNotizDetail = [[FunktionenNotizDetail alloc] init];
        [funktionenNotizDetail reloadWithNewNotizInWeek:viewingWeek AndPerson:viewingPerson AndViewingIndex:viewingIndex andSubjectID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID]];
        funktionenNotizDetail.modalPresentationStyle = UIModalPresentationFormSheet;
        funktionenNotizDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        funktionenNotizDetail.delegate = self;
        [self presentViewController:funktionenNotizDetail animated:YES completion:NULL];
    }
    
    
    [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([viewingDay.Subjects count] != 0) {
        if (indexPath.section == 0 && indexPath.row == 0) return 50;
        if (indexPath.section == 0 && indexPath.row == 1) return 34;
        if (indexPath.section == 0 && indexPath.row == 2) return 34;
        if (indexPath.section == 1 && indexPath.row != 0) return 34;
        if (indexPath.section == 2 && indexPath.row != 0) return 34;
        if (indexPath.section == 3 && indexPath.row != 0) return 34;
        if (indexPath.section == 4 && indexPath.row != 0) return 34;
        if (indexPath.section == 5 && indexPath.row != 0) return 34;
    }
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        Subject *rowSubject = [Subject clearSubject];
        if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
        [rowSubject.Noten removeObjectAtIndex:indexPath.row-1];
        [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
    }
    else if (indexPath.section == 3) {
        Subject *rowSubject = [Subject clearSubject];
        if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
        [viewingPerson.Homeworks removeObject:[[rowSubject homeworksInPerson:viewingPerson] objectAtIndex:indexPath.row-1]];
        [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
    }
    else if (indexPath.section == 4) {
        Subject *rowSubject = [Subject clearSubject];
        if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
        [viewingPerson.Termine removeObject:[[rowSubject termineInPerson:viewingPerson] objectAtIndex:indexPath.row-1]];
        [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
    }
    else if (indexPath.section == 5) {
        Subject *rowSubject = [Subject clearSubject];
        if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
        
        int notizIndex = (int)[viewingPerson.Notizen indexOfObject:[[rowSubject NotizenWithViewingPerson:viewingPerson] objectAtIndex:indexPath.row-1]];
        [[viewingPerson.Notizen objectAtIndex:notizIndex] prepareDelete];
        [viewingPerson.Notizen removeObjectAtIndex:notizIndex];
        
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
        
        [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    Subject *rowSubject = [Subject clearSubject];
    if (viewingHoure < [viewingDay.Subjects count]) rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:viewingHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:viewingHoure inWeek:viewingWeek];
    if (indexPath.section == 2 && indexPath.row != 0 && indexPath.row < [rowSubject.Noten count]+1) return YES;
    if (indexPath.section == 3 && indexPath.row != 0 && indexPath.row < [[rowSubject homeworksInPerson:viewingPerson] count]+1) return YES;
    if (indexPath.section == 4 && indexPath.row != 0 && indexPath.row < [[rowSubject termineInPerson:viewingPerson] count]+1) return YES;
    if (indexPath.section == 5 && indexPath.row != 0 && indexPath.row < [[rowSubject NotizenWithViewingPerson:viewingPerson] count]+1) return YES;
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}



- (IBAction)changeSegmentedControl:(id)sender {
    [self reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andDay:DayIndexSegmentedControl.selectedSegmentIndex andHoure:0];
}

@end
