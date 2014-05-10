//
//  Week.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Week.h"
#import "MPDate.h"
#import "Subject.h"
#import "Day.h"
#import "MPDate.h"

@implementation Week

@synthesize WeekName;
@synthesize WeekDuration;
@synthesize WeekDurationNames;
@synthesize WeekMaxHoures;
@synthesize WeekMaxHouresTimes;
@synthesize WeekSubjects;
@synthesize WeekID;
@synthesize Vertretungen;


- (id)init {
    self.WeekName = @"";
    self.WeekDuration = 7;
    self.WeekDurationNames = [NSMutableArray arrayWithObjects:
                              [Day newDayWithName:@"Montag"         andShort:@"Mo"],
                              [Day newDayWithName:@"Dienstag"       andShort:@"Di"],
                              [Day newDayWithName:@"Mittwoch"       andShort:@"Mi"],
                              [Day newDayWithName:@"Donnerstag"     andShort:@"Do"],
                              [Day newDayWithName:@"Freitag"        andShort:@"Fr"],
                              [Day newDayWithName:@"Samstag"        andShort:@"Sa"],
                              [Day newDayWithName:@"Sonntag"        andShort:@"So"], nil];
    self.WeekMaxHoures = 20;
    self.WeekMaxHouresTimes = [self normalTimes];
    self.WeekSubjects = [self normalSubjects];
    self.WeekID = @"";
    self.Vertretungen = [NSMutableArray arrayWithObjects:nil];
    return self;
}
+ (id)newWeekWithName:(NSString *)newName {
    Week *new = [[Week alloc] init];
    new.WeekName = newName;
    new.WeekID = [NSString stringWithFormat:@"%@-%i", new.WeekName, arc4random() %9999999];
    return new;
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




- (NSMutableArray *)normalSubjects {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:nil];
    [array addObject:[Subject newSubjectWithName:@"Deutsch"         andShort:@"D"       isMain:YES]];
    [array addObject:[Subject newSubjectWithName:@"Mathe"           andShort:@"M"       isMain:YES]];
    [array addObject:[Subject newSubjectWithName:@"Enlisch"         andShort:@"E"       isMain:YES]];
    [array addObject:[Subject newSubjectWithName:@"Physik"          andShort:@"Ph"      isMain:YES]];
    [array addObject:[Subject newSubjectWithName:@"Chemie"          andShort:@"Ch"      isMain:YES]];
    [array addObject:[Subject newSubjectWithName:@"Französisch"     andShort:@"F"       isMain:YES]];
    [array addObject:[Subject newSubjectWithName:@"Latein"          andShort:@"La"      isMain:YES]];
    [array addObject:[Subject newSubjectWithName:@"Biologie"        andShort:@"Bio"     isMain:NO]];
    [array addObject:[Subject newSubjectWithName:@"Sport"           andShort:@"Sp"      isMain:NO]];
    [array addObject:[Subject newSubjectWithName:@"Sozialkunde"     andShort:@"Sozial"  isMain:NO]];
    [array addObject:[Subject newSubjectWithName:@"Erdkunde"        andShort:@"Erd"     isMain:NO]];
    [array addObject:[Subject newSubjectWithName:@"Informatik"      andShort:@"IT"      isMain:NO]];
    return array;
}




- (MPDate *)getDateForDay:(int)iday andHoure:(int)ihoure {
    if (iday < [WeekDurationNames count]) {
        if ([[WeekDurationNames objectAtIndex:iday] sameTimes] == YES) {
            if (ihoure < [WeekMaxHouresTimes count]) {
                return [WeekMaxHouresTimes objectAtIndex:ihoure];
            }
        }
        else {
            if (ihoure < [[[WeekDurationNames objectAtIndex:iday] WeekMaxHouresTimes] count]) {
                return [[[WeekDurationNames objectAtIndex:iday] WeekMaxHouresTimes] objectAtIndex:ihoure];
            }
        }
    }
    return [MPDate clearDate];
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:WeekName forKey:@"Week_WeekName"];
	[encoder encodeInt:WeekDuration forKey:@"Week_WeekDuration"];
    [encoder encodeObject:WeekDurationNames forKey:@"Week_WeekDurationNames"];
    [encoder encodeInt:WeekMaxHoures forKey:@"Week_WeekMaxHoures"];
    [encoder encodeObject:WeekMaxHouresTimes forKey:@"Week_WeekMaxHouresTimes"];
    [encoder encodeObject:WeekSubjects forKey:@"Week_WeekSubjects"];
    [encoder encodeObject:WeekID forKey:@"Week_WeekID"];
    [encoder encodeObject:Vertretungen forKey:@"Week_Vertretungen"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.WeekName = [decoder decodeObjectForKey:@"Week_WeekName"];
		self.WeekDuration = [decoder decodeIntForKey:@"Week_WeekDuration"];
        self.WeekDurationNames = [decoder decodeObjectForKey:@"Week_WeekDurationNames"];
        self.WeekMaxHoures = [decoder decodeIntForKey:@"Week_WeekMaxHoures"];
        self.WeekMaxHouresTimes = [decoder decodeObjectForKey:@"Week_WeekMaxHouresTimes"];
        self.WeekSubjects = [decoder decodeObjectForKey:@"Week_WeekSubjects"];
        self.WeekID = [decoder decodeObjectForKey:@"Week_WeekID"];
        self.Vertretungen = [decoder decodeObjectForKey:@"Week_Vertretungen"];
	}
	return self;
}

@end
