//
//  Day.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 03.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Day.h"
#import "MPDate.h"
#import "Subject.h"
#import "Houre.h"

@implementation Day

@synthesize DayName;
@synthesize DayShort;
@synthesize Subjects;
@synthesize sameTimes;
@synthesize WeekMaxHouresTimes;


- (id)init {
    self.DayName = @"";
    self.Subjects = [NSMutableArray arrayWithObjects:nil];
    self.sameTimes = YES;
    self.WeekMaxHouresTimes = [self normalTimes];
    return self;
}
+ (id)newDayWithName:(NSString *)newName andShort:(NSString *)newShort {
    Day *new = [[Day alloc] init];
    new.DayName = newName;
    new.DayShort = newShort;
    return new;
}




- (NSString *)DayNameAndShort {
    return [NSString stringWithFormat:@"%@ (%@)", DayName, DayShort];
}




- (NSMutableArray *)normalTimes {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:nil];
    [array addObject:[MPDate newTimeFromHoure:8 andMinute:0 toHoure:8 andMinute:45]];
    [array addObject:[MPDate newTimeFromHoure:8 andMinute:45 toHoure:9 andMinute:30]];
    [array addObject:[MPDate newTimeFromHoure:9 andMinute:45 toHoure:10 andMinute:30]];
    [array addObject:[MPDate newTimeFromHoure:10 andMinute:30 toHoure:11 andMinute:15]];
    [array addObject:[MPDate newTimeFromHoure:11 andMinute:30 toHoure:12 andMinute:15]];
    [array addObject:[MPDate newTimeFromHoure:12 andMinute:15 toHoure:13 andMinute:0]];
    [array addObject:[MPDate newTimeFromHoure:13 andMinute:20 toHoure:13 andMinute:55]];
    [array addObject:[MPDate newTimeFromHoure:13 andMinute:55 toHoure:14 andMinute:40]];
    return array;
}




- (void)addHoureWithSubject:(Subject *)newSubject {
    [Subjects addObject:[Houre newHoureWithSubjectID:newSubject.SubjectID]];
}
- (void)addHoureWithSubject:(Subject *)newSubject toIndex:(NSIndexPath *)toIP {
    [Subjects insertObject:[Houre newHoureWithSubjectID:newSubject.SubjectID] atIndex:toIP.row];
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:DayName forKey:@"Day_DayName"];
    [encoder encodeObject:DayShort forKey:@"Day_DayShort"];
    [encoder encodeObject:Subjects forKey:@"Day_Subjects"];
    [encoder encodeBool:sameTimes forKey:@"Day_sameTimes"];
    [encoder encodeObject:WeekMaxHouresTimes forKey:@"Day_WeekMaxHouresTimes"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.DayName = [decoder decodeObjectForKey:@"Day_DayName"];
        self.DayShort = [decoder decodeObjectForKey:@"Day_DayShort"];
        self.Subjects = [decoder decodeObjectForKey:@"Day_Subjects"];
        self.sameTimes = [decoder decodeBoolForKey:@"Day_sameTimes"];
        self.WeekMaxHouresTimes = [decoder decodeObjectForKey:@"Day_WeekMaxHouresTimes"];
	}
	return self;
}

@end
