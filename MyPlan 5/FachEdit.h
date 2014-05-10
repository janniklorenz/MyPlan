//
//  SubAddHoureViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 06.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableFile.h"
#import "MainTableFile4.h"
#import "MainTableFile8.h"
#import "MainTableFile9.h"
#import "MainTableFile10.h"

#import "Protocol.h"

@class Subject;
@class FachEditDetail;

@protocol FachEditDelegate <NSObject>
- (void)didEndEditingWithNewSubject:(Subject *)returnSubject;
- (void)didEndEditingWithSubject:(Subject *)returnSubject atIndex:(int)returnIndex;
- (void)didEndWithDeleteAtIndex:(int)returnIndex;
@end

@interface FachEdit : UIViewController <MainTableFileDelegate, MainTableFile4Delegate, MainTableFile8Delegate, MainTableFile9Delegate, MainTableFile10Delegate, UIActionSheetDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    BOOL keyboardIsShown;
    
    Subject *editingSubject;
    int editingSubjectIndex;
    
    NSMutableArray *WeekDays;
    NSMutableArray *Colors1;
    NSMutableArray *Colors2;
    NSMutableArray *Colors3;
    
    FachEditDetail *fachEditDetail;
    
    BOOL newSubject;
    
    id delegate;
}
@property (readwrite) id delegate;

- (void)reloadWithNew;
- (void)reloadWithFach:(Subject *)newSubject atIndex:(int)setIndex;
- (IBAction)cancel:(id)sender;
- (IBAction)chancelAll:(id)sender;

@end
