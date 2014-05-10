//
//  MPNotification.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 03.03.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Week;
@class Person;
@class Day;
@class Termin;

@interface MPNotification : UILocalNotification <NSCoding> {
    
}

- (id)init;
+ (id)notificationForHoureIndex:(int)houreIndex onDay:(int)dayIndex andDaysFromNow:(int)daysFromNow inWeek:(Week *)viewingWeek andPerson:(Person *)viewingPerson andDay:(Day *)viewingDay;
+ (id)notificationForTermin:(Termin *)newTermin;

+ (void)deleteAllNotifications;

@end
