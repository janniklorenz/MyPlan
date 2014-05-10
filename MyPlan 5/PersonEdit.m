//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "PersonEdit.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Person.h"
#import "Subject.h"
#import "MPDate.h"
#import "WeekEditDetail.h"
#import "WeekEditDetail2.h"
#import "Day.h"
#import "FachEdit.h"
#import "AppData.h"

@interface PersonEdit ()

@end

@implementation PersonEdit

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[PersonEdit alloc] initWithNibName:@"PersonEdit_iPhone" bundle:nil];
    else self = [[PersonEdit alloc] initWithNibName:@"PersonEdit_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// ------------- Prepare ------------
- (void)prepareForNewPerson {
    navBar.topItem.title = @"Person erstellen";
    editingPerson = [Person newPersonWithName:@"Neue Person"];
    newPerson = YES;
    [table reloadData];
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
- (void)prepareForPersonEditWithWeekIndex:(int)index {
    NSMutableArray *Weeks = [MainData LoadMain];
    editingPerson = [Weeks objectAtIndex:index];
    editingPersonIndex = index;
    newPerson = NO;
    navBar.topItem.title = editingPerson.PersonName;
    [table reloadData];
    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
// ----------------------------------




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return 2;break; // Name
        case 1:return 1;break; // iCloud
        case 2:return [editingPerson.Subjects count]+2;break; // Fächer
        case 3:// Fertig
            if (newPerson) return 0;
            else return 1;break;
        default:break;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // Name
        if (indexPath.row == 0) {
            MainTableFile *MainTableCell = [MainData getCellType:1];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            MainTableCell.textField.placeholder = @"Name";
            MainTableCell.textField.text = editingPerson.PersonName;
            return MainTableCell;
        }
        else if (indexPath.row == 1) {
            MainTableFile5 *MainTableCell = [MainData getCellType:5];
            MainTableCell.backgroundView = [MainData getViewType:6];
            MainTableCell.textView.text = @"zum bearbeiten klicken";
            return MainTableCell;
        }
    }
    else if (indexPath.section == 1) { // iCloud
        MainTableFile4 *MainTableCell = [MainData getCellType:4];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.tableSwitch.on = editingPerson.PersoniCloudON;
        MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
        MainTableCell.textLabel.text = @"iCloud:";
        return MainTableCell;
    }
    else if (indexPath.section == 2) { // Fächer
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            MainTableCell.custumTextLabel1.text = @"Fächer";
            return MainTableCell;
        }
        else {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            if (indexPath.row - 1 == [editingPerson.Subjects count]) {
                MainTableCell.custumTextLabel1.text = @"Neues Fach";
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_5.png"];
                MainTableCell.backgroundView = [MainData getViewType:4];
            }
            else {
                MainTableCell.custumTextLabel1.text = [[editingPerson.Subjects objectAtIndex:indexPath.row-1] SubjectNameAndShort];
                MainTableCell.backgroundView = [MainData getViewWithColor:[[editingPerson.Subjects objectAtIndex:indexPath.row-1] SubjectColor]];
                MainTableCell.custumTextLabel1.textColor = [MainData getTextColorForBackgroundColor:[[editingPerson.Subjects objectAtIndex:indexPath.row-1] SubjectColor]];
            }
            return MainTableCell;
        }
    }
    else if (indexPath.section == 3) { // Fertig
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:3];
        MainTableCell.custumTextLabel1.textColor = [UIColor whiteColor];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.backgroundView = [MainData getViewType:5];
        MainTableCell.custumTextLabel1.text = @"Person löschen";
        return MainTableCell;
    }
    return 0;
}

- (void)changesSwitchTo:(BOOL)switchValue inIndexPath:(NSIndexPath *)ipath {
    if (ipath.section == 1 && ipath.row == 0) editingPerson.PersoniCloudON = switchValue;
}

- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row != 0) {
        if (fachEdit == nil) fachEdit = [[FachEdit alloc] init];
        if (indexPath.row - 1 == [editingPerson.Subjects count]) [fachEdit reloadWithNew];
        else [fachEdit reloadWithFach:[editingPerson.Subjects objectAtIndex:indexPath.row-1] atIndex:(int)indexPath.row-1];
        fachEdit.delegate = self;
        fachEdit.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        fachEdit.modalPresentationStyle = UIModalPresentationFormSheet;
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:fachEdit];
        navController.navigationBar.tintColor = [UIColor blackColor];
        navController.navigationBar.opaque = YES;
        navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:navController animated:YES completion:NULL];
    }
    else if (indexPath.section == 3 && indexPath.row == 0) {
        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"Person löschen" otherButtonTitles:nil];
        really.tag = 2;
        [really showInView:self.view];
    }
    [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0) return 34;
    else if (indexPath.section == 2 && indexPath.row != 0) return 34;
    else if (indexPath.section == 3 && indexPath.row == 1) return 34;
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)typeText:(NSString *)text index:(NSIndexPath *)index {
    if (index.section == 0 && index.row == 0) editingPerson.PersonName = text;
}
- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    if (index.section == 0 && index.row == 0) editingPerson.PersonName = string;
}
- (void)keyboardVisible:(BOOL)visible {
    
}
- (void)startTypingAtIndexPath:(NSIndexPath *)indexp {
    
}



- (void)didEndEditingWithNewSubject:(Subject *)returnSubject {
    [editingPerson.Subjects addObject:returnSubject];
    [table reloadData];
}
- (void)didEndEditingWithSubject:(Subject *)returnSubject atIndex:(int)returnIndex {
    [editingPerson.Subjects removeObjectAtIndex:returnIndex];
    [editingPerson.Subjects insertObject:returnSubject atIndex:returnIndex];
    [table reloadData];
}
- (void)didEndWithDeleteAtIndex:(int)returnIndex {
    [editingPerson.Subjects removeObjectAtIndex:returnIndex];
    
    AppData *appData = [MainData LoadAppData];
    NSMutableArray *Persons = [MainData LoadMain];
    appData.selectedPersonID = [[Persons objectAtIndex:0] PersonID];
    [MainData SaveAppData:appData];
}


// ---------- Cancel Edit ----------
- (IBAction)done:(id)sender {
    if (newPerson) {
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons addObject:editingPerson];
        [MainData SaveMain:Persons];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:editingPersonIndex];
        [Persons insertObject:editingPerson atIndex:editingPersonIndex];
        [MainData SaveMain:Persons];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (IBAction)cancel:(id)sender {
    UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"Änderungen verwerfen" otherButtonTitles:nil];
    really.tag = 10;
    [really showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 10 && buttonIndex == 0) [self dismissViewControllerAnimated:YES completion:NULL];
    else if (actionSheet.tag == 2 && buttonIndex == 0) {
        [self.delegate didDeletePersonAtIndex:editingPersonIndex];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
// ---------------------------------




@end
