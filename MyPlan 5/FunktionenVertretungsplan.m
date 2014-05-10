//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenVertretungsplan.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Week.h"
#import "Subject.h"
#import "MPDate.h"
#import "WeekEditDetail.h"
#import "WeekEditDetail2.h"
#import "Day.h"
#import "Person.h"
#import "Vertretung.h"

@interface FunktionenVertretungsplan ()

@end

@implementation FunktionenVertretungsplan

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenVertretungsplan alloc] initWithNibName:@"FunktionenVertretungsplan_iPhone" bundle:nil];
    else self = [[FunktionenVertretungsplan alloc] initWithNibName:@"FunktionenVertretungsplan_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    self.title = @"Vertretungsplan";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addHoure:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [table addGestureRecognizer:swipe];
}

- (void)swipeBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addHoure:(id)sender {
    if (subVertretung == nil || subVertretungNavController == nil) {
        subVertretung = [[SubVertretung alloc] init];
        subVertretung.delegate = self;
        subVertretungNavController = [[UINavigationController alloc] initWithRootViewController:subVertretung];
        subVertretungNavController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    }
    [subVertretung reloadWithNewVertretungAndWeek:viewingWeek AndPerson:viewingPerson AndViewingIndex:viewingIndex];
    subVertretungNavController.modalPresentationStyle = UIModalPresentationFormSheet;
    subVertretungNavController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:subVertretungNavController animated:YES completion:NULL];
}

- (void)reloadVertretungen {
    VertretungenOrderd = [NSMutableArray arrayWithObjects:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, dd.MM.yyyy"];
    for (int i = 0; i < [[viewingPerson getVertretungenForWeek:viewingWeek] count]; i++) {
        
        BOOL Found = NO;
        int FoundIndex = 0;
        int ii;
        for (ii = 0; ii < [VertretungenOrderd count] && Found == NO; ii++) {
            NSString *stringFromDate = [formatter stringFromDate:[MainData dayDateForDate:[[[viewingPerson getVertretungenForWeek:viewingWeek] objectAtIndex:i] VertretungsDatum]]];
            
            if ([stringFromDate isEqual:[[VertretungenOrderd objectAtIndex:ii] objectAtIndex:0]]) {
                Found = YES;
                FoundIndex = ii;
            }
        }
        if (Found) {
            [[VertretungenOrderd objectAtIndex:FoundIndex] addObject:[[viewingPerson getVertretungenForWeek:viewingWeek] objectAtIndex:i]];
        }
        else {
            NSString *stringFromDate = [formatter stringFromDate:[MainData dayDateForDate:[[[viewingPerson getVertretungenForWeek:viewingWeek] objectAtIndex:i] VertretungsDatum]]];
            NSMutableArray *VertretungsDay = [NSMutableArray arrayWithObjects:
                                              stringFromDate,
                                              [[viewingPerson getVertretungenForWeek:viewingWeek] objectAtIndex:i], nil];
            [VertretungenOrderd addObject:VertretungsDay];
        }
    }
    [table reloadData];
}

- (void)didCreateVertretung:(Vertretung *)newVertretung {
    [self reloadVertretungen];
}
- (void)didEditVertretung:(Vertretung *)editVertetung atIndex:(int)editungIndex {
    [self reloadVertretungen];
}
- (void)didDeleteVertretungAtIndex:(int)editungIndex {
    [self reloadVertretungen];
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    [self reloadVertretungen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    
    [self reloadVertretungen];
        
    [table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([VertretungenOrderd count] == 0) return 0;
    return [VertretungenOrderd count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < [VertretungenOrderd count]) return [[VertretungenOrderd objectAtIndex:section] count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < [VertretungenOrderd count]) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.delegate = self;
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"%@", [[VertretungenOrderd objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_17.png"];
            return MainTableCell;
        }
        else {
            MainTableFile8 *MainTableCell = [MainData getCellType:8];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.NameLabel.text = [[[VertretungenOrderd objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] VertretungsName];
            MainTableCell.InfoLabel.text = [NSString stringWithFormat:@"%i. Stunde", [[[VertretungenOrderd objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] SubjectHoureIndex]+1];
            MainTableCell.NameLabel.enabled = NO;
            MainTableCell.InfoLabel.enabled = NO;
            MainTableCell.NameLabel.placeholder = @"";
            MainTableCell.InfoLabel.placeholder = @"";
            return MainTableCell;
        }
    }
    else if (indexPath.section == [VertretungenOrderd count]) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.delegate = self;
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_18.png"];
        MainTableCell.custumTextLabel1.text = @"Alle Vertretungen löschen";
        return MainTableCell;
    }
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < [VertretungenOrderd count] && indexPath.row != 0) {
        if (subVertretung == nil || subVertretungNavController == nil) {
            subVertretung = [[SubVertretung alloc] init];
            subVertretung.delegate = self;
            subVertretungNavController = [[UINavigationController alloc] initWithRootViewController:subVertretung];
            subVertretungNavController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        }
        [subVertretung reloadWithVertretung:[[VertretungenOrderd objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] andIndex:(int)indexPath.row-1 andWeek:viewingWeek AndPerson:viewingPerson AndViewingIndex:viewingIndex];
        subVertretungNavController.modalPresentationStyle = UIModalPresentationFormSheet;
        subVertretungNavController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
       [self presentViewController:subVertretungNavController animated:YES completion:NULL];
    }
    else if (indexPath.section == [VertretungenOrderd count]) {
        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"alle Vertretung löschen" otherButtonTitles:nil];
        really.tag = 2;
        [really showInView:self.view];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2 && buttonIndex == 0) {
        [viewingWeek setVertretungen:[NSMutableArray arrayWithObjects:nil]];
        
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
        
        [self reloadVertretungen];
    }
}




- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < [VertretungenOrderd count] && indexPath.row != 0) {
        [[viewingPerson getVertretungenForWeek:viewingWeek] removeObject:[[VertretungenOrderd objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
        [self reloadVertretungen];
        [table reloadData];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < [VertretungenOrderd count] && indexPath.row != 0) return YES;
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < [VertretungenOrderd count] && indexPath.row != 0) return 34;
    return 44;
}



@end
