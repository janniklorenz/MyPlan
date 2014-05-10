//
//  ViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableFile6.h"
#import "SWRevealViewController.h"
#import <iAd/iAd.h>

@class Person;
@class Week;
@class SubPlanEdit;

@class ViewJetzt;
@class ViewTag;
@class ViewWeek;

@class FunktionenHausaufgabe;
@class FunktionenNoten;
@class FunktionenExport;
@class FunktionenTermine;
@class FunktionenVertretungsplan;
@class FunktionenFotos;
@class FunktionenNotizen;

@protocol WeekViewDelegate <NSObject>
- (void)didSelectWeekEditWithRow:(int)row andPersonRow:(int)row2;
- (void)didSelectButton:(int)buttonIndex andIndex:(NSIndexPath *)indexPath;
@end

@interface WeekView : UIViewController <MainTableFile6Delegate, ADBannerViewDelegate> {
    IBOutlet ADBannerView *banner1;
    
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    
    int viewingIndex;
    Person *viewingPerson;
    Week *viewingWeek;
    
    SubPlanEdit *subPlanEdit;
    
    ViewJetzt *viewJetzt;
    ViewTag *viewTag;
    ViewWeek *viewWeek;
    
    FunktionenHausaufgabe *funktionenHausaufgabe;
    FunktionenNoten *funktionenNoten;
    FunktionenExport *funktionenExport;
    FunktionenTermine *funktionenTermine;
    FunktionenVertretungsplan *funktionenVertretungsplan;
    FunktionenFotos *funktionenFotos;
    FunktionenNotizen *funktionenNotizen;
    
    id delegate;
}
@property (readwrite) ViewTag *viewTag;
@property (readwrite) id delegate;

- (IBAction)toggle:(id)sender;

- (void)reloadViewsWithIndex:(int)index;

@end
