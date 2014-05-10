//
//  Termin.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 04.03.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Termin.h"
#import "MainData.h"
#import "Person.h"
#import "Subject.h"
#import "MPNotification.h"
#import "AppData.h"

@implementation Termin

@synthesize TerminName;
@synthesize TerminDate;
@synthesize TerminImage;
@synthesize TerminID;
@synthesize ConnectedSubjectID;
@synthesize NotificationEnabled;
@synthesize notification;

- (id)init {
    self.TerminName = @"";
    self.TerminDate = [NSDate date];
    self.TerminImage = nil;
    self.TerminID = @"";
    self.ConnectedSubjectID = @"";
    self.NotificationEnabled = YES;
    return self;
}
+ (id)newTerminOnDate:(NSDate *)newDate {
    Termin *new = [[Termin alloc] init];
    new.TerminDate = newDate;
    new.TerminID = [NSString stringWithFormat:@"Termin%i", arc4random() % 9999999];
    return new;
}


- (UIColor *)getColorForPerson:(Person *)newPerson {
    if (![ConnectedSubjectID isEqualToString:@""]) return [[newPerson getSubjectForID:ConnectedSubjectID] SubjectColor];
    return [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
}


- (void)prepareDelete {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", TerminID]];
    [fileManager removeItemAtPath:path error:NULL];
    NSString *path2 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.jpg", TerminID]];
    [fileManager removeItemAtPath:path2 error:NULL];
}




+ (NSString *)getRestFromDate:(NSDate *)newDate; {
    float restDays = ([[MainData dayDateForDate:newDate] timeIntervalSince1970] - [[MainData dayDateForDate:[NSDate date]] timeIntervalSince1970])/60/60/24;
    restDays = [MainData runden:restDays stellen:2];
    NSString *returnString = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, dd.MM.yyyy"];
    if (restDays < -2) returnString = returnString = [formatter stringFromDate:newDate];
    else if (-2 <= restDays && restDays < -1) returnString = @"Vorgestern";
    else if (-1 <= restDays && restDays < 0) returnString = @"Gestern";
    else if (0 <= restDays && restDays < 1) returnString = @"Heute";
    else if (1 <= restDays && restDays < 2) returnString = @"Morgen";
    else if (2 <= restDays && restDays < 3) returnString = @"Übermorgen";
    else if (3 <= restDays) returnString = [formatter stringFromDate:newDate];
    
    return returnString;
}

- (NSString *)getRest {
    float restDays = ([[MainData dayDateForDate:TerminDate] timeIntervalSince1970] - [[MainData dayDateForDate:[NSDate date]] timeIntervalSince1970])/60/60/24;
    restDays = [MainData runden:restDays stellen:2];
    NSString *returnString = @"";
    if (restDays < -2) returnString = [NSString stringWithFormat:@"vor %g Tagen", [MainData runden:-restDays stellen:0]];
    else if (-2 <= restDays && restDays < -1) returnString = @"Vorgestern";
    else if (-1 <= restDays && restDays < 0) returnString = @"Gestern";
    else if (0 <= restDays && restDays < 1) returnString = @"Heute";
    else if (1 <= restDays && restDays < 2) returnString = @"Morgen";
    else if (2 <= restDays && restDays < 3) returnString = @"Übermorgen";
    else if (3 <= restDays) returnString = [NSString stringWithFormat:@"in %g Tagen", [MainData runden:restDays stellen:0]];
    
    return returnString;
}


- (NSString *)time {
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"HH:mm"];
    return [formatter2 stringFromDate:TerminDate];
}


- (BOOL)NotificationEnabled {
    return NotificationEnabled;
}
- (void)setNotificationEnabled:(BOOL)newNotificationEnabled {
    if (newNotificationEnabled) {
        if (![[[UIApplication sharedApplication] scheduledLocalNotifications] containsObject:notification]) {
            notification = [MPNotification notificationForTermin:self];
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            
            AppData *appData = [MainData LoadAppData];
            if (![appData.TermineNotifications containsObject:notification]) {
                [appData.TermineNotifications addObject:notification];
                [MainData SaveAppData:appData];
            }
        }
    }
    else {
        if ([[[UIApplication sharedApplication] scheduledLocalNotifications] containsObject:notification]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            
            AppData *appData = [MainData LoadAppData];
            if ([appData.TermineNotifications containsObject:notification]) {
                [appData.TermineNotifications removeObject:notification];
                [MainData SaveAppData:appData];
            }
        }
    }
    NotificationEnabled = newNotificationEnabled;
}

- (void)hasBeenSaved {
    if (NotificationEnabled) {
        if ([[[UIApplication sharedApplication] scheduledLocalNotifications] containsObject:notification]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
        AppData *appData = [MainData LoadAppData];
        if ([appData.TermineNotifications containsObject:notification]) {
            [appData.TermineNotifications removeObject:notification];
        }
        notification = [MPNotification notificationForTermin:self];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        [appData.TermineNotifications addObject:notification];
        [MainData SaveAppData:appData];
    }
}




- (UIImage *)TerminImage {
    if ([TerminID isEqualToString:@""] || TerminID == nil) return nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", TerminID]];
    return [UIImage imageWithContentsOfFile:path];
}
- (UIImage *)TerminImageSmall {
    if ([TerminID isEqualToString:@""] || TerminID == nil) return nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.jpg", TerminID]];
    return [UIImage imageWithContentsOfFile:path];
}
- (void)setTerminImage:(UIImage *)newTerminImage {
    if (newTerminImage != nil) {
        [MainData saveSmallImg:newTerminImage withName:[NSString stringWithFormat:@"%@.jpg", TerminID] withFactor:0.8];
        [MainData saveSmallImg:newTerminImage withName:[NSString stringWithFormat:@"%@_small.jpg", TerminID] withFactor:0.3];
    }
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:TerminName forKey:@"Termin_TerminName"];
    [encoder encodeObject:TerminDate forKey:@"Termin_TerminDate"];
    [encoder encodeObject:TerminImage forKey:@"Termin_TerminImage"];
    [encoder encodeObject:TerminID forKey:@"Termin_TerminID"];
    [encoder encodeObject:ConnectedSubjectID forKey:@"Termin_ConnectedSubjectID"];
    [encoder encodeBool:NotificationEnabled forKey:@"Termin_NotificationEnabled"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.TerminName = [decoder decodeObjectForKey:@"Termin_TerminName"];
        self.TerminDate = [decoder decodeObjectForKey:@"Termin_TerminDate"];
        self.TerminImage = [decoder decodeObjectForKey:@"Termin_TerminImage"];
        self.TerminID = [decoder decodeObjectForKey:@"Termin_TerminID"];
        self.ConnectedSubjectID = [decoder decodeObjectForKey:@"Termin_ConnectedSubjectID"];
        self.NotificationEnabled = [decoder decodeBoolForKey:@"Termin_NotificationEnabled"];
	}
	return self;
}

@end
