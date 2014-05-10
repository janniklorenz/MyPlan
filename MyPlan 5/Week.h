//
//  Week.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MPDate;
@class Subject;
@class Day;
@class MPDate;

@interface Week : NSObject <NSCoding> {
    NSString *WeekName;
    int WeekDuration;
    NSMutableArray *WeekDurationNames;
    int WeekMaxHoures;
    NSMutableArray *WeekMaxHouresTimes;
    NSMutableArray *WeekSubjects;
    NSString *WeekID;
    NSMutableArray *Vertretungen;
}
@property (readwrite) NSString *WeekName;
@property (readwrite) int WeekDuration;
@property (readwrite) NSMutableArray *WeekDurationNames;
@property (readwrite) int WeekMaxHoures;
@property (readwrite) NSMutableArray *WeekMaxHouresTimes;
@property (readwrite) NSMutableArray *WeekSubjects;
@property (readwrite) NSString *WeekID;
@property (readwrite) NSMutableArray *Vertretungen;

- (id)init;
+ (id)newWeekWithName:(NSString *)newName;

- (MPDate *)getDateForDay:(int)iday andHoure:(int)ihoure;

@end
