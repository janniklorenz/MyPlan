//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableFile8.h"
#import "MainTableFile11.h"

@class Person;
@class Notiz;
@class Week;
@class MPPictureView;
@class SubAddHoureViewController;

#import "Protocol.h"

@interface FunktionenNotizDetail : UIViewController <MainTableFile8Delegate, MainTableFile11Delegate, UIActionSheetDelegate, UINavigationControllerDelegate,  UIImagePickerControllerDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    BOOL keyboardIsShown;
    
    int viewingIndex;
    Week *viewingWeek;
    Person *viewingPerson;
    
    Notiz *editingNotiz;
    int editingNotizIndex;
    BOOL isNew;
    
    int oldHeight;
    UITextView *typeTextView;
    
    id delegate;
    
    MPPictureView *pictureView;
    
    SubAddHoureViewController *subAddHoureViewController;
    
}
@property (readwrite) id delegate;

- (id)init;

- (void)reloadWithNotiz:(Notiz *)newNotiz andIndex:(int)newEditingIndex andWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex;
- (void)reloadWithNewNotizInWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex;
- (void)reloadWithNewNotizInWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex andSubjectID:(NSString *)subID;
- (IBAction)cancelAdd:(id)sender;
- (IBAction)saveAdd:(id)sender;

- (IBAction)share:(id)sender;

@end
