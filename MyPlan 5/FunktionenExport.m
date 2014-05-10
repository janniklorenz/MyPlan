//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenExport.h"
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
#import "HTMLObject.h"
#import "Houre.h"
#import "Note.h"

@interface FunktionenExport ()

@end

@implementation FunktionenExport

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenExport alloc] initWithNibName:@"FunktionenExport_iPhone" bundle:nil];
    else self = [[FunktionenExport alloc] initWithNibName:@"FunktionenExport_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    oppendIndex = 0;
    oppened = YES;
    
    self.title = @"Exportieren";
    
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [table addGestureRecognizer:swipe];
}

- (void)swipeBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    [table reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section >= 0 && section <= 2 && oppendIndex == section && oppened) return 4;
    else if (section >= 0 && section <= 2) return 1;
    else if (section == 3) return 1;
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 0 && indexPath.section <= 2) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            if (indexPath.section == 0) {
                MainTableCell.custumTextLabel1.text = @"Stundenplan";
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_17.png"];
            }
            else if (indexPath.section == 1) {
                MainTableCell.custumTextLabel1.text = @"Notenübersicht";
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_16.png"];
            }
            else if (indexPath.section == 2) {
                MainTableCell.custumTextLabel1.text = @"Fächerliste";
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_18.png"];
            }
            return MainTableCell;
        }
        else {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            if (indexPath.row == 1) {
                MainTableCell.custumTextLabel1.text = @"PDF erstellen";
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_21.png"];
            }
            else if (indexPath.row == 2) {
                MainTableCell.custumTextLabel1.text = @"CSV erstellen";
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_22.png"];
            }
            else if (indexPath.row == 3) {
                MainTableCell.custumTextLabel1.text = @"Website erstellen";
                MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_23.png"];
            }
            return MainTableCell;
        }
    }
    else if (indexPath.section == 3) {
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.custumImageView.image = [UIImage imageNamed:@"MyPlan_img_1.png"];
        MainTableCell.custumTextLabel1.text = @"Person Exportieren";
        return MainTableCell;
    }
    return 0;
}
- (void)tableView:(UITableView *)tbl didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 0 && indexPath.section <= 2 && indexPath.row == 0) {
        if (oppened && oppendIndex == indexPath.section) oppened = NO;
        else oppened = YES;
        oppendIndex = (int)indexPath.section;
        [table reloadData];
    }
    
    if (indexPath.section == 0 && indexPath.row != 0) {
        int max = 0;
        NSMutableArray *TopArray = [NSMutableArray arrayWithObjects:viewingWeek.WeekName, nil];
        for (int i = 0; i < [viewingWeek.WeekDurationNames count]; i++) {
            if ([[[viewingWeek.WeekDurationNames objectAtIndex:i] Subjects] count] > max) max = (int)[[[viewingWeek.WeekDurationNames objectAtIndex:i] Subjects] count];
            [TopArray addObject:[[viewingWeek.WeekDurationNames objectAtIndex:i] DayShort]];
        }
        NSMutableArray *DatabaseArray = [NSMutableArray arrayWithObjects:TopArray, nil];
        for (int houre = 0; houre < max; houre++) {
            NSMutableArray *LineArray = [NSMutableArray arrayWithObjects:[[viewingWeek getDateForDay:0 andHoure:houre] getTime], nil];
            for (int day = 0; day < [viewingWeek.WeekDurationNames count]; day++) {
                NSString *name = @"";
                if (houre < [[[viewingWeek.WeekDurationNames objectAtIndex:day] Subjects] count]) {
                    Subject *rowSubject = [viewingPerson getSubjectForID:[[[[viewingWeek.WeekDurationNames objectAtIndex:day] Subjects] objectAtIndex:houre] HoureSubjectID] onDate:[MainData dateForDayIndex:day] andHoure:houre inWeek:viewingWeek];
                    if (indexPath.row == 1) name = rowSubject.SubjectName;
                    else name = rowSubject.SubjectShort;
                }
                [LineArray addObject:name];
            }
            [DatabaseArray addObject:LineArray];
        }
        
        if (indexPath.row == 1) {
            NSString *filepath = [HTMLObject MakePDF:DatabaseArray Spalten:(int)[viewingWeek.WeekDurationNames count]+1 Header:viewingPerson.PersonName];
            shareController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filepath]];
            CGRect navRect = self.navigationController.navigationBar.frame;
            navRect.size = CGSizeMake(1500.0f, 40.0f);
            [shareController presentOptionsMenuFromRect:navRect inView:self.view animated:YES];
        }
        else if (indexPath.row == 2) {
            NSString *documentsFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *fileName = [NSString stringWithFormat:@"MyPlan Export - CSV (%@).csv", viewingPerson.PersonName];
            NSString *path = [documentsFolder stringByAppendingPathComponent:fileName];
            NSString *contend = [HTMLObject MakeCSVTable:DatabaseArray Spalten:(int)[viewingWeek.WeekDurationNames count]+1 Header:viewingPerson.PersonName];
            [[NSFileManager defaultManager] createFileAtPath:path contents:[contend dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
            
            shareController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
            CGRect navRect = self.navigationController.navigationBar.frame;
            navRect.size = CGSizeMake(1500.0f, 40.0f);
            [shareController presentOptionsMenuFromRect:navRect inView:self.view animated:YES];
        }
        else if (indexPath.row == 3) {
            NSString *contend = [HTMLObject MakeHTMLTable:DatabaseArray Spalten:(int)[viewingWeek.WeekDurationNames count]+1 Header:viewingPerson.PersonName];
            NSString *name = [HTMLObject uploadContend:contend andName:[NSString stringWithFormat:@"%@-%@", viewingPerson.PersonName, viewingWeek.WeekName]];
            UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:@"Website öffnen", @"Link kopieren", nil];
            really.tag = 10;
            [really showInView:self.view];
            WebURL = [[NSString stringWithFormat:@"http://www.jlproduction.de/MyPlan5/%@", name] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        }
        [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if (indexPath.section == 1 && indexPath.row != 0) {
        
        int maxNoten = 0;
        for (int i = 0; i < [viewingPerson.Subjects count]; i++) if ([[[viewingPerson.Subjects objectAtIndex:i] Noten] count] > maxNoten) maxNoten = (int)[[[viewingPerson.Subjects objectAtIndex:i] Noten] count];
        
        NSMutableArray *DatabaseArray = [NSMutableArray arrayWithObjects:nil];
        NSMutableArray *addLine2 = [NSMutableArray arrayWithObjects:nil];
        for (int i = 0; i < maxNoten+2; i++) {
            if (i == maxNoten+1) [addLine2 addObject:[viewingPerson getMainNoten]];
            else if (i == 0) [addLine2 addObject:@"Gesamt:"];
            else [addLine2 addObject:@""];
        }
        [DatabaseArray addObject:addLine2];
        NSMutableArray *addLine1 = [NSMutableArray arrayWithObjects:nil];
        for (int i = 0; i < maxNoten+2; i++) {
            if (i == maxNoten+1) [addLine1 addObject:[viewingPerson getHauptFaecherNoten]];
            else if (i == 0) [addLine1 addObject:@"Hauptfächer:"];
            else [addLine1 addObject:@""];
        }
        [DatabaseArray addObject:addLine1];
        
        for (int SubjectIndex = 0; SubjectIndex < [viewingPerson.Subjects count]; SubjectIndex++) {
            NSMutableArray *lineArray = [NSMutableArray arrayWithObjects:[[viewingPerson.Subjects objectAtIndex:SubjectIndex] SubjectName], nil];
            for (int i = 0; i < maxNoten; i++) {
                if (i < [[[viewingPerson.Subjects objectAtIndex:SubjectIndex] Noten] count]) {
                    Note *viewingNote = [[[viewingPerson.Subjects objectAtIndex:SubjectIndex] Noten] objectAtIndex:i];
                    [lineArray addObject:[NSString stringWithFormat:@"%g (%@)", viewingNote.NoteWert, viewingNote.NoteNotiz]];
                }
                else [lineArray addObject:@""];
            }
            [lineArray addObject:[[viewingPerson.Subjects objectAtIndex:SubjectIndex] getCompleteNote]];
            [DatabaseArray addObject:lineArray];
        }
        
        if (indexPath.row == 1) {
            NSString *filepath = [HTMLObject MakePDF:DatabaseArray Spalten:maxNoten+2 Header:viewingPerson.PersonName];
            shareController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filepath]];
            CGRect navRect = self.navigationController.navigationBar.frame;
            navRect.size = CGSizeMake(1500.0f, 40.0f);
            [shareController presentOptionsMenuFromRect:navRect inView:self.view animated:YES];
        }
        else if (indexPath.row == 2) {
            NSString *documentsFolder = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *fileName = [NSString stringWithFormat:@"MyPlan Export - CSV (%@).csv", viewingPerson.PersonName];
            NSString *path = [documentsFolder stringByAppendingPathComponent:fileName];
            NSString *contend = [HTMLObject MakeCSVTable:DatabaseArray Spalten:maxNoten+2 Header:viewingPerson.PersonName];
            [[NSFileManager defaultManager] createFileAtPath:path contents:[contend dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
            
            shareController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
            CGRect navRect = self.navigationController.navigationBar.frame;
            navRect.size = CGSizeMake(1500.0f, 40.0f);
            [shareController presentOptionsMenuFromRect:navRect inView:self.view animated:YES];
        }
        else if (indexPath.row == 3) {
            NSString *contend = [HTMLObject MakeHTMLTable:DatabaseArray Spalten:maxNoten+2 Header:viewingPerson.PersonName];
            NSString *name = [HTMLObject uploadContend:contend andName:[NSString stringWithFormat:@"%@-%@", viewingPerson.PersonName, viewingWeek.WeekName]];
            UIActionSheet *really = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:@"Website öffnen", @"Link kopieren", nil];
            really.tag = 10;
            [really showInView:self.view];
            WebURL = [[NSString stringWithFormat:@"http://www.jlproduction.de/MyPlan5/%@", name] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        }
        [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if (indexPath.section == 2 && indexPath.row != 0) {
        if (indexPath.row == 1) {
            NSLog(@"3PDF");
        }
        else if (indexPath.row == 2) {
            NSLog(@"3CSV");
        }
        else if (indexPath.row == 3) {
            NSLog(@"3HTML");
        }
        [table selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else if (indexPath.section == 3) {
        NSString *filepath = [MainData SavePersonToSend:viewingPerson];
        shareController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filepath]];
        CGRect navRect = self.navigationController.navigationBar.frame;
        navRect.size = CGSizeMake(1500.0f, 40.0f);
        [shareController presentOptionsMenuFromRect:navRect inView:self.view animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) return 34;
    return 44;
}




- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 10 && buttonIndex == 0)  {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:WebURL]];
    }
    if (actionSheet.tag == 10 && buttonIndex == 1)  {
        [UIPasteboard generalPasteboard].string = WebURL;
    }
}



@end
