//
//  CalendarController.h
//  TapkuCalendarDemo
//
//  Created by Ben Pearson on 8/01/11.
//  Copyright 2011 Developing in the Dark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"

@class ViewController;

@interface CalendarController : UIViewController <TKCalendarMonthViewDelegate, TKCalendarMonthViewDataSource> {
	TKCalendarMonthView *calendar;	
}

@property (nonatomic, retain) TKCalendarMonthView *calendar;
@property (strong, nonatomic) ViewController *viewController;

- (void)reloadCalendar;

@end
