//
//  Day.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 03.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Subject;

@interface Day : NSObject <NSCoding> {
    NSString *DayName;
    NSString *DayShort;
    NSMutableArray *Subjects;
    BOOL sameTimes;
    NSMutableArray *WeekMaxHouresTimes;
}
@property (readwrite) NSString *DayName;
@property (readwrite) NSString *DayShort;
@property (readwrite) NSMutableArray *Subjects;
@property (readwrite) BOOL sameTimes;
@property (readwrite) NSMutableArray *WeekMaxHouresTimes;

- (void)addHoureWithSubject:(Subject *)newSubject;
- (void)addHoureWithSubject:(Subject *)newSubject toIndex:(NSIndexPath *)toIP;

- (id)init;
+ (id)newDayWithName:(NSString *)newName andShort:(NSString *)newShort;

- (NSString *)DayNameAndShort;

@end
