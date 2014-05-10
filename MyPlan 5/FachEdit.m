//
//  SubAddHoureViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 06.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FachEdit.h"
#import "Person.h"
#import "Subject.h"
#import "MainData.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import "MainTableFile8.h"
#import "MainTableFile9.h"
#import "MainTableFile10.h"
#import "Info.h"
#import "FachEditDetail.h"

@interface FachEdit ()

@end

@implementation FachEdit

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FachEdit alloc] initWithNibName:@"FachEdit_iPhone" bundle:nil];
    else self = [[FachEdit alloc] initWithNibName:@"FachEdit_iPad" bundle:nil];
    return self;
}


- (void)reloadWithNew {
    editingSubject = [Subject newSubjectWithName:@"Neues Fach" andShort:@"" isMain:NO];
    newSubject = YES;
    [table reloadData];
    [table selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [table becomeFirstResponder];
}
- (void)reloadWithFach:(Subject *)nSubject atIndex:(int)setIndex {
    editingSubject = nSubject;
    newSubject = NO;
    editingSubjectIndex = setIndex;
    [table reloadData];
}

- (void)viewDidLoad {
    WeekDays = [NSMutableArray arrayWithObjects:@"Montag", @"Dienstag", @"Mittwoch", @"Donnerstag", @"Freitag", @"Samstag", @"Sonntag", nil];
    Colors1 = [NSMutableArray arrayWithObjects:
               @"Rot",
               @"Blau",
               @"Grün",
               @"Gelb",
               @"Organge",
               @"Grau",
               @"Braun",
               @"Schwarz",
               @"Weiß", nil];
    Colors2 = [NSMutableArray arrayWithObjects:
               [UIColor redColor],
               [UIColor blueColor],
               [UIColor greenColor],
               [UIColor yellowColor],
               [UIColor orangeColor],
               [UIColor grayColor],
               [UIColor brownColor],
               [UIColor blackColor],
               [UIColor whiteColor], nil];
    Colors3 = [NSMutableArray arrayWithObjects:@"Rot:", @"Grün:", @"Blau:", @"Deckkraft:", nil];
    
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    navBar.topItem.title = editingSubject.SubjectNameAndShort;
    self.navigationController.navigationBarHidden = YES;
    self.title = editingSubject.SubjectNameAndShort;
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





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (newSubject) return 5;
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 3;break;
        case 1: return [editingSubject.Infos count]+2;break;
        case 2:
            if (editingSubject.DayInfosON) return [WeekDays count] + 1;
            else return 2;break;
        case 3:
            if (editingSubject.CustomColor == 0) return [Colors1 count] + 1;
            else return [Colors3 count] + 1;
        case 4: return 1;break;
        case 5: return 1;break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            MainTableFile *MainTableCell = [MainData getCellType:1];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            if (indexPath.row == 0) {
                MainTableCell.textField.placeholder = @"Name";
                MainTableCell.textField.text = editingSubject.SubjectName;
            }
            else if (indexPath.row == 1) {
                MainTableCell.textField.placeholder = @"Kürzel";
                MainTableCell.textField.text = editingSubject.SubjectShort;
            }
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
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = @"Infos";
            return MainTableCell;
        }
        else if (indexPath.row - 1 == [editingSubject.Infos count]) {
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
            
            MainTableCell.NameLabel.text = [[editingSubject.Infos objectAtIndex:indexPath.row-1] InfoName];
            
            if ([[editingSubject.Infos objectAtIndex:indexPath.row-1] DifferentInfos]) {
                MainTableCell.InfoLabel.text = @"(Tagesabhängige)";
//                MainTableCell.InfoLabel.enabled = NO;
            }
            else {
                MainTableCell.InfoLabel.text = [[editingSubject.Infos objectAtIndex:indexPath.row-1] getInfoForDay:0];
                
            }
            
            MainTableCell.delegate = self;
            MainTableCell.indexPath = indexPath;
            
            return MainTableCell;
        }
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            MainTableFile4 *MainTableCell = [MainData getCellType:4];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.tableSwitch.on = editingSubject.DayInfosON;
            MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
            MainTableCell.textLabel.text = @"Tagesabhängige Infos:";
            return MainTableCell;
        }
        else {
            if (editingSubject.DayInfosON) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.indexPath = indexPath;
                MainTableCell.delegate = self;
                MainTableCell.custumTextLabel1.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
                MainTableCell.custumTextLabel1.text = [WeekDays objectAtIndex:indexPath.row - 1];
                MainTableCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return MainTableCell;
            }
            else {
                MainTableFile5 *MainTableCell = [MainData getCellType:5];
                MainTableCell.backgroundView = [MainData getViewType:6];
                MainTableCell.textView.text = @"aktivieren, um Infos für jeden Tag seperat einzutragen.";
                return MainTableCell;
            }
        }
    }
    else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            MainTableFile9 *MainTableCell = [MainData getCellType:9];
            MainTableCell.backgroundView = [MainData getViewWithColor:editingSubject.SubjectColor];
            MainTableCell.selectedBackgroundView = [MainData getViewWithColor:editingSubject.SubjectColor];
            MainTableCell.indexPath = indexPath;
            MainTableCell.delegate = self;
            MainTableCell.Label1.textColor = [MainData getTextColorForBackgroundColor:editingSubject.SubjectColor];
            MainTableCell.segControl.selectedSegmentIndex = editingSubject.CustomColor;
            MainTableCell.Label1.text = @"Farben:";
            return MainTableCell;
        }
        else {
            if (editingSubject.CustomColor == 0) {
                MainTableFile2 *MainTableCell = [MainData getCellType:2];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.indexPath = indexPath;
                MainTableCell.delegate = self;
                MainTableCell.custumTextLabel1.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
                MainTableCell.custumTextLabel1.text = [Colors1 objectAtIndex:indexPath.row - 1];
                return MainTableCell;
            }
            else {
                MainTableFile10 *MainTableCell = [MainData getCellType:10];
                MainTableCell.backgroundView = [MainData getViewType:4];
                MainTableCell.selectedBackgroundView = [MainData getViewType:0];
                MainTableCell.indexPath = indexPath;
                MainTableCell.delegate = self;
                
                if (indexPath.row - 1 == 0) MainTableCell.slider1.value = [editingSubject getRed];
                else if (indexPath.row - 1 == 1) MainTableCell.slider1.value = [editingSubject getGreen];
                else if (indexPath.row - 1 == 2) MainTableCell.slider1.value = [editingSubject getBlue];
                else if (indexPath.row - 1 == 3) MainTableCell.slider1.value = [editingSubject getAlpha];
                
                MainTableCell.Label1.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
                MainTableCell.Label1.text = [Colors3 objectAtIndex:indexPath.row - 1];
                return MainTableCell;
            }
        }
    }
    else if (indexPath.section == 4) {
        MainTableFile4 *MainTableCell = [MainData getCellType:4];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.tableSwitch.on = editingSubject.isMainSubject;
        MainTableCell.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:98.0/255.0 blue:205.0/255.0 alpha:1.0];
        MainTableCell.textLabel.text = @"Hauptfach:";
        return MainTableCell;
    }
    else if (indexPath.section == 5) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:3];
        MainTableCell.custumTextLabel1.textColor = [UIColor whiteColor];
        MainTableCell.indexPath = indexPath;
        MainTableCell.delegate = self;
        MainTableCell.backgroundView = [MainData getViewType:5];
        MainTableCell.custumTextLabel1.text = @"Fach löschen";
        return MainTableCell;
    }
    return 0;
}

- (void)doneTypingAtIndex:(NSIndexPath *)index withText:(NSString *)string {
    if (index.section == 0 && index.row == 0) editingSubject.SubjectName = string;
    if (index.section == 0 && index.row == 1) editingSubject.SubjectShort = string;
}
- (void)typeText:(NSString *)string index:(NSIndexPath *)index {
    if (index.section == 0 && index.row == 0) editingSubject.SubjectName = string;
    if (index.section == 0 && index.row == 1) editingSubject.SubjectShort = string;
}


- (void)changeSegmentedControlTo:(int)index {
    editingSubject.CustomColor = index;
    [table reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)valueChangedTo:(float)value atIndex:(NSIndexPath *)index {
    float x1 = 0;
    if (index.row - 1 == 0) {
        x1 = [editingSubject getRed] * 50;
        [editingSubject setRed:value];
    }
    else if (index.row - 1 == 1) {
        x1 = [editingSubject getGreen] * 50;
        [editingSubject setGreen:value];
    }
    else if (index.row - 1 == 2) {
        x1 = [editingSubject getBlue] * 50;
        [editingSubject setBlue:value];
    }
    else if (index.row - 1 == 3) {
        x1 = [editingSubject getAlpha] * 50;
        [editingSubject setAlpha:value];
    }
    float x2 = value * 50;
    int x3 = x1;
    int x4 = x2;
    if (x3 != x4) {
        [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:3], nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}


- (void)typeName:(NSString *)name index:(NSIndexPath *)index {
    [[editingSubject.Infos objectAtIndex:index.row-1] changeNameTo:name];
}
- (void)typeInfo:(NSString *)info index:(NSIndexPath *)index {
    [[editingSubject.Infos objectAtIndex:index.row-1] changeInfoTo:info];
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



- (void)keyboardVisible:(BOOL)visible {
    
}
- (void)startTypingAtIndexPath:(NSIndexPath *)indexp {
    [table scrollToRowAtIndexPath:indexp atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row - 1 == [editingSubject.Infos count]) {
        [editingSubject addInfo];
        [table insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [table reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
    }
    else if (indexPath.section == 2 && indexPath.row != 0) {
        if (fachEditDetail == nil) fachEditDetail = [[FachEditDetail alloc] init];
        [fachEditDetail reloadViewsWithSubject:editingSubject andDayIndex:indexPath.row - 1];
        [self.navigationController pushViewController:fachEditDetail animated:YES];
    }
    else if (indexPath.section == 3 && indexPath.row != 0) {
        editingSubject.SubjectColor = [Colors2 objectAtIndex:indexPath.row - 1];
        [editingSubject setAlpha:0.50];
        [table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:3], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (indexPath.section == 5) {
        UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"zurück" destructiveButtonTitle:@"Fach löschen" otherButtonTitles:nil];
        really.tag = 2;
        [really showInView:self.view];
    }
    [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 2 && buttonIndex == 0) {
        [self.delegate didEndWithDeleteAtIndex:editingSubjectIndex];
        [self.delegate viewWillAppear:YES];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0) return 34;
    if (indexPath.section == 2 && indexPath.row != 0 && editingSubject.DayInfosON) return 34;
    if (indexPath.section == 3 && indexPath.row != 0) return 34;
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)changesSwitchTo:(BOOL)switchValue inIndexPath:(NSIndexPath *)ipath {
    if (switchValue == NO) for (int i = 0; i < [editingSubject.Infos count]; i++) [[editingSubject.Infos objectAtIndex:i] overwrite];
    if (ipath.section == 2 && ipath.row == 0) editingSubject.DayInfosON = switchValue;
    if (ipath.section == 4 && ipath.row == 0) editingSubject.isMainSubject = switchValue;
    [table reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [editingSubject.Infos removeObjectAtIndex:indexPath.row-1];
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0 && indexPath.row - 1 != [editingSubject.Infos count]) return YES;
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0 && indexPath.row - 1 != [editingSubject.Infos count]) return YES;
    return NO;
}

- (void)didSelectButton:(int)buttonIndex andIndex:(NSIndexPath *)indexPath {
    
}

- (IBAction)cancel:(id)sender {
    if (newSubject) [self.delegate didEndEditingWithNewSubject:editingSubject];
    else [self.delegate didEndEditingWithSubject:editingSubject atIndex:editingSubjectIndex];
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)chancelAll:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}







@end
