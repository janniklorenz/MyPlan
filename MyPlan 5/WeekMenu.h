//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekView.h"

@protocol WeekMenuDelegate <NSObject>
@optional
//- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath Long:(BOOL)longPress last:(BOOL)last person:(BOOL)isPerson;
- (void)didSelectWeekWithRow:(int)row andPersonRow:(int)row2;
- (void)didSelectWeekEditWithRow:(int)row andPersonRow:(int)row2;
- (void)didSelectPersonEditWithRow:(int)row;
- (void)didSelectCreateWeek;
- (void)didSelectAddPerson;
- (void)didSelectSettingsWithRow:(int)row;
- (void)enablePersonAtIndex:(int)row2;
- (void)didSelectPerson:(int)row2;
@end

@class WeekView;
@class PersonEdit;
@class AppData;

@interface WeekMenu : UIViewController {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    NSMutableArray *menuContend;
    id delegate;
    
    BOOL selected; // noch implementieren mit gray cell
    int selectedIndex;
    
    NSMutableArray *Persons;
    AppData *appData;
    int openedIndex;
}
@property (readwrite) id delegate;

@end
