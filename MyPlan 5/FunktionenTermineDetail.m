//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenTermineDetail.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import "MainTableFile8.h"
#import "MainTableFile11.h"
#import "MainTableFile13.h"
#import "MainTableFile14.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Week.h"
#import "Subject.h"
#import "MPDate.h"
#import "WeekEditDetail.h"
#import "WeekEditDetail2.h"
#import "Day.h"
#import "Person.h"
#import "Termin.h"
#import "SubAddHoureViewController.h"
#import "MPPictureView.h"
#import "Week.h"
#import "Houre.h"
#import "FunktionenTermineDetailDate.h"

@interface FunktionenTermineDetail ()

@end

@implementation FunktionenTermineDetail

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenTermineDetail alloc] initWithNibName:@"FunktionenTermineDetail_iPhone" bundle:nil];
    else self = [[FunktionenTermineDetail alloc] initWithNibName:@"FunktionenTermineDetail_iPad" bundle:nil];
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    if (isNew) navBar.topItem.title = @"Neuer Termin";
    else navBar.topItem.title = viewingTermin.TerminName;
    
    self.navigationController.navigationBarHidden = YES;
    
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    [table reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadWithNewTerminOnDate:(NSDate *)newDate withSubjectID:(NSString *)newSubjectID ViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    viewingTermin = [Termin newTerminOnDate:newDate];
    viewingTermin.ConnectedSubjectID = newSubjectID;
    
    isNew = YES;
    
    navBar.topItem.title = @"Neuer Termin";
    
    [table reloadData];
}
- (void)reloadWithNewTerminOnDate:(NSDate *)newDate ViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    viewingTermin = [Termin newTerminOnDate:newDate];
    
    isNew = YES;
    
    navBar.topItem.title = @"Neuer Termin";
    
    [table reloadData];
}
- (void)reloadWithTerminAtIndex:(int)terminIndex ViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingTerminIndex = terminIndex;
    viewingWeek = vweek;
    
    viewingTermin = [viewingPerson.Termine objectAtIndex:viewingTerminIndex];
    
    isNew = NO;
    
    navBar.topItem.title = viewingTermin.TerminName;
    
    [table reloadData];
}




- (void)didSelectSubjectAtIndex:(NSIndexPath *)indexPath {
    viewingTermin.ConnectedSubjectID = [[viewingPerson.Subjects objectAtIndex:indexPath.row] SubjectID];
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:2], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)didSelectFree {
    viewingTermin.ConnectedSubjectID = @"";
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:2], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isNew) return 5;
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return 3;break;
        case 1:return 1;break;
        case 2:return 1;break;
        case 3:
            if (viewingTermin.TerminImage != nil) return 2;
            else return 1;break;
        case 4:return 1;break;
        case 5:return 1;break;
        default:break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            MainTableCell.custumTextLabel1.text = @"Infos:";
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_19.png"];
            return MainTableCell;
        }
        else if (indexPath.row == 1) {
            MainTableFile13 *MainTableCell = [MainData getCellType:13];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            MainTableCell.textField.text = viewingTermin.TerminName;
            MainTableCell.textField.placeholder = @"Termin";
            return MainTableCell;
        }
        else if (indexPath.row == 2) {
            MainTableFile5 *MainTableCell = [MainData getCellType:5];
            MainTableCell.backgroundView = [MainData getViewType:6];
            MainTableCell.textView.text = @"zum bearbeiten klicken";
            return MainTableCell;
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.delegate = self;
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"EE, dd.MM.yyyy (HH:mm)"];
            MainTableCell.custumTextLabel1.text = [formatter stringFromDate:viewingTermin.TerminDate];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_17.png"];
            return MainTableCell;
        }
    }
    else if (indexPath.section == 2) {
        if ([viewingTermin.ConnectedSubjectID isEqualToString:@""]) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.delegate = self;
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = @"Fach verbinden";
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_3.png"];
            return MainTableCell;
        }
        else {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            Subject *rowSubject = [viewingPerson getSubjectForID:viewingTermin.ConnectedSubjectID];
            MainTableCell.delegate = self;
            MainTableCell.backgroundView = [MainData getViewWithColor:rowSubject.SubjectColor];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = rowSubject.SubjectName;
            MainTableCell.custumTextLabel1.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
            return MainTableCell;
        }
    }
    else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            NSString *stringAdd = @"hinzufügen";
            if (viewingTermin.TerminImage != nil) stringAdd = @"ersetzen";
            MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"Foto %@", stringAdd];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_20.png"];
            return MainTableCell;
        }
        else {
            MainTableFile14 *MainTableCell = [MainData getCellType:14];
            MainTableCell.customImageView.image = viewingTermin.TerminImageSmall;
            MainTableCell.customImageView.layer.masksToBounds = YES;
            return MainTableCell;
        }
    }
    else if (indexPath.section == 4) {
        MainTableFile4 *MainTableCell = [MainData getCellType:4];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.tableSwitch.on = viewingTermin.NotificationEnabled;
        MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
        MainTableCell.textLabel.text = @"Benachrichtigungen:";
        return MainTableCell;
    }
    else if (indexPath.section == 5) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:5];
        MainTableCell.selectedBackgroundView = [MainData getViewType:5];
        MainTableCell.custumTextLabel1.textColor = [UIColor whiteColor];
        MainTableCell.custumTextLabel1.highlightedTextColor = [UIColor whiteColor];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.custumTextLabel1.text = @"Termin löschen";
        return MainTableCell;
    }
    return 0;
}
- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (funktionenTermineDetailDate == nil) funktionenTermineDetailDate = [[FunktionenTermineDetailDate alloc] init];
        [funktionenTermineDetailDate reloadWithDate:viewingTermin.TerminDate];
        funktionenTermineDetailDate.delegate = self;
        funktionenTermineDetailDate.modalPresentationStyle = UIModalPresentationFormSheet;
        funktionenTermineDetailDate.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:funktionenTermineDetailDate animated:YES completion:NULL];
    }
    else if (indexPath.section == 2 && indexPath.row == 0) {
        if (subAddHoureViewController == nil) subAddHoureViewController = [[SubAddHoureViewController alloc] init];
        subAddHoureViewController.toIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        subAddHoureViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        subAddHoureViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [subAddHoureViewController reloadWithPerson:viewingPerson];
        subAddHoureViewController.delegate = self;
        [self presentViewController:subAddHoureViewController animated:YES completion:NULL];
    }
    else if (indexPath.section == 3 && indexPath.row == 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else if (indexPath.section == 3 && indexPath.row != 0 && viewingTermin.TerminImage != nil) {
        if (pictureView == nil) pictureView = [[MPPictureView alloc] init];
        [pictureView reloadWithImage:viewingTermin.TerminImage andTitle:viewingTermin.TerminName];
        pictureView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        pictureView.modalPresentationStyle = UIModalPresentationFormSheet;
        pictureView.delegate = self;
        [self presentViewController:pictureView animated:YES completion:NULL];
    }
    else if (indexPath.section == 5 && indexPath.row == 0) {
        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"Termin löschen" otherButtonTitles:nil];
        really.tag = 2;
        [really showInView:self.view];
    }
}
- (void)doneWithDate:(NSDate *)newDate {
    viewingTermin.TerminDate = newDate;
    [table reloadData];
}
- (void)changesSwitchTo:(BOOL)switchValue inIndexPath:(NSIndexPath *)ipath {
    if (ipath.section == 4 && ipath.row == 0) viewingTermin.NotificationEnabled = switchValue;
    [table reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table reloadData];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    viewingTermin.TerminImage = [MainData imageWithImage:image];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)valueChangedTo:(int)neValue atIndex:(NSIndexPath *)index {
    if (index.section == 1) {
        viewingTermin.TerminDate = [NSDate dateWithTimeInterval:neValue*60*60*24 sinceDate:viewingTermin.TerminDate];
        [table reloadData];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2 && buttonIndex == 0) {
        [viewingTermin prepareDelete];
        [viewingPerson.Termine removeObjectAtIndex:viewingTerminIndex];
        
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
        
        [self.delegate viewWillAppear:YES];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0) return 34;
    else if (indexPath.section == 1 && indexPath.row != 0) return 34;
    else if (indexPath.section == 3 && indexPath.row != 0 && viewingTermin.TerminImage != nil) return 100;
    return 44;
}
- (void)typeText:(NSString *)text index:(NSIndexPath *)index {
    if (index.section == 0 && index.row == 1) viewingTermin.TerminName = [MainData kommaDurchPunktErsetzen:text];
}
- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    if (index.section == 0 && index.row == 1) viewingTermin.TerminName = [MainData kommaDurchPunktErsetzen:string];
}
- (void)keyboardVisible:(BOOL)visible {
    
}
- (void)startTypingAtIndexPath:(NSIndexPath *)indexp {
    
}


- (void)valueChangedToDate:(NSDate *)dateChange atIndex:(NSIndexPath *)index {
    if (index.section == 1 && index.row == 0) {
        viewingTermin.TerminDate = dateChange;
        [table reloadData];
        [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



- (IBAction)done:(id)sender {
    [viewingTermin hasBeenSaved];
    
    if (isNew) {
        [viewingPerson.Termine addObject:viewingTermin];
    }
    else {
        [viewingPerson.Termine removeObjectAtIndex:viewingTerminIndex];
        [viewingPerson.Termine insertObject:viewingTermin atIndex:viewingTerminIndex];
    }
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
    
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)cancel:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
