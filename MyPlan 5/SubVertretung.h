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
@class Vertretung;
@class Week;

#import "Protocol.h"

@protocol SubVertretungDelegate <NSObject>
- (void)didCreateVertretung:(Vertretung *)newVertretung;
- (void)didEditVertretung:(Vertretung *)editVertetung atIndex:(int)editungIndex;
- (void)didDeleteVertretungAtIndex:(int)editungIndex;
@end

@interface SubVertretung : UIViewController <MainTableFile8Delegate, MainTableFile11Delegate, UIActionSheetDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    BOOL keyboardIsShown;
    
    int viewingIndex;
    Week *viewingWeek;
    Person *viewingPerson;
    
    Vertretung *editingVertretung;
    int editingVertretungIndex;
    BOOL isNew;
    
    id delegate;
}
@property (readwrite) id delegate;

- (id)init;

- (void)reloadWithVertretung:(Vertretung *)newVertretung andIndex:(int)newEditingIndex andWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex;
- (void)reloadWithNewVertretungAndWeek:(Week *)newWeek AndPerson:(Person *)newPerson AndViewingIndex:(int)newVingingIndex;
- (void)cancel:(id)sender;

@end
