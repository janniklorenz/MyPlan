//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "ViewTag.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import "MainTableFile8.h"
#import "MainTableFile12.h"
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
#import "Houre.h"
#import "Info.h"
#import "ViewJetzt.h"
#import "MPTapGestureRecognizer.h"

@interface ViewTag ()

@end

@implementation ViewTag

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[ViewTag alloc] initWithNibName:@"ViewTag_iPhone" bundle:nil];
    else self = [[ViewTag alloc] initWithNibName:@"ViewTag_iPad" bundle:nil];
    return self;
}

- (void)viewDidLoad {    
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeL.direction = UISwipeGestureRecognizerDirectionRight;
    [table addGestureRecognizer:swipeL];
    UISwipeGestureRecognizer *swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeR.direction = UISwipeGestureRecognizerDirectionLeft;
    [table addGestureRecognizer:swipeR];
    
    UISwipeGestureRecognizer *swipeBack = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    swipeBack.direction = UISwipeGestureRecognizerDirectionRight;
    swipeBack.numberOfTouchesRequired = 2;
    [table addGestureRecognizer:swipeBack];
    
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(doTimer:) userInfo:nil repeats:YES];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [super viewDidLoad];
    
}

- (void)orientationChanged:(NSNotification *)notification {
    [table reloadData];
}

- (void)swipeLeft:(id)sender {
    if (DayIndex == 0) DayIndex = (int)[viewingWeek.WeekDurationNames count]-1;
    else DayIndex--;
    [self reloadTitle];
    DayIndexSegmentedControl.selectedSegmentIndex = DayIndex;
    viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:DayIndex];
    
    if (DayIndex == [MainData dayIndex]) {
        [self reloadTodayArray];
    }
    
    [table reloadData]; // Del maybe
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
}
- (void)swipeRight:(id)sender {
    if (DayIndex ==  [viewingWeek.WeekDurationNames count]-1) DayIndex = 0;
    else DayIndex++;
    [self reloadTitle];
    DayIndexSegmentedControl.selectedSegmentIndex = DayIndex;
    viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:DayIndex];
    
    if (DayIndex == [MainData dayIndex]) {
        [self reloadTodayArray];
    }

    [table reloadData]; // Del maybe
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
}
- (void)swipeBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    
    [self reloadTitle];
    
    if (DayIndex == [MainData dayIndex]) [self reloadTodayArray];
    [table reloadData];
    DayIndexSegmentedControl.selectedSegmentIndex = DayIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)reloadTitle {
    WeekDays = [NSMutableArray arrayWithObjects:@"Montag", @"Dienstag", @"Mittwoch", @"Donnerstag", @"Freitag", @"Samstag", @"Sonntag", nil];
    
    if (DayIndex == [MainData dayIndex]) self.title = @"Heute";
    else self.title = [WeekDays objectAtIndex:DayIndex];
}


- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    DayIndex = [MainData dayIndex];
    DayIndexSegmentedControl.selectedSegmentIndex = DayIndex;
    viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:DayIndex];
    if (DayIndex == [MainData dayIndex]) [self reloadTodayArray];
    [table reloadData];
}

- (IBAction)ChangDayIndex:(id)sender {
    int old = DayIndex;
    DayIndex = (int)DayIndexSegmentedControl.selectedSegmentIndex;
    viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:DayIndex];
    if (DayIndex == [MainData dayIndex]) {
        [self reloadTodayArray];
    }
    [self reloadTitle];
    
    [table reloadData];
    if (old < DayIndex) [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    else [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
}

- (void)doTimer:(id)sender {
    if (DayIndex == [MainData dayIndex]) [self reloadTodayArray];
}

- (void)reloadTodayArray {
    NSMutableArray *old = [TodayArray copy];
    TodayArray = [NSMutableArray arrayWithObjects:[NSMutableArray arrayWithObjects:nil], [NSMutableArray arrayWithObjects:nil], [NSMutableArray arrayWithObjects:nil], nil];
    for (int i = 0; i < [viewingDay.Subjects count]; i++) {
        Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:i] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:i inWeek:viewingWeek];
        MPDate *usedDate = [viewingWeek getDateForDay:DayIndex andHoure:i];
        if (usedDate.isClear) ; // Clear Date
        else if (usedDate.toSec < [MainData daySeconds]) [[TodayArray objectAtIndex:0] addObject:rowSubject];
        else if (usedDate.toSec > [MainData daySeconds] && usedDate.fromSec < [MainData daySeconds]) [[TodayArray objectAtIndex:1] addObject:rowSubject];
        else if (usedDate.fromSec > [MainData daySeconds]) [[TodayArray objectAtIndex:2] addObject:rowSubject];
    }
    if (![old isEqual:TodayArray]) [table reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (DayIndex == [MainData dayIndex]) return [TodayArray count];
    else {
        if (showInfos) return 0;
        else return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (DayIndex == [MainData dayIndex]) {
        if (section == 1) {
            if ([[TodayArray objectAtIndex:1] count] == 0) return 0;
            int x1 = (int)[[TodayArray objectAtIndex:section-1] count]-1;
            if (x1 == [[TodayArray objectAtIndex:section-1] count]) x1 = 0;
            int fromHoure = x1 + 1;
            Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:fromHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:fromHoure inWeek:viewingWeek];
            return [rowSubject.Infos count];
        }
        return [[TodayArray objectAtIndex:section] count];
    }
    else {
        if (showInfos) return 0;
        else return [viewingDay.Subjects count];
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (DayIndex == [MainData dayIndex]) {
        if (indexPath.section == 1) {
            int x1 = (int)[[TodayArray objectAtIndex:indexPath.section-1] count]-1;
            if (x1 == [[TodayArray objectAtIndex:indexPath.section-1] count]) x1 = 0;
            
            int fromHoure = x1 + 1;
            Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:fromHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:fromHoure inWeek:viewingWeek];
            
            MainTableFile8 *MainTableCell = [MainData getCellType:8];
            MainTableCell.backgroundView = [MainData getViewType:4];
            
            MainTableCell.NameLabel.text = [[rowSubject.Infos objectAtIndex:indexPath.row] InfoName];
            MainTableCell.InfoLabel.text = [[rowSubject.Infos objectAtIndex:indexPath.row] getInfoForDay:DayIndex];
            MainTableCell.NameLabel.enabled = NO;
            MainTableCell.InfoLabel.enabled = NO;// maybe enable for changing things
            
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            
            return MainTableCell;
        }
        else {
            SubjectCell1 *MainTableCell = [MainData getCellType:101];
            Subject *rowSubject = [[TodayArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            int realHoure = 0;
            switch (indexPath.section) {
                case 0:realHoure = (int)indexPath.row;break;
                case 1:realHoure = (int)[[TodayArray objectAtIndex:0] count] + (int)indexPath.row;break;
                case 2:realHoure = (int)[[TodayArray objectAtIndex:0] count] + (int)[[TodayArray objectAtIndex:1] count] + (int)indexPath.row;break;
                default:break;
            }
            
            
            if (rowSubject.isVertretung) {
                MainTableFile12 *MainTableCell = [MainData getCellType:12];
                MainTableCell.backgroundView = [MainData getViewWithColor:rowSubject.SubjectColor];
                MainTableCell.textLabel.text = [NSString stringWithFormat:@"%i. %@", realHoure + 1, rowSubject.SubjectName];
                MainTableCell.imgImageView.image = [MainData getVertretungImgForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.textLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.timesLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.timesLabel.text = [[viewingWeek getDateForDay:DayIndex andHoure:realHoure] getTime];
                MainTableCell.subjectBackgroundView.backgroundColor = [UIColor clearColor];
                if (indexPath.row+1 < [viewingDay.Subjects count]) {
                    if ([[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row] toSec] != [[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row+1] fromSec]) {
                        MainTableCell.subjectBackgroundView.backgroundColor = rowSubject.SubjectColor;
                        MainTableCell.backgroundView = [MainData getViewType:6];
                    }
                    
                }
                return MainTableCell;
            }
            else {
                MainTableCell.backgroundView = [MainData getViewWithColor:rowSubject.SubjectColor];
                MainTableCell.SubjectNameLabel.text = [NSString stringWithFormat:@"%i. %@", realHoure + 1, rowSubject.SubjectName];
                MainTableCell.SubjectTimeLabel.text = [[viewingWeek getDateForDay:DayIndex andHoure:realHoure] getTime];
                MainTableCell.SubjectNameLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.SubjectTimeLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.SubjectColorView.backgroundColor = [UIColor clearColor];
                if (indexPath.row+1 < [viewingDay.Subjects count]) {
                    if ([[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row] toSec] != [[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row+1] fromSec]) {
                        MainTableCell.SubjectColorView.backgroundColor = rowSubject.SubjectColor;
                        MainTableCell.backgroundView = [MainData getViewType:6];
                    }
                    
                }
                return MainTableCell;
            }
        }
        
    }
    else {
        if (showInfos) {
            
        }
        else {
            Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:(int)indexPath.row] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:(int)indexPath.row inWeek:viewingWeek];
            
            
            if (rowSubject.isVertretung) {
                MainTableFile12 *MainTableCell = [MainData getCellType:12];
                MainTableCell.backgroundView = [MainData getViewWithColor:rowSubject.SubjectColor];
                MainTableCell.textLabel.text = [NSString stringWithFormat:@"%i. %@", (int)indexPath.row + 1, rowSubject.SubjectName];
                MainTableCell.imgImageView.image = [MainData getVertretungImgForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.textLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.timesLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.timesLabel.text = [[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row] getTime];
                MainTableCell.subjectBackgroundView.backgroundColor = [UIColor clearColor];
                
                if (indexPath.row+1 < [viewingDay.Subjects count]) {
                    if ([[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row] toSec] != [[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row+1] fromSec]) {
                        MainTableCell.subjectBackgroundView.backgroundColor = rowSubject.SubjectColor;
                        MainTableCell.backgroundView = [MainData getViewType:6];
                    }
                    
                }
                
                return MainTableCell;
            }
            else {
                SubjectCell1 *MainTableCell = [MainData getCellType:101];
                MainTableCell.backgroundView = [MainData getViewWithColor:rowSubject.SubjectColor];
                MainTableCell.SubjectNameLabel.text = [NSString stringWithFormat:@"%i. %@", (int)indexPath.row + 1, rowSubject.SubjectName];
                MainTableCell.SubjectTimeLabel.text = [[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row] getTime];
                MainTableCell.SubjectColorView.backgroundColor = [UIColor clearColor];
                
                if (indexPath.row+1 < [viewingDay.Subjects count]) {
                    if ([[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row] toSec] != [[viewingWeek getDateForDay:DayIndex andHoure:(int)indexPath.row+1] fromSec]) {
                        MainTableCell.SubjectColorView.backgroundColor = rowSubject.SubjectColor;
                        MainTableCell.backgroundView = [MainData getViewType:6];
                    }
                    
                }
                
                MainTableCell.SubjectNameLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.SubjectTimeLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                return MainTableCell;
            }
            
            
            
        }
    }
    
    return 0;    
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (viewJetzt == nil) viewJetzt = [[ViewJetzt alloc] init];
    
    if (DayIndex == [MainData dayIndex]) {
        int realHoure = 0;
        switch (indexPath.section) {
            case 0:realHoure = (int)indexPath.row;break;
            case 1:realHoure = (int)[[TodayArray objectAtIndex:0] count];break;
            case 2:realHoure = (int)[[TodayArray objectAtIndex:0] count] + (int)[[TodayArray objectAtIndex:1] count] + (int)indexPath.row;break;
            default:break;
        }
        [viewJetzt reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andDay:DayIndex andHoure:realHoure];
    }
    else {
        [viewJetzt reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andDay:DayIndex andHoure:(int)indexPath.row];
    }
    [self.navigationController pushViewController:viewJetzt animated:YES];
}

- (void)goToNowHoure:(id)sender {
    if (viewJetzt == nil) viewJetzt = [[ViewJetzt alloc] init];
    int realHoure = (int)[[TodayArray objectAtIndex:0] count];
    [viewJetzt reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andDay:DayIndex andHoure:realHoure];
    [self.navigationController pushViewController:viewJetzt animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (DayIndex == [MainData dayIndex] && indexPath.section == 1 && indexPath.row == 0) return 44;
    if (DayIndex == [MainData dayIndex] && indexPath.section == 1) return 34;
    return 44;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (DayIndex == [MainData dayIndex] && [[TodayArray objectAtIndex:section] count] != 0 && section == 1) return 44;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (DayIndex == [MainData dayIndex] && [[TodayArray objectAtIndex:section] count] != 0 && section == 1) {
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)];
        
        UIView *customView2 = [MainData getViewWithColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.15]];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) customView2.frame = CGRectMake(9.0, 0.0, self.view.frame.size.width-18, 44.0);
        else customView2.frame = CGRectMake(44.0, 0.0, self.view.frame.size.width-88, 44.0);
        
        [customView addSubview:customView2];
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.opaque = NO;
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.textAlignment = NSTextAlignmentLeft;
        headerLabel.font = [UIFont fontWithName:@"Helvetica" size:19];
        headerLabel.frame = CGRectMake(10.0, 0.0, (customView2.frame.size.width-20)/2, 44.0);
        [customView2 addSubview:headerLabel];
        
        UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel2.backgroundColor = [UIColor clearColor];
        headerLabel2.opaque = NO;
        headerLabel2.textColor = [UIColor whiteColor];
        headerLabel2.textAlignment = NSTextAlignmentRight;
        headerLabel2.font = [UIFont fontWithName:@"Helvetica" size:18];
        headerLabel2.frame = CGRectMake((customView2.frame.size.width)/2 - 10, 0.0, (customView2.frame.size.width)/2, 44.0);
        [customView2 addSubview:headerLabel2];
        
        UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToNowHoure:)];
        tapRec.numberOfTapsRequired = 1;
        [customView2 addGestureRecognizer:tapRec];
        
        if (section == 0) {
            int fromHoure = 0;
            int toHoure = (int)[[TodayArray objectAtIndex:section] count]-1;
            headerLabel.text = @"Vorbei:";
            headerLabel2.text = [NSString stringWithFormat:@"%@ - %@", [[viewingWeek getDateForDay:DayIndex andHoure:fromHoure] from], [[viewingWeek getDateForDay:DayIndex andHoure:toHoure] to]];
        }
        else if (section == 1) {
            int x1 = (int)[[TodayArray objectAtIndex:section-1] count]-1;
            if (x1 == [[TodayArray objectAtIndex:section-1] count]) x1 = 0;
            
            int fromHoure = x1 + 1;
            Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:fromHoure] HoureSubjectID] onDate:[MainData dateForDayIndex:DayIndex] andHoure:fromHoure inWeek:viewingWeek];
            
            if (rowSubject.isVertretung) headerLabel.text = [NSString stringWithFormat:@"%@ (Vertretung)", rowSubject.SubjectName];
            else headerLabel.text = [NSString stringWithFormat:@"Jetzt: %@", rowSubject.SubjectName];
            headerLabel2.text = [[viewingWeek getDateForDay:DayIndex andHoure:fromHoure] getTime];
            customView2.backgroundColor = rowSubject.SubjectColor;
            headerLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
            headerLabel2.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
        }
        else if (section == 2) {
            
            int x1 = (int)[[TodayArray objectAtIndex:section-1] count]-1;
            if (x1 == [[TodayArray objectAtIndex:section-1] count]) x1 = 0;
            int x2 = (int)[[TodayArray objectAtIndex:section-2] count]-1;
            if (x2 == [[TodayArray objectAtIndex:section-2] count]) x2 = 0;
            
            int fromHoure = x1 + x2 + 2;
            int toHoure = x1 + x2 + (int)[[TodayArray objectAtIndex:section] count] + 1;
            headerLabel.text = @"Verbleiben:";
            headerLabel2.text = [NSString stringWithFormat:@"%@ - %@", [[viewingWeek getDateForDay:DayIndex andHoure:fromHoure] from], [[viewingWeek getDateForDay:DayIndex andHoure:toHoure] to]];
        }
        
        
        return customView;
    }
    return 0;
}


@end
