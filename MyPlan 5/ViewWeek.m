//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "ViewWeek.h"
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
#import "CVCell.h"
#import "MPTapGestureRecognizer.h"
#import "Houre.h"
#import "ViewJetzt.h"

@interface ViewWeek ()

@end

@implementation ViewWeek

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[ViewWeek alloc] initWithNibName:@"ViewWeek_iPhone" bundle:nil];
    else self = [[ViewWeek alloc] initWithNibName:@"ViewWeek_iPad" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    WeekDays2 = [NSMutableArray arrayWithObjects:@"Mo", @"Di", @"Mi", @"Do", @"Fr", @"Sa", @"So", nil];
    self.title = @"Woche";
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeL.direction = UISwipeGestureRecognizerDirectionRight;
    [MenuCollectionView addGestureRecognizer:swipeL];
    
    [MenuCollectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)swipeLeft:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)orientationChanged:(NSNotification *)notification {
    [MenuCollectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    MenuCollectionView.backgroundView = nil;
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    int i = 7;
    int maxNew = 7;
    if ([[[viewingWeek.WeekDurationNames objectAtIndex:6] Subjects] count] == 0) {
        if ([[[viewingWeek.WeekDurationNames objectAtIndex:5] Subjects] count] == 0) maxNew = 5;
        else maxNew = 6;
    }
    
    int oldMax = 0;
    while (i > 0) {
        i--;
        if (i < [viewingWeek.WeekDurationNames count]) {
            if ([[[viewingWeek.WeekDurationNames objectAtIndex:i] Subjects] count] > oldMax) oldMax = [[[viewingWeek.WeekDurationNames objectAtIndex:i] Subjects] count];
        }
    }
    spalten = maxNew + 1;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait && spalten == 8) spalten--;
    maxHoures = oldMax;
    [MenuCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return spalten * (maxHoures + 1) + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cvCell";
    CVCell *cell = (CVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 0.0;
    cell.layer.cornerRadius = 0;
    if (spalten * (maxHoures + 1) > indexPath.row) {
        int day = indexPath.row / spalten;
        
        if (day == 0) {
            if (indexPath.row == 0) cell.titleLabel.text = @"Zeiten";
            else cell.titleLabel.text = [WeekDays2 objectAtIndex:indexPath.row-1];
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
            cell.titleLabel.textColor = [UIColor blackColor];
        }
        else {
            if (indexPath.row % spalten == 0) {
                cell.titleLabel.text = [NSString stringWithFormat:@"%i. %@", day, [[viewingWeek getDateForDay:day-1 andHoure:day-1] getTime]];
                cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
                cell.titleLabel.textColor = [UIColor blackColor];
            }
            else {
                if (day-1 < [[[viewingWeek.WeekDurationNames objectAtIndex:indexPath.row % spalten-1] Subjects] count]) {
                    Subject *rowSubject = [viewingPerson getSubjectForID:[[[[viewingWeek.WeekDurationNames objectAtIndex:indexPath.row % spalten-1] Subjects] objectAtIndex:day-1] HoureSubjectID] onDate:[MainData dateForDayIndex:indexPath.row % spalten-1] andHoure:day-1 inWeek:viewingWeek];
                    cell.titleLabel.text = rowSubject.SubjectShort;
                    cell.backgroundColor = rowSubject.SubjectColor;
                    cell.titleLabel.textColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                    cell.titleLabel.highlightedTextColor = [MainData getTextColorForBackgroundColor:rowSubject.SubjectColor];
                    
                    MPTapGestureRecognizer *singleTapGestureRecognizer = [[MPTapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
                    singleTapGestureRecognizer.numberOfTapsRequired = 1;
                    singleTapGestureRecognizer.delegate = self;
                    singleTapGestureRecognizer.done = NO;
                    singleTapGestureRecognizer.spalte = indexPath.row % spalten-1;
                    singleTapGestureRecognizer.zeile = day-1;
                    [cell addGestureRecognizer:singleTapGestureRecognizer];
                }
                else {
                    cell.titleLabel.text = @"";
                    cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.15];
                }
                
            }
        }
    }
    else {
        cell.titleLabel.text = @"Fertig";
        MPTapGestureRecognizer *singleTapGestureRecognizer = [[MPTapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
        singleTapGestureRecognizer.numberOfTapsRequired = 1;
        singleTapGestureRecognizer.delegate = self;
        singleTapGestureRecognizer.done = YES;
        [cell addGestureRecognizer:singleTapGestureRecognizer];
    }
    return cell;
}

- (void)handleSingleTapGesture:(id)sender {
    if ([sender done]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        if (viewJetzt == nil) viewJetzt = [[ViewJetzt alloc] init];
        [viewJetzt reloadWithViewingIndex:viewingIndex andPerson:viewingPerson andWeek:viewingWeek andDay:[sender spalte] andHoure:[sender zeile]];
        [self.navigationController pushViewController:viewJetzt animated:YES];
    }
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (spalten * (maxHoures + 1) > indexPath.row) {
        int day = indexPath.row / spalten;
        if (day == 0) {
            if (indexPath.row % spalten == 0) return CGSizeMake(MenuCollectionView.frame.size.width/(spalten+3)*3,38);
            else return CGSizeMake(MenuCollectionView.frame.size.width/(spalten+3), 38);
        }
        else {
            if (indexPath.row % spalten == 0) return CGSizeMake(MenuCollectionView.frame.size.width/(spalten+3)*3, 38);
            else return CGSizeMake(MenuCollectionView.frame.size.width/(spalten+3), 44);
        }
    }
    else return CGSizeMake(MenuCollectionView.frame.size.width, 34);
    return CGSizeMake(0, 0);
}


@end
