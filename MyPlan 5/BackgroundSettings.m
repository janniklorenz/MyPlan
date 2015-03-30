//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "BackgroundSettings.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"

@interface BackgroundSettings ()

@end

@implementation BackgroundSettings

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[BackgroundSettings alloc] initWithNibName:@"BackgroundSettings_iPhone" bundle:nil];
    else self = [[BackgroundSettings alloc] initWithNibName:@"BackgroundSettings_iPad" bundle:nil];
    return self;
}



- (void)viewDidLoad {
    Files = [NSMutableArray arrayWithObjects:
             @"Natur 1",
             @"Natur 2",
             @"Natur 3",
             @"Natur 4",
             @"Natur 5",
             @"Natur 6",
             @"Natur 7",
             @"Natur 8",
             @"Struktur 1",
             @"Struktur 2",
             @"Struktur 3",
             @"Struktur 4",
             @"Struktur 5",
             @"Struktur 6",
             @"Struktur 7",
             @"Struktur 8",
             @"Strand 1",
             @"Holz 1",
             @"Holz 2", nil];
    
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:return [Files count] + 1;break;
        case 1:return 1;break;
        default:
            break;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // Name
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        if (indexPath.row == 0) {
            MainTableCell.backgroundView = [MainData getViewType:0];
            MainTableCell.selectedBackgroundView = [MainData getViewType:0];
            MainTableCell.custumTextLabel1.text = @"MyPlan Hintergrund";
        }
        else {
            MainTableCell.backgroundView = [MainData getViewType:4];
            MainTableCell.selectedBackgroundView = [MainData getViewType:4];
            MainTableCell.custumTextLabel1.text = [Files objectAtIndex:indexPath.row - 1];
        }
        return MainTableCell;
    }
    else if (indexPath.section == 1) { // iCloud
        MainTableFile2 *MainTableCell = [MainData getCellType:2];
        MainTableCell.custumTextLabel1.text = @"eigenes Hintergrundbild";
        return MainTableCell;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0) {
        [MainData SaveBackgroundImg:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [Files objectAtIndex:indexPath.row - 1]]]];
//        backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
        [self.delegate viewWillAppear:YES];
    }
    else if (indexPath.section == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *picker= [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            // ipad with popover !!!
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [MainData SaveBackgroundImg:image];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != 0) return 30;
    return 44;
}




// Cancel Edit
- (IBAction)cancel:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
