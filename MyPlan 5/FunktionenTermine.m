//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenTermine.h"
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
#import "FunktionenTermineDetail.h"
#import "Termin.h"

@interface FunktionenTermine ()

@end

@implementation FunktionenTermine

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenTermine alloc] initWithNibName:@"FunktionenTermine_iPhone" bundle:nil];
    else self = [[FunktionenTermine alloc] initWithNibName:@"FunktionenTermine_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    self.title = @"Termine";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTermin:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    
    // ----- cal
    calendar = 	[[TKCalendarMonthView alloc] init];
	calendar.delegate = self;
	calendar.dataSource = self;
	calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
	[calendarView addSubview:calendar];
	[calendar reload];
//	CalViewSelectedDate = [NSDate date];
//	[self CalViewSelectDate];
    
    // -----
    
    
    
    
    
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [table addGestureRecognizer:swipe];
    
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipe2.direction = UISwipeGestureRecognizerDirectionDown;
    [ipadCalendarFrame addGestureRecognizer:swipe2];
    UISwipeGestureRecognizer *swipe3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipe3.direction = UISwipeGestureRecognizerDirectionDown;
    [calendarView addGestureRecognizer:swipe3];
}

- (void)swipeBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)swipeDown:(id)sender {
    [self changeShown:nil];
}

- (void)orientationChanged:(NSNotification *)notification {
    [self reloadCalFrame];
}


// ----------- cal -------------
#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
    [self reloadContendArray];
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
    [self reloadCalFrame];
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {
    NSMutableArray *dataAdd = [NSMutableArray arrayWithObjects:nil];
    int x = 0;
    while (x < [viewingPerson.Termine count]) {
        NSDate *date = [[viewingPerson.Termine objectAtIndex:x] TerminDate];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd 00:00:00 +0000"];
        NSString *stringFromDate = [formatter stringFromDate:date];
        
        [dataAdd addObject:stringFromDate];
        x++;
    }
    NSArray *data = [NSArray arrayWithArray:dataAdd];
    
    NSMutableArray *marks = [NSMutableArray array];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) fromDate:startDate];
    NSDate *d = [cal dateFromComponents:comp];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    
    while (YES) {
        if ([d compare:lastDate] == NSOrderedDescending) break;
        if ([data containsObject:[d description]]) [marks addObject:[NSNumber numberWithBool:YES]];
        else [marks addObject:[NSNumber numberWithBool:NO]];
        
        d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
    }
    return [NSArray arrayWithArray:marks];
}


- (void)reloadCalFrame {
	[UIView beginAnimations:nil context:nil];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (calendarShown) {
            calendarView.frame = CGRectMake(0, self.view.frame.size.height-calendar.frame.size.height, calendarView.frame.size.width, calendar.frame.size.height);
            toolbar.frame = CGRectMake(toolbar.frame.origin.x, self.view.frame.size.height-toolbar.frame.size.height-calendarView.frame.size.height, toolbar.frame.size.width, toolbar.frame.size.height);
            table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, self.view.frame.size.height-calendar.frame.size.height);
        }
        else {
            calendarView.frame = CGRectMake(0, self.view.frame.size.height, calendarView.frame.size.width, calendarView.frame.size.height);
            toolbar.frame = CGRectMake(toolbar.frame.origin.x, self.view.frame.size.height-toolbar.frame.size.height, toolbar.frame.size.width, toolbar.frame.size.height);
            table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, self.view.frame.size.height);
        }
        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
            calendarView.alpha = 0;
            toolbar.alpha = 0;
            table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, self.view.frame.size.height);
            calendarShown = NO;
            [self reloadContendArray];
        }
        else {
            calendarView.alpha = 1;
            toolbar.alpha = 1;
        }
    }
    else {
        if (calendarShown) {
            ipadCalendarFrame.frame = CGRectMake(0, self.view.frame.size.height-calendar.frame.size.height, ipadCalendarFrame.frame.size.width, calendar.frame.size.height);
            toolbar.frame = CGRectMake(toolbar.frame.origin.x, self.view.frame.size.height-ipadCalendarFrame.frame.size.height, toolbar.frame.size.width, toolbar.frame.size.height);
            table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, self.view.frame.size.height-calendar.frame.size.height);
        }
        else {
            ipadCalendarFrame.frame = CGRectMake(0, self.view.frame.size.height, ipadCalendarFrame.frame.size.width, ipadCalendarFrame.frame.size.height);
            toolbar.frame = CGRectMake(toolbar.frame.origin.x, self.view.frame.size.height-44, toolbar.frame.size.width, toolbar.frame.size.height);
            table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, self.view.frame.size.height);
        }
    }
    
    [UIView setAnimationDuration:0.7];
	[UIView commitAnimations];
}

- (IBAction)changeShown:(id)sender {
    if (calendarShown) {
        calendarShown = NO;
        changeShowItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(changeShown:)];
    }
    else {
        calendarShown = YES;
        changeShowItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(changeShown:)];
    }
    [self reloadContendArray];
    [self reloadCalFrame];
}


// ------------------------------




- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    
    [self reloadContendArray];
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    
    [self reloadCalFrame];
    
    [self reloadContendArray];
}

- (void)addTermin:(id)sender {
    if (funktionenTermineDetail == nil) funktionenTermineDetail = [[FunktionenTermineDetail alloc] init];
    if (calendarShown && [calendar.dateSelected timeIntervalSince1970] > [[NSDate date] timeIntervalSince1970]) [funktionenTermineDetail reloadWithNewTerminOnDate:calendar.dateSelected ViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
    else [funktionenTermineDetail reloadWithNewTerminOnDate:[NSDate date] ViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
    funktionenTermineDetail.delegate = self;
    funktionenTermineDetail.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    funktionenTermineDetail.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:funktionenTermineDetail animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (void)reloadContendArray {
    ContendArray = [NSMutableArray arrayWithObjects:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, dd.MM.yyyy"];
    for (int i = 0; i < [viewingPerson.Termine count]; i++) {
        BOOL Found = NO;
        int FoundIndex = 0;
        int ii;
        for (ii = 0; ii < [ContendArray count] && Found == NO; ii++) {
            NSString *stringFromDate = [formatter stringFromDate:[[viewingPerson.Termine objectAtIndex:i] TerminDate]];
            
            if ([stringFromDate isEqual:[[ContendArray objectAtIndex:ii] objectAtIndex:0]]) {
                Found = YES;
                FoundIndex = ii;
            }
        }
        if (Found) {
            [[ContendArray objectAtIndex:FoundIndex] addObject:[viewingPerson.Termine objectAtIndex:i]];
        }
        else {
            NSString *stringFromDate = [formatter stringFromDate:[[viewingPerson.Termine objectAtIndex:i] TerminDate]];
            if (calendarShown == NO || [stringFromDate isEqualToString:[formatter stringFromDate:calendar.dateSelected]]) {
                NSMutableArray *VertretungsDay = [NSMutableArray arrayWithObjects:
                                                  stringFromDate,
                                                  [viewingPerson.Termine objectAtIndex:i], nil];
                [ContendArray addObject:VertretungsDay];
            }
            
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
    if ([ContendArray count] == 0) return 1;
    if (calendarShown) return [ContendArray count];
    return [ContendArray count]+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([ContendArray count] == 0) return 2;
    if (calendarShown) return [[ContendArray objectAtIndex:section] count];
    if (section == [ContendArray count]) return 1;
    return [[ContendArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [ContendArray count] && calendarShown == NO && [ContendArray count] != 0) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.delegate = self;
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_10.png"];
        MainTableCell.custumTextLabel1.text = @"Alle Termine löschen";
        return MainTableCell;
    }
    else {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_10.png"];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"EEEE, dd.MM.yyyy"];
            if ([ContendArray  count] == 0) MainTableCell.custumTextLabel1.text = [formatter stringFromDate:calendar.dateSelected];
            else MainTableCell.custumTextLabel1.text = [[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return MainTableCell;
        }
        else {
            SubjectCell1 *MainTableCell = [MainData getCellType:101];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            if ([ContendArray  count] == 0) {
                MainTableCell.SubjectNameLabel.text = @"Keine Termine";
                MainTableCell.SubjectTimeLabel.text = @"";
            }
            else {
                MainTableCell.backgroundView = [MainData getViewWithColor:[[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] getColorForPerson:viewingPerson]];
                MainTableCell.SubjectNameLabel.textColor = [MainData getTextColorForBackgroundColor:[[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] getColorForPerson:viewingPerson]];
                MainTableCell.SubjectTimeLabel.textColor = [MainData getTextColorForBackgroundColor:[[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] getColorForPerson:viewingPerson]];
                MainTableCell.SubjectNameLabel.text = [[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] TerminName];
                MainTableCell.SubjectTimeLabel.text = [[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] time];
            }
            return MainTableCell;
        }
    }
}
- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == [ContendArray count] && calendarShown == NO && [ContendArray count] != 0) {
        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"alle Termine löschen" otherButtonTitles:nil];
        really.tag = 2;
        [really showInView:self.view];
    }
    else {
        if ([ContendArray count] != 0) {
            if (indexPath.row == 0) {
                calendarShown = YES;
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"EEEE, dd.MM.yyyy"];
                [calendar selectDate:[formatter dateFromString:[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]]];
                [self reloadContendArray];
                [self reloadCalFrame];
            }
            else {
                if (funktionenTermineDetail == nil) funktionenTermineDetail = [[FunktionenTermineDetail alloc] init];
                int index = [viewingPerson.Termine indexOfObject:[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
                [funktionenTermineDetail reloadWithTerminAtIndex:index ViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek];
                funktionenTermineDetail.delegate = self;
                funktionenTermineDetail.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                funktionenTermineDetail.modalPresentationStyle = UIModalPresentationFormSheet;
                [self presentViewController:funktionenTermineDetail animated:YES completion:NULL];
            }
        }
    }
    [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2 && buttonIndex == 0) {
        for (int i = 0; i < [viewingPerson.Termine count]; i++) [[viewingPerson.Termine objectAtIndex:i] prepareDelete];
        [viewingPerson setTermine:[NSMutableArray arrayWithObjects:nil]];
        
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
        
        [self reloadContendArray];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) return 34;
    return 44;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = [viewingPerson.Termine indexOfObject:[[ContendArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    [[viewingPerson.Termine objectAtIndex:index] prepareDelete];
    [viewingPerson.Termine removeObjectAtIndex:index];
    [self reloadContendArray];
    [table reloadData];
    
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
    if (indexPath.section == 0 && indexPath.row != 0) return YES;
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


@end
