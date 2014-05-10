//
//  MPDate.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "MPDate.h"

@implementation MPDate

@synthesize startMinute;
@synthesize startHoure;
@synthesize stopMinute;
@synthesize stopHoure;
@synthesize isClear;


- (id)init {
    self.startMinute = 0;
    self.startHoure = 0;
    self.stopMinute = 0;
    self.stopHoure = 0;
    return self;
}
+ (id)newTimeFromHoure:(int)fH andMinute:(int)fM toHoure:(int)tH andMinute:(int)tM {
    MPDate *new = [[MPDate alloc] init];
    new.startMinute = fM;
    new.startHoure = fH;
    new.stopMinute = tM;
    new.stopHoure = tH;
    new.isClear = NO;
    return new;
}
+ (id)clearDate {
    MPDate *new = [[MPDate alloc] init];
    new.isClear = YES;
    return new;
}




- (NSString *)makeZeros:(int)value {
    if (value < 10) return [NSString stringWithFormat:@"0%i", value];
    return [NSString stringWithFormat:@"%i", value];
}
- (NSString *)getTime {
    if (isClear) return @"";
    return [NSString stringWithFormat:@"%@ - %@", self.from, self.to];
}
- (NSString *)from {
    if (isClear) return @"";
    return [NSString stringWithFormat:@"%@:%@", [self makeZeros:startHoure], [self makeZeros:startMinute]];
}
- (NSString *)to {
    if (isClear) return @"";
    return [NSString stringWithFormat:@"%@:%@", [self makeZeros:stopHoure], [self makeZeros:stopMinute]];
}




- (int)fromSec {
    return startHoure*60*60 + startMinute*60;
}
- (int)toSec {
    return stopHoure*60*60 + stopMinute*60;
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeInt:startMinute forKey:@"MPDate_startMinute"];
    [encoder encodeInt:startHoure forKey:@"MPDate_startHoure"];
    [encoder encodeInt:stopMinute forKey:@"MPDate_stopMinute"];
    [encoder encodeInt:stopHoure forKey:@"MPDate_stopHoure"];
    [encoder encodeBool:isClear forKey:@"MPDate_isClear"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.startMinute = [decoder decodeIntForKey:@"MPDate_startMinute"];
        self.startHoure = [decoder decodeIntForKey:@"MPDate_startHoure"];
        self.stopMinute = [decoder decodeIntForKey:@"MPDate_stopMinute"];
        self.stopHoure = [decoder decodeIntForKey:@"MPDate_stopHoure"];
        self.isClear = [decoder decodeBoolForKey:@"MPDate_isClear"];
	}
	return self;
}




+ (NSString *)getMinSecFormated:(float)duration {
    float min = duration/60;
    int minInt = min;
    if (minInt >= 60) {
        float h = minInt/60;
        int hInt = h;
        if (h == 1) return [NSString stringWithFormat:@"%i Stunde", hInt];
        else return [NSString stringWithFormat:@"%i Stunden", hInt];
    }
    if (minInt+1 == 1) return [NSString stringWithFormat:@"%i Minute", minInt+1];
    return [NSString stringWithFormat:@"%i Minuten", minInt+1];
}

@end
