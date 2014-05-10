//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "SubVertretung.h"
#import "Person.h"
#import "Subject.h"
#import "MainData.h"
#import "MainTableFile2.h"
#import "MainTableFile8.h"
#import "MainTableFile11.h"
#import "SubjectCell1.h"
#import "Vertretung.h"
#import "Info.h"
#import "Week.h"
#import "Day.h"
#import "Houre.h"
#import "MPDate.h"

@interface SubVertretung ()

@end

@implementation SubVertretung

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[SubVertretung alloc] initWithNibName:@"SubVertretung_iPhone" bundle:nil];
    else self = [[SubVertretung alloc] initWithNibName:@"SubVertretung_iPad" bundle:nil];
    return self;
}




- (void)reloadWithVertretung:(Vertretung *)newVertretung andIndex:(int)newEditingIndex andWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex {
    viewingIndex = newVingingIndex;
    editingVertretung = newVertretung;
    editingVertretungIndex = newEditingIndex;
    viewingWeek = newWeek;
    viewingPerson = newPerson;
    
    self.title = editingVertretung.VertretungsName;
    
    isNew = NO;
    
    [table reloadData];
}

- (void)reloadWithNewVertretungAndWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex {
    viewingIndex = newVingingIndex;
    viewingWeek = newWeek;
    viewingPerson = newPerson;
    
    editingVertretung = [Vertretung newVertretung];
    isNew = YES;
    
    self.title = @"Neue Vertretung";
    
    [table reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Abbrechen" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Speichern" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    }
}

- (void)keyboardWillHide:(NSNotification *)n {
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = table.frame;
    viewFrame.size.height += (keyboardSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [table setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n {
    if (keyboardIsShown) return;
    
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = table.frame;
    viewFrame.size.height -= (keyboardSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [table setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) return UIInterfaceOrientationMaskPortrait;
    return UIInterfaceOrientationMaskAll;
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isNew) return 2;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isNew) {
        switch (section) {
            case 0:return [[[viewingWeek.WeekDurationNames objectAtIndex:[MainData dayIndexForDate:editingVertretung.VertretungsDatum]] Subjects] count] + 1;break;
            case 1:return [editingVertretung.VertretungInfos count]+2;break;
            default:
                break;
        }
    }
    else {
        switch (section) {
            case 0:return 1;break;
            case 1:return [editingVertretung.VertretungInfos count]+2;break;
            case 2:return 1;break;
            default:
                break;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isNew) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                MainTableFile11 *MainTableCell = [MainData getCellType:11];
                MainTableCell.delegate = self;
                [MainTableCell setToDate:editingVertretung.VertretungsDatum];
                MainTableCell.backgroundView = [MainData getViewType:0];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                return MainTableCell;
            }
            else {
                MainTableFile8 *MainTableCell = [MainData getCellType:8];
                Day *viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:[MainData dayIndexForDate:editingVertretung.VertretungsDatum]];
                Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:indexPath.row-1] HoureSubjectID] onDate:[MainData dateForDayIndex:[MainData dayIndexForDate:editingVertretung.VertretungsDatum]] andHoure:(int)indexPath.row-1 inWeek:viewingWeek];
                
                if ([rowSubject.SubjectID isEqualToString:editingVertretung.SubjectID] && indexPath.row-1 == editingVertretung.SubjectHoureIndex) MainTableCell.accessoryType = UITableViewCellAccessoryCheckmark;
                
                MainTableCell.backgroundView = [MainData getViewWithColor:rowSubject.SubjectColor];
                MainTableCell.NameLabel.text = [NSString stringWithFormat:@"%li. %@", (long)indexPath.row, rowSubject.SubjectName];
                MainTableCell.InfoLabel.text = [[viewingWeek getDateForDay:[MainData dayIndexForDate:editingVertretung.VertretungsDatum] andHoure:(int)indexPath.row-1] getTime];
                MainTableCell.NameLabel.enabled = NO;
                MainTableCell.InfoLabel.enabled = NO;
                MainTableCell.NameLabel.placeholder = @"";
                MainTableCell.InfoLabel.placeholder = @"";
                MainTableCell.NameLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                MainTableCell.InfoLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                return MainTableCell;
            }
            
            
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:0];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumTextLabel1.text = @"Infos";
                return MainTableCell;
            }
            else if (indexPath.row - 1 == [editingVertretung.VertretungInfos count]) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumTextLabel1.text = @"Neue Information";
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_5.png"];
                return MainTableCell;
            }
            else {
                MainTableFile8 *MainTableCell = [MainData getCellType:8];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.NameLabel.text = [[editingVertretung.VertretungInfos objectAtIndex:indexPath.row-1] InfoName];
                MainTableCell.InfoLabel.text = [[editingVertretung.VertretungInfos objectAtIndex:indexPath.row-1] getInfoForDay:0];
                MainTableCell.delegate = self;
                MainTableCell.NameLabel.enabled = NO;
                MainTableCell.indexPath = indexPath;
                return MainTableCell;
            }
        }
    }
    else {
        if (indexPath.section == 0 && indexPath.row == 0) {
            MainTableFile11 *MainTableCell = [MainData getCellType:11];
            MainTableCell.delegate = self;
            [MainTableCell setToDate:editingVertretung.VertretungsDatum];
            MainTableCell.stepper.enabled = NO;
            MainTableCell.stepper.hidden = YES;
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            return MainTableCell;
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:0];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumTextLabel1.text = @"Infos";
                return MainTableCell;
            }
            else if (indexPath.row - 1 == [editingVertretung.VertretungInfos count]) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.custumTextLabel1.text = @"Neue Information";
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_5.png"];
                return MainTableCell;
            }
            else {
                MainTableFile8 *MainTableCell = [MainData getCellType:8];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.NameLabel.text = [[editingVertretung.VertretungInfos objectAtIndex:indexPath.row-1] InfoName];
                MainTableCell.InfoLabel.text = [[editingVertretung.VertretungInfos objectAtIndex:indexPath.row-1] getInfoForDay:0];
                MainTableCell.delegate = self;
                MainTableCell.NameLabel.enabled = NO;
                MainTableCell.indexPath = indexPath;
                return MainTableCell;
            }
        }
        else if (indexPath.section == 2) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:5];
            MainTableCell.selectedBackgroundView = [MainData getViewType:5];
            MainTableCell.custumTextLabel1.textColor = [UIColor whiteColor];
            MainTableCell.custumTextLabel1.highlightedTextColor = [UIColor whiteColor];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.custumTextLabel1.text = @"Vertretung löschen";
            return MainTableCell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isNew) {
        if (indexPath.section == 0 && indexPath.row != 0) {
            Day *viewingDay = [viewingWeek.WeekDurationNames objectAtIndex:[MainData dayIndexForDate:editingVertretung.VertretungsDatum]];
            Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:indexPath.row-1] HoureSubjectID] onDate:[MainData dateForDayIndex:[MainData dayIndexForDate:editingVertretung.VertretungsDatum]] andHoure:(int)indexPath.row-1 inWeek:viewingWeek];
            
            if (rowSubject.isVertretung) {
                [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Vertretung" message:@"Es existiert bereits eine Vertretung für diese Stunde." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else {
                editingVertretung.SubjectID = rowSubject.SubjectID;
                editingVertretung.SubjectHoureIndex = (int)indexPath.row-1;
                editingVertretung.VertretungsName = [NSString stringWithFormat:@"%@ Vertretung", rowSubject.SubjectName];
                self.title = editingVertretung.VertretungsName;
                [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
        }
        else if (indexPath.section == 1 && indexPath.row != 0 && indexPath.row - 1 == [editingVertretung.VertretungInfos count]) {
            [editingVertretung addInfo];
            [table insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        else [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else {
        if (indexPath.section == 1 && indexPath.row != 0 && indexPath.row - 1 == [editingVertretung.VertretungInfos count]) {
            [editingVertretung addInfo];
            [table insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        else if (indexPath.section == 2 && indexPath.row == 0) {
            UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"Vertretung löschen" otherButtonTitles:nil];
            really.tag = 2;
            [really showInView:self.view];
            [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2 && buttonIndex == 0) {
        [viewingPerson deleteVertretungForWeek:viewingWeek atIndex:editingVertretungIndex];
      
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
        
        [self.delegate didDeleteVertretungAtIndex:editingVertretungIndex];
        [self.delegate viewWillAppear:YES];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isNew) {
        if (indexPath.section == 0 && indexPath.row != 0) return 34;
        if (indexPath.section == 1 && indexPath.row != 0) return 34;
    }
    else {
        if (indexPath.section == 1 && indexPath.row != 0) return 34;
    }
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [editingVertretung.VertretungInfos removeObjectAtIndex:indexPath.row-1];
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isNew) {
        if (indexPath.section == 1 && indexPath.row != 0 && indexPath.row - 1 != [editingVertretung.VertretungInfos count]) return YES;
    }
    else {
        if (indexPath.section == 1 && indexPath.row != 0 && indexPath.row - 1 != [editingVertretung.VertretungInfos count]) return YES;
    }
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)didSelectButton:(int)buttonIndex andIndex:(NSIndexPath *)indexPath {
    
}



- (void)valueChangedToDate:(NSDate *)dateChange atIndex:(NSIndexPath *)index {
    editingVertretung.VertretungsDatum = dateChange;
    
    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}




- (void)typeName:(NSString *)name index:(NSIndexPath *)index {
    [[editingVertretung.VertretungInfos objectAtIndex:index.row-1] changeNameTo:name];
}
- (void)typeInfo:(NSString *)info index:(NSIndexPath *)index {
    [[editingVertretung.VertretungInfos objectAtIndex:index.row-1] changeInfoTo:info];
}
- (void)didEndNameAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    [table resignFirstResponder];
}
- (void)didEndInfoAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    [table resignFirstResponder];
}
- (void)didStartNameAtIndex:(NSIndexPath *)indexp {
    [table scrollToRowAtIndexPath:indexp atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (void)didStartInfoAtIndex:(NSIndexPath *)indexp {
    [table scrollToRowAtIndexPath:indexp atScrollPosition:UITableViewScrollPositionTop animated:YES];
}






- (void)done:(id)sender {
    if ([editingVertretung.SubjectID isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Keine Verknüpfung" message:@"Sie habe die Vertretung mit keinem Fach verknüpft." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (isNew) {
        [self.delegate didCreateVertretung:editingVertretung];
        [[viewingPerson getVertretungenForWeek:viewingWeek] addObject:editingVertretung];
        [self.delegate didCreateVertretung:editingVertretung];
    }
    else {
        [self.delegate didEditVertretung:editingVertretung atIndex:editingVertretungIndex];
        [[viewingPerson getVertretungenForWeek:viewingWeek] removeObjectAtIndex:editingVertretungIndex];
        [[viewingPerson getVertretungenForWeek:viewingWeek] insertObject:editingVertretung atIndex:editingVertretungIndex];
        [self.delegate didEditVertretung:editingVertretung atIndex:editingVertretungIndex];
    }
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
    
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)cancel:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
