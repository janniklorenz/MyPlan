//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "MPPictureView.h"
#import "CustomScrollView.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"

@interface MPPictureView ()

@end

@implementation MPPictureView

@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[MPPictureView alloc] initWithNibName:@"MPPictureView_iPhone" bundle:nil];
    else self = [[MPPictureView alloc] initWithNibName:@"MPPictureView_iPad" bundle:nil];
    return self;
}




- (void)viewDidLoad {
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setCanCancelContentTouches:NO];
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    scrollView.minimumZoomScale = 1;
    scrollView.maximumZoomScale = 100;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollView.delegate = self;
    [scrollView setContentSize:imageView.frame.size];
    
    imageView.image = viewingImage;
    navBar.topItem.title = viewingName;
    
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    imageView.image = viewingImage;
    navBar.topItem.title = viewingName;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (void)reloadWithImage:(UIImage *)newImage andTitle:(NSString *)newTitle {
    viewingImage = newImage;
    viewingName = newTitle;
}





- (void)scrollViewWillBeginZooming:(UIScrollView *)scroll withView:(UIView *)view {
    scrollView.scrollEnabled = NO;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scroll withView:(UIView *)view atScale:(double)scale {
    scrollView.scrollEnabled = YES;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scroll {
	return imageView;
}


- (IBAction)share:(id)sender {
    UIActionSheet *ImportActionSheet = [[UIActionSheet alloc]
                                        initWithTitle:nil
                                        delegate:self
                                        cancelButtonTitle:@"Abbrechen"
                                        destructiveButtonTitle:nil
                                        otherButtonTitles:@"Bild speichern", @"Bild öffnen", nil];
    ImportActionSheet.tag = 2;
    [ImportActionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIdx {
    if (actionSheet.tag == 2) {
        if (buttonIdx == 0) { // Bild Speichern
            UIImageWriteToSavedPhotosAlbum(viewingImage, nil, nil, nil);
        }
        else if (buttonIdx == 1) {
            controller = [UIDocumentInteractionController interactionControllerWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@.jpg", [NSURL fileURLWithPath:[MainData SaveImg:viewingImage]]]]];
            
            CGRect navRect = self.navigationController.navigationBar.frame;
            navRect.size = CGSizeMake(1500.0f, 40.0f);
            [controller presentOptionsMenuFromRect:navRect inView:self.view animated:YES];
        }
    }
}






- (IBAction)cancel:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
