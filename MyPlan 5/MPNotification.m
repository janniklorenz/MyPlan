//
//  MPNotification.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 03.03.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "MPNotification.h"
#import "Houre.h"
#import "MainData.h"
#import "MPDate.h"
#import "Week.h"
#import "AppData.h"
#import "Person.h"
#import "Day.h"
#import "Subject.h"
#import "Termin.h"

@implementation MPNotification

- (id)init {
    return self;
}

+ (id)notificationForHoureIndex:(int)houreIndex onDay:(int)dayIndex andDaysFromNow:(int)daysFromNow inWeek:(Week *)viewingWeek andPerson:(Person *)viewingPerson andDay:(Day *)viewingDay {
    MPNotification *new = [[MPNotification alloc] init];
    AppData *appData = [MainData LoadAppData];
    
    
    NSDate *fireDate = [NSDate dateWithTimeInterval:
                        [[viewingWeek getDateForDay:dayIndex andHoure:houreIndex] fromSec] + daysFromNow*24*60*60 - appData.MinutesBevor*60 sinceDate:
                        [MainData dayDateForDate:[MainData dateForDayIndex:[MainData dayIndex]]]];
     
    if ([fireDate timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970] || appData.HouresOn == NO) return new;
    
    for (int i = 0; i < [appData.Notifications count]; i++) {
        int t1 = [[appData.Notifications objectAtIndex:i] timeIntervalSince1970];
        int t2 = [fireDate timeIntervalSince1970];
        if (t1 == t2) return new;
        if ([[appData.Notifications objectAtIndex:i] timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970]) {
            [appData.Notifications removeObjectAtIndex:i];
            [MainData SaveAppData:appData];
        }
    }
    
    [appData.Notifications addObject:fireDate];
    [MainData SaveAppData:appData];
    
    [new setFireDate:fireDate];
	[new setTimeZone:[NSTimeZone defaultTimeZone]];
	NSArray *array = [NSArray arrayWithObjects:@"OK", @"", nil];
	NSDictionary *data = [NSDictionary dictionaryWithObject:array forKey:@"payload"];
	[new setUserInfo:data];
	[new setAlertAction:@"öffnen"];
	[new setHasAction:YES];
    
    Subject *rowSubject = [viewingPerson getSubjectForID:[[viewingDay.Subjects objectAtIndex:houreIndex] HoureSubjectID] onDate:[MainData dateForDayIndex:dayIndex] andHoure:houreIndex inWeek:viewingWeek];
    
    NSString *body = [rowSubject getNotificationTextAtDay:dayIndex];
	[new setAlertBody:body];
	
    
	[[UIApplication sharedApplication] scheduleLocalNotification:new];
    return new;
}



+ (id)notificationForTermin:(Termin *)newTermin {
    MPNotification *new = [[MPNotification alloc] init];
    AppData *appData = [MainData LoadAppData];
    
    NSDate *fireDate = newTermin.TerminDate;
    
    if ([fireDate timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970] || appData.TermineOn == NO || newTermin.NotificationEnabled == NO) return new;
    
    [appData.Notifications addObject:fireDate];
    [MainData SaveAppData:appData];
    
    [new setFireDate:fireDate];
	[new setTimeZone:[NSTimeZone defaultTimeZone]];
	NSArray *array = [NSArray arrayWithObjects:@"OK", @"", nil];
	NSDictionary *data = [NSDictionary dictionaryWithObject:array forKey:@"payload"];
	[new setUserInfo:data];
	[new setAlertAction:@"öffnen"];
	[new setHasAction:YES];
    
//    NSString *fachBody = @"";
//    if (![newTermin.ConnectedSubjectID isEqualToString:@""]) fachBody = [NSString stringWithFormat:@"\n Fach: "];
    
    NSString *body = [NSString stringWithFormat:@"Termin: %@", [newTermin TerminName]];
	[new setAlertBody:body];
	
	[[UIApplication sharedApplication] scheduleLocalNotification:new];
    return new;
}


+ (void)deleteAllNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    AppData *appData = [MainData LoadAppData];
    appData.Notifications = [NSMutableArray arrayWithObjects:nil];
    [MainData SaveAppData:appData];
    
    for (int i = 0; i < [appData.TermineNotifications count]; i++) [[UIApplication sharedApplication] scheduleLocalNotification:[appData.TermineNotifications objectAtIndex:i]];
}




- (void)encodeWithCoder:(NSCoder *)encoder {
//	[encoder encodeObject:MPNotificationID forKey:@"MPNotification_MPNotificationID"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
//		self.MPNotificationID = [decoder decodeObjectForKey:@"MPNotification_MPNotificationID"];
	}
	return self;
}

@end
