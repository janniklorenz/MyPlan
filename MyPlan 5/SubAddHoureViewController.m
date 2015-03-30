//
//  SubAddHoureViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 06.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "SubAddHoureViewController.h"
#import "Person.h"
#import "Subject.h"
#import "MainData.h"
#import "MainTableFile2.h"
#import "MainTableFile8.h"
#import "SubjectCell1.h"

@interface SubAddHoureViewController ()

@end

@implementation SubAddHoureViewController

@synthesize delegate;
@synthesize toIndexPath;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[SubAddHoureViewController alloc] initWithNibName:@"SubAddHoureViewController_iPhone" bundle:nil];
    else self = [[SubAddHoureViewController alloc] initWithNibName:@"SubAddHoureViewController_iPad" bundle:nil];
    return self;
}

- (void)reloadWithPerson:(Person *)newPerson {
    viewingPerson = newPerson;
    [table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return 1;break;
        case 1:return [viewingPerson.Subjects count]+1;break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.delegate = self;
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = @"Freistunde";
            return MainTableCell;
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MainTableFile2 *MainTableCell = [MainData getCellType:2];
            MainTableCell.delegate = self;
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = @"Fächer";
            return MainTableCell;
        }
        else {
            MainTableFile8 *MainTableCell = [MainData getCellType:8];
            Subject *rowSubject = [viewingPerson.Subjects objectAtIndex:indexPath.row-1];
            
            MainTableCell.backgroundView = [MainData getViewWithColor:rowSubject.SubjectColor];
            MainTableCell.NameLabel.text = rowSubject.SubjectNameAndShort;
            MainTableCell.InfoLabel.text = @"";
            MainTableCell.NameLabel.enabled = NO;
            MainTableCell.InfoLabel.enabled = NO;
            MainTableCell.NameLabel.placeholder = @"";
            MainTableCell.InfoLabel.placeholder = @"";
            MainTableCell.NameLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
            MainTableCell.InfoLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
            return MainTableCell;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self.delegate didSelectFree];
        [self.delegate viewWillAppear:YES];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            [self.delegate didSelectSubjectAtIndex:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
            [self.delegate viewWillAppear:YES];
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0) return 34;
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
	return @"Löschen";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (void)didSelectButton:(int)buttonIndex andIndex:(NSIndexPath *)indexPath {
    
}

- (IBAction)cancel:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
