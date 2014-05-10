//
//  Houre.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 05.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Houre.h"

@implementation Houre

@synthesize HoureSubjectID;
@synthesize HoureVertretungsID;
@synthesize vertretung;
@synthesize isVertretung;


- (id)init {
    self.HoureSubjectID = @"";
    self.HoureVertretungsID = @"";
    isVertretung = NO;
    return self;
}

+ (id)newHoureWithSubjectID:(NSString *)subjID {
    Houre *new = [[Houre alloc] init];
    new.HoureSubjectID = subjID;
    return new;
}




- (NSString *)HoureSubjectID {
    if (isVertretung && ![HoureVertretungsID isEqualToString:@""]) return HoureVertretungsID;
    return HoureSubjectID;
}




- (void)addVertretungsID:(NSString *)newVertretungsID {
    HoureVertretungsID = newVertretungsID;
    isVertretung = YES;
}





- (void)deleteVertretung {
    HoureVertretungsID = @"";
    isVertretung = NO;
}





- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:HoureSubjectID forKey:@"Houre_HoureSubjectID"];
    [encoder encodeObject:HoureVertretungsID forKey:@"Houre_HoureVertretungsID"];
    [encoder encodeObject:vertretung forKey:@"Houre_vertretung"];
    [encoder encodeBool:isVertretung forKey:@"Houre_isVertretung"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.HoureSubjectID = [decoder decodeObjectForKey:@"Houre_HoureSubjectID"];
        self.HoureVertretungsID = [decoder decodeObjectForKey:@"Houre_HoureVertretungsID"];
        self.vertretung = [decoder decodeObjectForKey:@"Houre_vertretung"];
        self.isVertretung = [decoder decodeBoolForKey:@"Houre_isVertretung"];
	}
	return self;
}

@end
