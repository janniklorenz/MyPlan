//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "SubFunktionenNotenDetail.h"
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
#import "Note.h"
#import "MainTableFile14.h"
#import "MPPictureView.h"

@interface SubFunktionenNotenDetail ()

@end

@implementation SubFunktionenNotenDetail

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[SubFunktionenNotenDetail alloc] initWithNibName:@"SubFunktionenNotenDetail_iPhone" bundle:nil];
    else self = [[SubFunktionenNotenDetail alloc] initWithNibName:@"SubFunktionenNotenDetail_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    PossibleNotes = [NSMutableArray arrayWithObjects:
                     @"1. Schulaufgabe", @"2. Schulaufgabe", @"3. Schulaufgabe", @"4. Schulaufgabe",
                     @"1. Ex", @"2. Ex", @"3. Ex", @"4. Ex",
                     @"Mündlich", nil];
    
    if (isNew) navBar.topItem.title = @"Neue Note";
    else navBar.topItem.title = viewingNote.NoteNotiz;
    
    [super viewDidLoad];
    
}

- (void)reloadNewWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek andSubjectIndex:(int)vSubjectIndex {
    isNew = YES;
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    viewungSubjectIndex = vSubjectIndex;
    
    viewingSubject = [viewingPerson.Subjects objectAtIndex:viewungSubjectIndex];
    viewingNote = [Note newNote];
    
    navBar.topItem.title = @"Neue Note";
    
    [table reloadData];
}

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek andSubjectIndex:(int)vSubjectIndex andNotenIndex:(int)vNotenIndex {
    isNew = NO;
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    viewungSubjectIndex = vSubjectIndex;
    viewingNotenIndex = vNotenIndex;
    
    viewingSubject = [viewingPerson.Subjects objectAtIndex:viewungSubjectIndex];
    viewingNote = [viewingSubject.Noten objectAtIndex:viewingNotenIndex];
    
    navBar.topItem.title = viewingNote.NoteNotiz;
    
    [table reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    [table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isNew) return 4;
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return 3;break;
        case 1:return [PossibleNotes count]+1;break;
        case 2:return 1;break;
        case 3:
            if ([viewingNote NoteImage] != nil) return 2;
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
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_16.png"];
            MainTableCell.custumTextLabel1.text = @"Note";
            return MainTableCell;
        }
        else if (indexPath.row == 1) {
            MainTableFile3 *MainTableCell = [MainData getCellType:3];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            MainTableCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            MainTableCell.textLabel.text = @"Note:";
            MainTableCell.textField.text = [NSString stringWithFormat:@"%g", viewingNote.NoteWert];
            return MainTableCell;
        }
        else if (indexPath.row == 2) {
            MainTableFile3 *MainTableCell = [MainData getCellType:3];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            MainTableCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            MainTableCell.textLabel.text = @"Wehrtung:";
            MainTableCell.textField.text = [NSString stringWithFormat:@"%g", viewingNote.NoteWertung];
            return MainTableCell;
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MainTableFile3 *MainTableCell = [MainData getCellType:3];
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            MainTableCell.textLabel.text = @"Notiz:";
            MainTableCell.textField.text = viewingNote.NoteNotiz;
            return MainTableCell;
        }
        else {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = [PossibleNotes objectAtIndex:indexPath.row-1];
            return MainTableCell;
        }
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            MainTableFile4 *MainTableCell = [MainData getCellType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.backgroundView = [MainData getViewType:0];
            
            MainTableCell.textLabel.text = @"Werten:";
            MainTableCell.tableSwitch.on = viewingNote.isEnabled;
            
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
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
            if (viewingNote.NoteImage != nil) stringAdd = @"ersetzen";
            MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"Foto %@", stringAdd];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_20.png"];
            return MainTableCell;
        }
        else {
            MainTableFile14 *MainTableCell = [MainData getCellType:14];
            MainTableCell.customImageView.image = [viewingNote NoteImageSmall];
            MainTableCell.customImageView.layer.masksToBounds = YES;
            return MainTableCell;
        }
    }
    else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:3];
            MainTableCell.custumTextLabel1.textColor = [UIColor whiteColor];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.backgroundView = [MainData getViewType:5];
            MainTableCell.custumTextLabel1.text = @"Note löschen";
            return MainTableCell;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4 && indexPath.row == 0) {
        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"Fach löschen" otherButtonTitles:nil];
        really.tag = 2;
        [really showInView:self.view];
    }
    else if (indexPath.section == 3 && indexPath.row == 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else if (indexPath.section == 3 && indexPath.row != 0 && [viewingNote NoteImage] != nil) {
        if (pictureView == nil) pictureView = [[MPPictureView alloc] init];
        [pictureView reloadWithImage:viewingNote.NoteImage andTitle:viewingNote.NoteNotiz];
        pictureView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        pictureView.modalPresentationStyle = UIModalPresentationFormSheet;
        pictureView.delegate = self;
        [self presentViewController:pictureView animated:YES completion:NULL];
    }
    else if (indexPath.section == 1 && indexPath.row != 0) {
        viewingNote.NoteNotiz = [PossibleNotes objectAtIndex:indexPath.row-1];
        [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [viewingNote setNoteImage:[MainData imageWithImage:image]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2 && buttonIndex == 0) {
        [self.delegate viewWillAppear:YES];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)didType {
    
}
- (void)endType {
    NSLog(@"ssss");
    [table resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0) return 34;
    else if (indexPath.section == 1 && indexPath.row != 0) return 34;
    else if (indexPath.section == 3 && indexPath.row != 0 && [viewingNote NoteImage] != nil) return 100;
    return 44;
}

- (void)typeText:(NSString *)text index:(NSIndexPath *)index {
    if (index.section == 0 && index.row == 1) viewingNote.NoteWert = [[MainData kommaDurchPunktErsetzen:text] floatValue];
    else if (index.section == 0 && index.row == 2) viewingNote.NoteWertung = [[MainData kommaDurchPunktErsetzen:text] floatValue];
    else if (index.section == 1 && index.row == 0) viewingNote.NoteNotiz = text;
}
- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    if (index.section == 0 && index.row == 1) viewingNote.NoteWert = [[MainData kommaDurchPunktErsetzen:string] floatValue];
    else if (index.section == 0 && index.row == 2) viewingNote.NoteWertung = [[MainData kommaDurchPunktErsetzen:string] floatValue];
    else if (index.section == 1 && index.row == 0) viewingNote.NoteNotiz = string;
}
- (void)keyboardVisible:(BOOL)visible {
    
}
- (void)startTypingAtIndexPath:(NSIndexPath *)indexp {
    
}


- (void)changesSwitchTo:(BOOL)switchValue inIndexPath:(NSIndexPath *)ipath {
    if (ipath.section == 2 && ipath.row == 0) viewingNote.isEnabled = switchValue;
}




- (IBAction)done:(id)sender {
    if (isNew) {
        [viewingSubject.Noten addObject:viewingNote];
    }
    else {
        [viewingSubject.Noten removeObjectAtIndex:viewingNotenIndex];
        [viewingSubject.Noten insertObject:viewingNote atIndex:viewingNotenIndex];
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
