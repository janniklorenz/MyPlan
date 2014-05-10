//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenFotos.h"
#import "CVCell.h"
#import "CVCell2.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "Week.h"
#import "Subject.h"
#import "MPDate.h"
#import "MPTapGestureRecognizer.h"
#import "WeekEditDetail.h"
#import "WeekEditDetail2.h"
#import "Day.h"
#import "Person.h"
#import "HTMLObject.h"
#import "Houre.h"
#import "Note.h"
#import "Homework.h"
#import "Termin.h"
#import "Note.h"
#import "MPPictureView.h"

@interface FunktionenFotos ()

@end

@implementation FunktionenFotos

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenFotos alloc] initWithNibName:@"FunktionenFotos_iPhone" bundle:nil];
    else self = [[FunktionenFotos alloc] initWithNibName:@"FunktionenFotos_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    self.title = @"Fotos";
    
    [super viewDidLoad];
    
    [FotosCollectionView registerClass:[CVCell2 class] forCellWithReuseIdentifier:@"cvCell2"];
    [FotosCollectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [FotosCollectionView addGestureRecognizer:swipe];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)swipeBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)orientationChanged:(NSNotification *)notification {
    [FotosCollectionView reloadData];
}

- (void)reloadWithViewingIndex:(int)vindex andPerson:(Person *)vperson andWeek:(Week *)vweek {
    viewingIndex = vindex;
    viewingPerson = vperson;
    viewingWeek = vweek;
    
    
    
    
    
    
    Hausaufgaben = [NSMutableArray arrayWithObjects:nil];
    for (int i = 0; i < [viewingPerson.Homeworks count]; i++) if ([[viewingPerson.Homeworks objectAtIndex:i] HomeworkImage] != nil) [Hausaufgaben addObject:[viewingPerson.Homeworks objectAtIndex:i]];
    
    Noten = [NSMutableArray arrayWithObjects:nil];
    for (int i = 0; i < [viewingPerson.Subjects count]; i++) {
        for (int ii = 0; ii < [[[viewingPerson.Subjects objectAtIndex:i] Noten] count]; ii++) {
            if ([[[[viewingPerson.Subjects objectAtIndex:i] Noten] objectAtIndex:ii] NoteImage] != nil) [Noten addObject:[[[viewingPerson.Subjects objectAtIndex:i] Noten] objectAtIndex:ii]];
        }
    }
    
    Termine = [NSMutableArray arrayWithObjects:nil];
    for (int i = 0; i < [viewingPerson.Termine count]; i++) if ([[viewingPerson.Termine objectAtIndex:i] TerminImage] != nil) [Termine addObject:[viewingPerson.Termine objectAtIndex:i]];
    

    
    
    [FotosCollectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    FotosCollectionView.backgroundView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        if ([Hausaufgaben count] == 0) return 0;
        else return [Hausaufgaben count] + 1;
    }
    else if (section == 1) {
        if ([Noten count] == 0) return 0;
        else return [Noten count] + 1;
    }
    else if (section == 2) {
        if ([Termine count] == 0) return 0;
        else return [Termine count] + 1;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"cvCell";
        CVCell *cell = (CVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.layer.borderWidth = 0.0;
        cell.layer.cornerRadius = 0;
        
        if (indexPath.section == 0) cell.titleLabel.text = @"Hausaufgaben";
        else if (indexPath.section == 1) cell.titleLabel.text = @"Noten";
        else if (indexPath.section == 2) cell.titleLabel.text = @"Termine";
        
        cell.titleLabel.font = [UIFont systemFontOfSize:22];
        cell.titleLabel.textColor = [UIColor whiteColor];
        
        return cell;
    }
    else {
        static NSString *cellIdentifier = @"cvCell2";
        CVCell2 *cell = (CVCell2 *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.layer.borderColor = [UIColor blackColor].CGColor;
        cell.layer.borderWidth = 0.0;
        cell.layer.cornerRadius = 0;
        
        if (indexPath.section == 0) {
            cell.titleLabel.text = [[Hausaufgaben objectAtIndex:indexPath.row-1] HomeworkName];
            cell.backImg.image = [[Hausaufgaben objectAtIndex:indexPath.row-1] HomeworkImageSmall];
        }
        else if (indexPath.section == 1) {
            cell.titleLabel.text = [[Noten objectAtIndex:indexPath.row-1] NoteNotiz];
            cell.backImg.image = [[Noten objectAtIndex:indexPath.row-1] NoteImageSmall];
        }
        else if (indexPath.section == 2) {
            cell.titleLabel.text = [[Termine objectAtIndex:indexPath.row-1] TerminName];
            cell.backImg.image = [[Termine objectAtIndex:indexPath.row-1] TerminImageSmall];
        }
        
        cell.backImg.backgroundColor = [UIColor clearColor];
        cell.layer.cornerRadius = 5;
        cell.backImg.clipsToBounds = YES;
        
        MPTapGestureRecognizer *singleTapGestureRecognizer = [[MPTapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
        singleTapGestureRecognizer.numberOfTapsRequired = 1;
        singleTapGestureRecognizer.delegate = self;
        singleTapGestureRecognizer.indexPath = indexPath;
        [cell addGestureRecognizer:singleTapGestureRecognizer];
        
        return cell;
    }
}

- (void)handleSingleTapGesture:(id)sender {
    if (pictureView == nil) pictureView = [[MPPictureView alloc] init];
    if ([sender indexPath].section == 0) {
        [pictureView reloadWithImage:[[Hausaufgaben objectAtIndex:[sender indexPath].row-1] HomeworkImage] andTitle:[[Hausaufgaben objectAtIndex:[sender indexPath].row-1] HomeworkName]];
    }
    else if ([sender indexPath].section == 1) {
        [pictureView reloadWithImage:[[Noten objectAtIndex:[sender indexPath].row-1] NoteImage] andTitle:[[Noten objectAtIndex:[sender indexPath].row-1] NoteNotiz]];
    }
    else if ([sender indexPath].section == 2) {
        [pictureView reloadWithImage:[[Termine objectAtIndex:[sender indexPath].row-1] TerminImage] andTitle:[[Termine objectAtIndex:[sender indexPath].row-1] TerminName]];
    }
    [self presentViewController:pictureView animated:YES completion:NULL];
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
            if (indexPath.row == 0) return CGSizeMake(self.view.frame.size.width-20, 45);
            else return CGSizeMake(150, 220);
        }
        else {
            if (indexPath.row == 0) return CGSizeMake(self.view.frame.size.width-20, 45);
            else return CGSizeMake((self.view.frame.size.width-20)/2, 150);
        }
    }
    else {
        if (indexPath.row == 0) return CGSizeMake(self.view.frame.size.width-20, 45);
        else return CGSizeMake(150, 220);
    }
    
    
    
    
    return CGSizeMake(0, 0);
}




@end
