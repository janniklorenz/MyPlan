//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "FunktionenTermineDetailDate.h"
#import "MainData.h"

@interface FunktionenTermineDetailDate ()

@end

@implementation FunktionenTermineDetailDate

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[FunktionenTermineDetailDate alloc] initWithNibName:@"FunktionenTermineDetailDate_iPhone" bundle:nil];
    else self = [[FunktionenTermineDetailDate alloc] initWithNibName:@"FunktionenTermineDetailDate_iPad" bundle:nil];
    return self;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) return UIInterfaceOrientationMaskPortrait;
    return UIInterfaceOrientationMaskAll;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    [self changeDate:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)reloadWithDate:(NSDate *)newDate {
    datePicker.date = newDate;
}

- (IBAction)changeDate:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, dd.MM.yyyy"];
    dateLabel.text = [formatter stringFromDate:datePicker.date];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"HH:mm"];
    timeLabel.text = [formatter2 stringFromDate:datePicker.date];
}
- (IBAction)done:(id)sender {
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"ss"];
    NSLog(@"v%@", [formatter2 stringFromDate:datePicker.date]);
    
    [self.delegate doneWithDate:[NSDate dateWithTimeInterval:-[[formatter2 stringFromDate:datePicker.date] intValue] sinceDate:datePicker.date]];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
