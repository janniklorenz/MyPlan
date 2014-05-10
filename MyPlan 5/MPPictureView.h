//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Protocol.h"

@class CustomScrollView;

@interface MPPictureView : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate, UIDocumentInteractionControllerDelegate> {
    IBOutlet UINavigationBar *navBar;
    IBOutlet CustomScrollView *scrollView;
    IBOutlet UIImageView *imageView;
    IBOutlet UIImageView *backImg;
    
    UIImage *viewingImage;
    NSString *viewingName;
    
    UIDocumentInteractionController *controller;
    
    id delegate;
}
@property (readwrite) id delegate;

- (void)reloadWithImage:(UIImage *)newImage andTitle:(NSString *)newTitle;

- (IBAction)share:(id)sender;
- (IBAction)cancel:(id)sender;

@end
