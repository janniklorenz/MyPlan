//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenNotizen.h"
#import "CVCell.h"
#import "CVCell2.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Week.h"
#import "Subject.h"
#import "MPDate.h"
#import "MPTapGestureRecognizer.h"
#import "FunktionenNotizDetail.h"
#import "Day.h"
#import "Person.h"
#import "HTMLObject.h"
#import "Houre.h"
#import "Note.h"
#import "Homework.h"
#import "Termin.h"
#import "Note.h"
#import "Notiz.h"
#import "MPPictureView.h"
#import "MainTableFile2.h"

@interface FunktionenNotizen ()

@end

@implementation FunktionenNotizen

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenNotizen alloc] initWithNibName:@"FunktionenNotizen_iPhone" bundle:nil];
    else self = [[FunktionenNotizen alloc] initWithNibName:@"FunktionenNotizen_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    self.title = @"Notizen";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNotiz:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [table addGestureRecognizer:swipe];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)swipeBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)orientationChanged:(NSNotification *)notification {
    [table reloadData];
    [table resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    
    [self reloadTable];
}

- (void)reloadTable {
    IDs = [NSMutableArray arrayWithObjects:nil];
    dataArray = [NSMutableArray arrayWithObjects:nil];
    clearDataArray = [NSMutableArray arrayWithObjects:nil];
    
    for (int i = 0; i < [viewingPerson.Notizen count]; i++) {
        if ([[[viewingPerson.Notizen objectAtIndex:i] ConnectedSubjectID] isEqualToString:@""]) {
            [clearDataArray addObject:[viewingPerson.Notizen objectAtIndex:i]];
        }
        else {
            if ([IDs indexOfObject:[[viewingPerson.Notizen objectAtIndex:i] ConnectedSubjectID]] < [IDs count]) {
                // Add to group
                [[dataArray objectAtIndex:[IDs indexOfObject:[[viewingPerson.Notizen objectAtIndex:i] ConnectedSubjectID]]] addObject:[viewingPerson.Notizen objectAtIndex:i]];
            }
            else {
                // Add Group
                [dataArray addObject:[NSMutableArray arrayWithObjects:[viewingPerson.Notizen objectAtIndex:i], nil]];
                [IDs addObject:[[viewingPerson.Notizen objectAtIndex:i] ConnectedSubjectID]];
            }
        }
    }
    [table reloadData];
}



- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    
    
    
    [table reloadData];
}


- (void)addNotiz:(id)sender {
    if (funktionenNotizDetail == nil) funktionenNotizDetail = [[FunktionenNotizDetail alloc] init];
    funktionenNotizDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    funktionenNotizDetail.modalPresentationStyle = UIModalPresentationFormSheet;
    [funktionenNotizDetail reloadWithNewNotizInWeek:viewingWeek AndPerson:viewingPerson AndViewingIndex:viewingIndex];
    [self presentViewController:funktionenNotizDetail animated:YES completion:NULL];
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < [dataArray count]) return [[dataArray objectAtIndex:section] count]+1;
    else {
        if ([clearDataArray count] > 0) return [clearDataArray count]+1;
        else return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < [dataArray count]) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.delegate = self;
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"%@", [[viewingPerson getSubjectForID:[IDs objectAtIndex:indexPath.section]] SubjectNameAndShort]];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_25.png"];
            return MainTableCell;
        }
        else {
            MainTableFile8 *MainTableCell = [MainData getCellType:8];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.NameLabel.text = [[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row-1] NotizName];
            MainTableCell.InfoLabel.text = [[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row-1] getRest];
            MainTableCell.NameLabel.enabled = NO;
            MainTableCell.InfoLabel.enabled = NO;
            MainTableCell.NameLabel.placeholder = @"";
            MainTableCell.InfoLabel.placeholder = @"";
            return MainTableCell;
        }
    }
    else {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.delegate = self;
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = @"Sonstige Notizen";
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_25.png"];
            return MainTableCell;
        }
        else {
            MainTableFile8 *MainTableCell = [MainData getCellType:8];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.NameLabel.text = [[clearDataArray objectAtIndex:indexPath.row-1] NotizName];
            MainTableCell.InfoLabel.text = [[clearDataArray objectAtIndex:indexPath.row-1] getRest];
            MainTableCell.NameLabel.enabled = NO;
            MainTableCell.InfoLabel.enabled = NO;
            MainTableCell.NameLabel.placeholder = @"";
            MainTableCell.InfoLabel.placeholder = @"";
            return MainTableCell;
        }
    }
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int personIndex = 0;
    if (indexPath.section < [dataArray count]) personIndex = (int)[viewingPerson.Notizen indexOfObject:[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row-1]];
    else personIndex = (int)[viewingPerson.Notizen indexOfObject:[clearDataArray objectAtIndex:indexPath.row-1]];
    
    if (funktionenNotizDetail == nil) funktionenNotizDetail = [[FunktionenNotizDetail alloc] init];
    funktionenNotizDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    funktionenNotizDetail.modalPresentationStyle = UIModalPresentationFormSheet;
    [funktionenNotizDetail reloadWithNotiz:[viewingPerson.Notizen objectAtIndex:personIndex] andIndex:personIndex andWeek:viewingWeek AndPerson:viewingPerson AndViewingIndex:viewingIndex];
    [self presentViewController:funktionenNotizDetail animated:YES completion:NULL];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int personIndex = 0;
    if (indexPath.section < [dataArray count]) personIndex = (int)[viewingPerson.Notizen indexOfObject:[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row-1]];
    else personIndex = (int)[viewingPerson.Notizen indexOfObject:[clearDataArray objectAtIndex:indexPath.row-1]];
    
    [[viewingPerson.Notizen objectAtIndex:personIndex] prepareDelete];
    [viewingPerson.Notizen removeObjectAtIndex:personIndex];
    
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
    [self reloadTable];
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



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) return 30;
    else return 44;
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}






@end
