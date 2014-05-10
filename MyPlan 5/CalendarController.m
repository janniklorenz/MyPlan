    //
//  CalendarController.m
//  TapkuCalendarDemo
//
//  Created by Ben Pearson on 8/01/11.
//  Copyright 2011 Developing in the Dark. All rights reserved.
//

#import "CalendarController.h"
//#import "DataObject.h"
#import "Termin.h"
// change
//#import "ViewController.h"

@implementation CalendarController

@synthesize calendar; 
@synthesize viewController = _viewController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		calendar = 	[[TKCalendarMonthView alloc] init];
		calendar.delegate = self;
		calendar.dataSource = self;
    }
    return self;
}

- (void)reloadCalendar {
	[calendar reload];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 372)];
	self.view.backgroundColor = [UIColor clearColor];
	
	calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
	
	[self.view addSubview:calendar];
	[calendar reload];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
//	NSLog(@"calendarMonthView didSelectDate %@", [d description]);
	// change
//	[self.viewController.self CalViewSelectDate];
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
//	NSLog(@"calendarMonthView monthDidChange");	
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {	
//	NSMutableArray *dataAdd = [NSMutableArray arrayWithObjects:@"2012-01-01 00:00:00 +0000", nil];
//	int x = 0;
//	NSMutableArray *TermineNow = [DataObject LoadTermine];
//	while (x < [TermineNow count]) {
//		NSDate *date = [[TermineNow objectAtIndex:x] dateFrom];
//		
//		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//		[formatter setDateFormat:@"yyyy-MM-dd 00:00:00 +0000"];
//		NSString *stringFromDate = [formatter stringFromDate:date];
//		
//		[dataAdd addObject:stringFromDate];
//		x++;
//	}
//	NSArray *data = [NSArray arrayWithArray:dataAdd];
//	
//	NSMutableArray *marks = [NSMutableArray array];
//	
//	NSCalendar *cal = [NSCalendar currentCalendar];
//	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//	NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) fromDate:startDate];
//	NSDate *d = [cal dateFromComponents:comp];
//	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
//	[offsetComponents setDay:1];	
//	
//	while (YES) {
//		if ([d compare:lastDate] == NSOrderedDescending) break;
//		if ([data containsObject:[d description]]) [marks addObject:[NSNumber numberWithBool:YES]];
//		else [marks addObject:[NSNumber numberWithBool:NO]];
//		
//		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
//	}
	return [NSArray arrayWithObjects:nil];//[NSArray arrayWithArray:marks];
}









#pragma mark -
#pragma mark Rotation

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Disabled rotation for this example
	return NO;
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	
}


@end
