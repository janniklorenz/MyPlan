//
//  Person.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 04.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Person.h"
#import "Week.h"
#import "Subject.h"
#import "Vertretung.h"
#import "MainData.h"
#import "Info.h"

@implementation Person

@synthesize PersonName;
@synthesize Weeks;
@synthesize PersoniCloudON;
@synthesize PersonID;
@synthesize selectedWeekID;
@synthesize Subjects;
@synthesize Homeworks;
@synthesize Termine;
@synthesize Notizen;


- (id)init {
    self.PersonName = @"";
    self.Weeks = [NSMutableArray arrayWithObjects:[Week newWeekWithName:@"Woche A"], [Week newWeekWithName:@"Woche B"], nil];
    self.PersoniCloudON = NO;
    self.PersonID = @"";
    self.selectedWeekID = @"";
    self.Subjects = [NSMutableArray arrayWithObjects:nil];
    self.Homeworks = [NSMutableArray arrayWithObjects:nil];
    self.Termine = [NSMutableArray arrayWithObjects:nil];
    self.Notizen = [NSMutableArray arrayWithObjects:nil];
    return self;
}
+ (id)newPersonWithName:(NSString *)newPersonName {
    Person *new = [[Person alloc] init];
    new.PersonName = newPersonName;
    new.PersonID = [NSString stringWithFormat:@"%@-%i", new.PersonName, arc4random() %9999999];
    new.selectedWeekID = [[new.Weeks objectAtIndex:0] WeekID];
    new.Subjects = [self normalSubjects];
    return new;
}

- (void)newID {
    PersonID = [NSString stringWithFormat:@"%@-%i", PersonName, arc4random() %9999999];
}


- (Subject *)getSubjectForID:(NSString *)subID onDate:(NSDate *)onDate andHoure:(int)houre inWeek:(Week *)week {
    if ([subID isEqualToString:@"Free"]) return [Subject freeSubject];
    for (int i = 0; i < [[week Vertretungen] count]; i++) {
        if ([[[[week Vertretungen] objectAtIndex:i] SubjectID] isEqualToString:subID] && houre == [[[week Vertretungen] objectAtIndex:i] SubjectHoureIndex]) {
            float x = ([onDate timeIntervalSince1970] - [[[[week Vertretungen] objectAtIndex:i] VertretungsDatum] timeIntervalSince1970]) / (60*60*24);
            if ([MainData dayIndexForDate:onDate] - [MainData dayIndex] < 0) x = x + 7;
            if ([MainData runden:x stellen:0] == 0) {
                Subject *VertretungSubject = [MainData copyObject:[self getSubjectForID:[[[week Vertretungen] objectAtIndex:i] SubjectID]]];
                VertretungSubject.Infos = [[[week Vertretungen] objectAtIndex:i] VertretungInfos];
                VertretungSubject.isVertretung = YES;
                return VertretungSubject;
            }
        }
    }
    return [self getSubjectForID:subID];
}

- (int)getSubjectIndexForID:(NSString *)subID {
    int index = 0;
    for (int i = 0; i < [Subjects count]; i++) if ([[[Subjects objectAtIndex:i] SubjectID] isEqualToString:subID]) index = i;
    return index;
}


- (Subject *)getSubjectForID:(NSString *)subID {
    int index = 0;
    for (int i = 0; i < [Subjects count]; i++) if ([[[Subjects objectAtIndex:i] SubjectID] isEqualToString:subID]) index = i;
    return [Subjects objectAtIndex:index];
}




- (NSMutableArray *)getVertretungenForWeek:(Week *)week {
    return [week Vertretungen];
}
- (void)deleteVertretungForWeek:(Week *)week atIndex:(int)delIndex {
    [[week Vertretungen] removeObjectAtIndex:delIndex];
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:PersonName forKey:@"Person_PersonName"];
    [encoder encodeObject:Weeks forKey:@"Person_Weeks"];
    [encoder encodeBool:PersoniCloudON forKey:@"Person_PersoniCloudON"];
    [encoder encodeObject:PersonID forKey:@"Person_PersonID"];
    [encoder encodeObject:selectedWeekID forKey:@"Person_selectedWeekID"];
    [encoder encodeObject:Subjects forKey:@"Person_Subjects"];
    [encoder encodeObject:Homeworks forKey:@"Person_Homeworks"];
    [encoder encodeObject:Termine forKey:@"Person_Termine"];
    [encoder encodeObject:Notizen forKey:@"Person_Notizen"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.PersonName = [decoder decodeObjectForKey:@"Person_PersonName"];
        self.Weeks = [decoder decodeObjectForKey:@"Person_Weeks"];
        self.PersoniCloudON = [decoder decodeBoolForKey:@"Person_PersoniCloudON"];
        self.PersonID = [decoder decodeObjectForKey:@"Person_PersonID"];
        self.selectedWeekID = [decoder decodeObjectForKey:@"Person_selectedWeekID"];
        self.Subjects = [decoder decodeObjectForKey:@"Person_Subjects"];
        self.Homeworks = [decoder decodeObjectForKey:@"Person_Homeworks"];
        self.Termine = [decoder decodeObjectForKey:@"Person_Termine"];
        self.Notizen = [decoder decodeObjectForKey:@"Person_Notizen"];
        
        if (self.Notizen == nil) self.Notizen = [NSMutableArray arrayWithObjects:nil];
	}
	return self;
}


- (NSString *)getMainNoten {
    float gesNoten = 0;
    float gesWehrtungen = 0;
    for (int i = 0; i < [Subjects count]; i++) {
        if ([[[Subjects objectAtIndex:i] getCompleteNote] floatValue] != 0) {
            gesNoten = gesNoten + [[[Subjects objectAtIndex:i] getCompleteNote] floatValue];
            gesWehrtungen++;
        }
    }
    if (gesWehrtungen == 0) return @"";
    return [NSString stringWithFormat:@"%g", [MainData runden:gesNoten / gesWehrtungen stellen:2]];
}
- (NSString *)getHauptFaecherNoten {
    float gesNoten = 0;
    float gesWehrtungen = 0;
    for (int i = 0; i < [Subjects count]; i++) {
        if ([[[Subjects objectAtIndex:i] getCompleteNote] floatValue] != 0 && [[Subjects objectAtIndex:i] isMainSubject]) {
            gesNoten = gesNoten + [[[Subjects objectAtIndex:i] getCompleteNote] floatValue];
            gesWehrtungen++;
        }
    }
    if (gesWehrtungen == 0) return @"";
    return [NSString stringWithFormat:@"%g", [MainData runden:gesNoten / gesWehrtungen stellen:2]];
}
+ (NSMutableArray *)normalSubjects {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:nil];
    [array addObject:[Subject newSubjectWithName:@"Deutsch"         andShort:@"D"       isMain:YES]];
    [array addObject:[Subject newSubjectWithName:@"Mathe"           andShort:@"M"       isMain:YES]];
    [array addObject:[Subject newSubjectWithName:@"Englisch"         andShort:@"E"       isMain:YES]];
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

@end
