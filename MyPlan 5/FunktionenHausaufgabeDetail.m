//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenHausaufgabeDetail.h"
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
#import "Homework.h"
#import "SubAddHoureViewController.h"
#import "MPPictureView.h"

@interface FunktionenHausaufgabeDetail ()

@end

@implementation FunktionenHausaufgabeDetail

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenHausaufgabeDetail alloc] initWithNibName:@"FunktionenHausaufgabeDetail_iPhone" bundle:nil];
    else self = [[FunktionenHausaufgabeDetail alloc] initWithNibName:@"FunktionenHausaufgabeDetail_iPad" bundle:nil];
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    if (isNew) navBar.topItem.title = @"Neue Hausaufgabe";
    else navBar.topItem.title = viewingHomework.HomeworkName;
    
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    [table reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)reloadWithNewHomeworkWithSubjectID:(NSString *)newSubjectID ViewingIndex:(int)vindex andPerson:(Person *)vperson {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingHomework = [Homework newHomework];
    viewingHomework.ConnectedSubjectID = newSubjectID;
    
    isNew = YES;
    
    navBar.topItem.title = @"Neue Hausaufgabe";
    
    [table reloadData];
}
- (void)reloadWithNewHomeworkViewingIndex:(int)vindex andPerson:(Person *)vperson {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingHomework = [Homework newHomework];
    
    isNew = YES;
    
    navBar.topItem.title = @"Neue Hausaufgabe";
    
    [table reloadData];
}
- (void)reloadWithHomeworkAtIndex:(int)homeworkIndex ViewingIndex:(int)vindex andPerson:(Person *)vperson {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingHomeworkIndex = homeworkIndex;
    viewingHomework = [viewingPerson.Homeworks objectAtIndex:viewingHomeworkIndex];
    
    isNew = NO;
    
    navBar.topItem.title = viewingHomework.HomeworkName;
    
    [table reloadData];
}




- (void)didSelectSubjectAtIndex:(NSIndexPath *)indexPath {
    viewingHomework.ConnectedSubjectID = [[viewingPerson.Subjects objectAtIndex:indexPath.row] SubjectID];
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:2], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)didSelectFree {
    viewingHomework.ConnectedSubjectID = @"";
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:2], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isNew) return 4;
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return 3;break;
        case 1:return 1;break;
        case 2:return 1;break;
        case 3:
            if (viewingHomework.HomeworkImage != nil) return 2;
            else return 1;break;
        case 4:return 1;break;
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
            MainTableCell.textField.text = viewingHomework.HomeworkName;
            MainTableCell.textField.placeholder = @"Hausaufgabe";
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
        MainTableFile11 *MainTableCell = [MainData getCellType:11];
        MainTableCell.delegate = self;
        MainTableCell.indexPath = indexPath;
        [MainTableCell setToDate:viewingHomework.HomeworkDate];
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.stepper.minimumValue = 0;
        MainTableCell.stepper.maximumValue = 365;
        return MainTableCell;
    }
    else if (indexPath.section == 2) {
        if ([viewingHomework.ConnectedSubjectID isEqualToString:@""]) {
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
            Subject *rowSubject = [viewingPerson getSubjectForID:viewingHomework.ConnectedSubjectID];
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
            if (viewingHomework.HomeworkImage != nil) stringAdd = @"ersetzen";
            MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"Foto %@", stringAdd];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_20.png"];
            return MainTableCell;
        }
        else {
            MainTableFile14 *MainTableCell = [MainData getCellType:14];
            MainTableCell.customImageView.image = viewingHomework.HomeworkImageSmall;
            MainTableCell.customImageView.layer.masksToBounds = YES;
            return MainTableCell;
        }
    }
    else if (indexPath.section == 4) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:5];
        MainTableCell.selectedBackgroundView = [MainData getViewType:5];
        MainTableCell.custumTextLabel1.textColor = [UIColor whiteColor];
        MainTableCell.custumTextLabel1.highlightedTextColor = [UIColor whiteColor];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.custumTextLabel1.text = @"Hausaufgabe löschen";
        return MainTableCell;
    }
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
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
    else if (indexPath.section == 3 && indexPath.row != 0 && viewingHomework.HomeworkImage != nil) {
        if (pictureView == nil) pictureView = [[MPPictureView alloc] init];
        [pictureView reloadWithImage:viewingHomework.HomeworkImage andTitle:viewingHomework.HomeworkName];
        pictureView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        pictureView.modalPresentationStyle = UIModalPresentationFormSheet;
        pictureView.delegate = self;
        [self presentViewController:pictureView animated:YES completion:NULL];
    }
    else if (indexPath.section == 4 && indexPath.row == 0) {
        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"Hausaufgabe löschen" otherButtonTitles:nil];
        really.tag = 2;
        [really showInView:self.view];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    viewingHomework.HomeworkImage = [MainData imageWithImage:image];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2 && buttonIndex == 0) {
        [viewingHomework prepareDelete];
        [viewingPerson.Homeworks removeObjectAtIndex:viewingHomeworkIndex];
        
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
//    else if (indexPath.section == 3 && indexPath.row == 0) return 34;
    else if (indexPath.section == 3 && indexPath.row != 0 && viewingHomework.HomeworkImage != nil) return 100;
    return 44;
}
- (void)typeText:(NSString *)text index:(NSIndexPath *)index {
    if (index.section == 0 && index.row == 1) viewingHomework.HomeworkName = [MainData kommaDurchPunktErsetzen:text];
}
- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    if (index.section == 0 && index.row == 1) viewingHomework.HomeworkName = [MainData kommaDurchPunktErsetzen:string];
}
- (void)keyboardVisible:(BOOL)visible {
    
}
- (void)startTypingAtIndexPath:(NSIndexPath *)indexp {
    
}


- (void)valueChangedToDate:(NSDate *)dateChange atIndex:(NSIndexPath *)index {
    if (index.section == 1 && index.row == 0) {
        viewingHomework.HomeworkDate = dateChange;
        [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



- (IBAction)done:(id)sender {
    if (isNew) {
        [viewingPerson.Homeworks addObject:viewingHomework];
    }
    else {
        [viewingPerson.Homeworks removeObjectAtIndex:viewingHomeworkIndex];
        [viewingPerson.Homeworks insertObject:viewingHomework atIndex:viewingHomeworkIndex];
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
