//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenNotizDetail.h"
#import "Person.h"
#import "Subject.h"
#import "MainData.h"
#import "MainTableFile2.h"
#import "MainTableFile8.h"
#import "MainTableFile11.h"
#import "MainTableFile14.h"
#import "MainTableFile17.h"
#import "SubjectCell1.h"
#import "Notiz.h"
#import "Info.h"
#import "Week.h"
#import "Day.h"
#import "Houre.h"
#import "MPDate.h"
#import <QuartzCore/QuartzCore.h>
#import "MPPictureView.h"
#import "SubAddHoureViewController.h"

@interface FunktionenNotizDetail ()

@end

@implementation FunktionenNotizDetail

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenNotizDetail alloc] initWithNibName:@"FunktionenNotizDetail_iPhone" bundle:nil];
    else self = [[FunktionenNotizDetail alloc] initWithNibName:@"FunktionenNotizDetail_iPad" bundle:nil];
    return self;
}


- (void)viewDidAppear:(BOOL)animated {
    if (isNew) navBar.topItem.title = @"Neue Vertretung";
    else navBar.topItem.title = editingNotiz.NotizName;
}

- (void)reloadWithNewNotizInWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex andSubjectID:(NSString *)subID {
    
    viewingIndex = newVingingIndex;
    viewingWeek = newWeek;
    viewingPerson = newPerson;
    
    editingNotiz = [Notiz newNotizWithName:@""];
    editingNotiz.ConnectedSubjectID = subID;
    isNew = YES;
    
    navBar.topItem.title = @"Neue Notiz";
    
    [table reloadData];
}
- (void)reloadWithNewNotizInWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex {
    [self reloadWithNewNotizInWeek:newWeek AndPerson:newPerson AndViewingIndex:newVingingIndex andSubjectID:@""];
}



- (void)reloadWithNotiz:(Notiz *)newNotiz andIndex:(int)newEditingIndex andWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex {
    viewingIndex = newVingingIndex;
    editingNotiz = newNotiz;
    editingNotizIndex = newEditingIndex;
    viewingWeek = newWeek;
    viewingPerson = newPerson;
    
    navBar.topItem.title = editingNotiz.NotizName;
    
    isNew = NO;
    
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
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) return UIInterfaceOrientationMaskPortrait;
    return UIInterfaceOrientationMaskAll;
}

- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isNew) return 4;
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return 1;break;
        case 1:return 1;break;
        case 2:return 1;break; // yes
        case 3:
            if ([editingNotiz NotizImage] != nil) return 2;
            else return 1;break; // yes
        case 4:return 1;break; // yes
        default:break;
    }
    return 0;
}

- (void)didType:(NSString *)string {
    NSLog(@"%@", string);
    editingNotiz.NotizName = string;
    int PADDING = 11;
    
    NSString *text = editingNotiz.NotizName;
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(table.frame.size.width - PADDING * 3, 1000.0f)];
    if (textSize.height + PADDING * 3 != oldHeight && textSize.height + PADDING * 3 >= 44) {
        [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        oldHeight = textSize.height + PADDING * 3;
        [typeTextView becomeFirstResponder];
    }
    
}
- (void)endType {
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        MainTableFile17 *MainTableCell = [MainData getCellType:17];
        MainTableCell.customTextView.text = editingNotiz.NotizName;
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.delegate = self;
        typeTextView = MainTableCell.customTextView;
        return MainTableCell;
                
        
        
        
        
        
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        MainTableFile11 *MainTableCell = [MainData getCellType:11];
        MainTableCell.delegate = self;
        MainTableCell.indexPath = indexPath;
        [MainTableCell setToDate:editingNotiz.NotizDatum];
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (indexPath.section == 2) {
        if ([editingNotiz.ConnectedSubjectID isEqualToString:@""]) {
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
            Subject *rowSubject = [viewingPerson getSubjectForID:editingNotiz.ConnectedSubjectID];
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
            if (editingNotiz.NotizImage != nil) stringAdd = @"ersetzen";
            MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"Foto %@", stringAdd];
            MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_20.png"];
            return MainTableCell;
        }
        else {
            MainTableFile14 *MainTableCell = [MainData getCellType:14];
            MainTableCell.customImageView.image = [editingNotiz NotizImageSmall];
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
        MainTableCell.custumTextLabel1.text = @"Notiz löschen";
        return MainTableCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
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
    else if (indexPath.section == 3 && indexPath.row != 0 && [editingNotiz NotizImage] != nil) {
        if (pictureView == nil) pictureView = [[MPPictureView alloc] init];
        [pictureView reloadWithImage:editingNotiz.NotizImage andTitle:editingNotiz.NotizName];
        pictureView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        pictureView.modalPresentationStyle = UIModalPresentationFormSheet;
        pictureView.delegate = self;
        [self presentViewController:pictureView animated:YES completion:NULL];
        
    }
    else if (indexPath.section == 4) {
        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Abbrechen" destructiveButtonTitle:@"Notiz Löschen" otherButtonTitles:nil];
        really.tag = 2;
        [really showInView:self.view];
    }
    
}


- (void)didSelectSubjectAtIndex:(NSIndexPath *)indexPath {
    editingNotiz.ConnectedSubjectID = [[viewingPerson.Subjects objectAtIndex:indexPath.row] SubjectID];
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:2], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)didSelectFree {
    editingNotiz.ConnectedSubjectID = @"";
    [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:2], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [editingNotiz setNotizImage:[MainData imageWithImage:image]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [table reloadData];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2 && buttonIndex == 0) {
        
        [editingNotiz prepareDelete];
        
        [viewingPerson.Notizen removeObjectAtIndex:editingNotizIndex];
      
        NSMutableArray *Persons = [MainData LoadMain];
        [Persons removeObjectAtIndex:viewingIndex];
        [Persons insertObject:viewingPerson atIndex:viewingIndex];
        [MainData SaveMain:Persons];
        
        
        [self.delegate viewWillAppear:YES];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        int PADDING = 11;
        
        NSString *text = editingNotiz.NotizName;
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(table.frame.size.width - PADDING * 3, 1000.0f)];
        if (textSize.height + PADDING * 3 < 44) return 44;
        return textSize.height + PADDING * 3 + 5;
    }
    else if (indexPath.section == 1 && indexPath.row != 0) return 34;
    if (indexPath.section == 3 && indexPath.row == 1) return 100;
    return 44;
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)didSelectButton:(int)buttonIndex andIndex:(NSIndexPath *)indexPath {
    
}



- (void)valueChangedToDate:(NSDate *)dateChange atIndex:(NSIndexPath *)index {
    editingNotiz.NotizDatum = dateChange;
    
    [table reloadSections:[NSIndexSet indexSetWithIndex:index.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}




//- (void)typeName:(NSString *)name index:(NSIndexPath *)index {
//    [[editingNotiz.no objectAtIndex:index.row-1] changeNameTo:name];
//}
//- (void)typeInfo:(NSString *)info index:(NSIndexPath *)index {
//    [[editingVertretung.VertretungInfos objectAtIndex:index.row-1] changeInfoTo:info];
//}
//- (void)didEndNameAtIndex:(NSIndexPath *)index withText:(NSString *)string {
//    [table resignFirstResponder];
//}
//- (void)didEndInfoAtIndex:(NSIndexPath *)index withText:(NSString *)string {
//    [table resignFirstResponder];
//}
//- (void)didStartNameAtIndex:(NSIndexPath *)indexp {
//    [table scrollToRowAtIndexPath:indexp atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}
//- (void)didStartInfoAtIndex:(NSIndexPath *)indexp {
//    [table scrollToRowAtIndexPath:indexp atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}






- (void)done:(id)sender {
    
//    if (isNew) {
//        [self.delegate didCreateVertretung:editingVertretung];
//        [[viewingPerson getVertretungenForWeek:viewingWeek] addObject:editingVertretung];
//        [self.delegate didCreateVertretung:editingVertretung];
//    }
//    else {
//        [self.delegate didEditVertretung:editingVertretung atIndex:editingVertretungIndex];
//        [[viewingPerson getVertretungenForWeek:viewingWeek] removeObjectAtIndex:editingVertretungIndex];
//        [[viewingPerson getVertretungenForWeek:viewingWeek] insertObject:editingVertretung atIndex:editingVertretungIndex];
//        [self.delegate didEditVertretung:editingVertretung atIndex:editingVertretungIndex];
//    }
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
    
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (IBAction)cancelAdd:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)saveAdd:(id)sender {
    if (isNew) {
        [viewingPerson.Notizen addObject:editingNotiz];
    }
    else {
        [viewingPerson.Notizen removeObjectAtIndex:editingNotizIndex];
        [viewingPerson.Notizen insertObject:editingNotiz atIndex:editingNotizIndex];
    }
    NSMutableArray *Persons = [MainData LoadMain];
    [Persons removeObjectAtIndex:viewingIndex];
    [Persons insertObject:viewingPerson atIndex:viewingIndex];
    [MainData SaveMain:Persons];
    
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)share:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
