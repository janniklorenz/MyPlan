//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "SubPlanEditDetail.h"
#import "MainTableFile2.h"
#import "MainTableFile7.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Person.h"
#import "Week.h"
#import "Day.h"
#import "SubAddHoureViewController.h"
#import "Houre.h"
#import "Subject.h"
#import "SubjectCell1.h"
#import "MPDate.h"
#import "MainData.h"

@interface SubPlanEditDetail ()

@end

@implementation SubPlanEditDetail

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[SubPlanEditDetail alloc] initWithNibName:@"SubPlanEditDetail_iPhone" bundle:nil];
    else self = [[SubPlanEditDetail alloc] initWithNibName:@"SubPlanEditDetail_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addHoure:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
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
}

- (void)didSelectSubjectAtIndex:(NSIndexPath *)indexPath {
    [viewingDay addHoureWithSubject:[viewingPerson.Subjects objectAtIndex:indexPath.row] toIndex:subAddHoureViewController.toIndexPath];
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
    
    [self setAddHoure:NO animated:YES];
}
- (void)didSelectFree {
    [viewingDay addHoureWithSubject:[Subject freeSubject] toIndex:subAddHoureViewController.toIndexPath];
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
    
    [self setAddHoure:NO animated:YES];
}


- (void)addHoure:(id)sender {
    if ([viewingDay.Subjects count] == 0) {
        if (subAddHoureViewController == nil) subAddHoureViewController = [[SubAddHoureViewController alloc] init];
        subAddHoureViewController.toIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        subAddHoureViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        subAddHoureViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [subAddHoureViewController reloadWithPerson:viewingPerson];
        subAddHoureViewController.delegate = self;
        [self presentViewController:subAddHoureViewController animated:YES completion:NULL];
    }
    else {
        if (adding == NO) {
            [self setAddHoure:YES animated:YES];
            [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[viewingDay.Subjects count]*2 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        else [self setAddHoure:NO animated:YES];
    }
}
- (void)setAddHoure:(BOOL)toSet animated:(BOOL)anim {
    if (toSet == YES) {
        adding = YES;
        [table setEditing:NO animated:YES];
        [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Abbrechen" style:UIBarButtonItemStyleDone target:self action:@selector(addHoure:)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    else {
        adding = NO;
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addHoure:)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)swipeLeft:(id)sender {
    [self setAddHoure:NO animated:NO];
    if (viewingDayIndex == 0) viewingDayIndex = (int)[viewingWeek.WeekDurationNames count]-1;
    else viewingDayIndex--; 
    [self reloadViewsWithPersonIndex:viewingIndex andDayIndex:viewingDayIndex];
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
}
- (void)swipeRight:(id)sender {
    [self setAddHoure:NO animated:NO];
    if (viewingDayIndex ==  [viewingWeek.WeekDurationNames count]-1) viewingDayIndex = 0;
    else viewingDayIndex++;
    [self reloadViewsWithPersonIndex:viewingIndex andDayIndex:viewingDayIndex];
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
}
- (void)swipeBack:(id)sender {
    [self setAddHoure:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [self setAddHoure:NO animated:NO];
    
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    
    if ([[MainData LoadMain] count] > 0) {
        [self reloadViewsWithPersonIndex:viewingIndex andDayIndex:viewingDayIndex];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)reloadViewsWithPersonIndex:(int)index andDayIndex:(int)dindex {
    viewingIndex = index;
    viewingDayIndex = dindex;
    viewingPerson = [[MainData LoadMain] objectAtIndex:index];
    for (int i = 0; i < [viewingPerson.Weeks count]; i++) {
        if ([[[viewingPerson.Weeks objectAtIndex:i] WeekID] isEqualToString:viewingPerson.selectedWeekID]) {
            viewingWeek = [viewingPerson.Weeks objectAtIndex:i];
        }
    }
    viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:viewingDayIndex];
    self.title = [[viewingWeek.WeekDurationNames objectAtIndex:viewingDayIndex] DayName];
    [table reloadData];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (adding == YES) return [viewingDay.Subjects count]*2+1;
    return [viewingDay.Subjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (adding == NO) {
        SubjectCell1 *MainTableCell = [MainData getCellType:101];
        Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:indexPath.row] HoureSubjectID] onDate:[MainData dateForDayIndex:viewingDayIndex] andHoure:(int)indexPath.row inWeek:viewingWeek];
        MainTableCell.backgroundView = [MainData getViewType:6];
        MainTableCell.SubjectNameLabel.text = [NSString stringWithFormat:@"%i. %@", (int)indexPath.row + 1, rowSubject.SubjectName];
        MainTableCell.SubjectTimeLabel.text = [[viewingWeek getDateForDay:viewingDayIndex andHoure:(int)indexPath.row] getTime];
        MainTableCell.SubjectTimeLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
        MainTableCell.SubjectTimeLabel.highlightedTextColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
        MainTableCell.SubjectNameLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
        MainTableCell.SubjectNameLabel.highlightedTextColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
        MainTableCell.SubjectColorView.backgroundColor = rowSubject.SubjectColor;
        return MainTableCell;
    }
    else {
        int x1 = (int)indexPath.row;
        float x2 = indexPath.row;
        float x3 = x1 / 2;
        if (x3 != x2/2) {
            SubjectCell1 *MainTableCell = [MainData getCellType:101];
            Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:(int)indexPath.row/2] HoureSubjectID] onDate:[MainData dateForDayIndex:viewingDayIndex] andHoure:(int)indexPath.row/2 inWeek:viewingWeek];
            MainTableCell.backgroundView = [MainData getViewType:6];
            MainTableCell.SubjectNameLabel.text = [NSString stringWithFormat:@"%i. %@", (int)indexPath.row/2 + 1, rowSubject.SubjectName];
            MainTableCell.SubjectTimeLabel.text = [[viewingWeek getDateForDay:viewingDayIndex andHoure:(int)indexPath.row] getTime];
            MainTableCell.SubjectColorView.backgroundColor = rowSubject.SubjectColor;
            MainTableCell.SubjectTimeLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
            MainTableCell.SubjectTimeLabel.highlightedTextColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
            MainTableCell.SubjectNameLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
            MainTableCell.SubjectNameLabel.highlightedTextColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
            return MainTableCell;
        }
        else {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:6];
            MainTableCell.selectedBackgroundView = [MainData getViewType:6];
            MainTableCell.custumTextLabel1.textColor = [UIColor whiteColor];
            MainTableCell.custumTextLabel1.highlightedTextColor = [UIColor whiteColor];
            MainTableCell.custumTextLabel1.font = [UIFont systemFontOfSize:16];
            MainTableCell.custumTextLabel1.text = @"Stunde hier hinzufügen";
            return MainTableCell;
        }
    }
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (adding == YES) {
        if (subAddHoureViewController == nil) subAddHoureViewController = [[SubAddHoureViewController alloc] init];
        subAddHoureViewController.toIndexPath = [NSIndexPath indexPathForRow:(indexPath.row+1)/2 inSection:indexPath.section];
        subAddHoureViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        subAddHoureViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [subAddHoureViewController reloadWithPerson:viewingPerson];
        subAddHoureViewController.delegate = self;
        [self presentViewController:subAddHoureViewController animated:YES completion:NULL];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int x1 = (int)indexPath.row;
    float x2 = indexPath.row;
    float x3 = x1 / 2;
    if (adding == NO) return 55;
    else if (adding == YES && x3 == x2/2) return 27;
    else return 55;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [viewingDay.Subjects removeObjectAtIndex:indexPath.row];
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	Houre *movHoure = [viewingDay.Subjects objectAtIndex:fromIndexPath.row];
    [viewingDay.Subjects removeObjectAtIndex:fromIndexPath.row];
    [viewingDay.Subjects insertObject:movHoure atIndex:toIndexPath.row];
    
    [table reloadData];
    
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (adding == NO) return YES;
    else return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (adding == NO) return YES;
    else return NO;
}



- (void)didSelectButton:(int)buttonIndex andIndex:(NSIndexPath *)indexPath {
    
}


- (IBAction)doEditing:(id)sender {
    [self setAddHoure:NO animated:YES];
    if ([editingButton.title isEqualToString:@"Bearbeiten"]) {
        editingButton.title = @"Fertig";
        editingButton.style = UIBarButtonItemStyleDone;
        [table setEditing:YES animated:YES];
    }
    else {
        editingButton.title = @"Bearbeiten";
        editingButton.style = UIBarButtonItemStyleBordered;
        [table setEditing:NO animated:YES];
    }
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}



@end
