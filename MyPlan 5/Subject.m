//
//  Subject.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Subject.h"
#import "Info.h"
#import "Note.h"
#import "MainData.h"
#import "Person.h"
#import "Homework.h"
#import "Termin.h"

@implementation Subject

@synthesize SubjectName;
@synthesize SubjectShort;
@synthesize Infos;
@synthesize DayInfosON;
@synthesize SubjectColor;
@synthesize SubjectID;
@synthesize isMainSubject;
@synthesize CustomColor;
@synthesize isVertretung; // Not Saved
@synthesize Noten;
@synthesize isFree;


- (id)init {
    self.SubjectName = @"";
    self.SubjectShort = @"";
    
    self.Infos = [NSMutableArray arrayWithObjects:nil];
    [Infos addObject:[Info newInfoWithName:@"Raum" andRunEdit:NO]];
    [Infos addObject:[Info newInfoWithName:@"Lehrer" andRunEdit:NO]];
    [Infos addObject:[Info newInfoWithName:@"Notiz" andRunEdit:YES]];
    self.SubjectColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    self.SubjectID = @"";
    self.isMainSubject = NO;
    self.CustomColor = 0; // 0=NO; 1=YES
    self.isVertretung = NO;
    self.Noten = [NSMutableArray arrayWithObjects:nil];
    self.isFree = NO;
    return self;
}
+ (id)newSubjectWithName:(NSString *)newName andShort:(NSString *)shortn  isMain:(BOOL)isMain {
    Subject *new = [[Subject alloc] init];
    new.SubjectName = newName;
    new.SubjectShort = shortn;
    new.SubjectID = [NSString stringWithFormat:@"%@%i", newName, arc4random() % 9999999];
    new.isMainSubject = isMain;
    return new;
}
+ (id)clearSubject {
    Subject *new = [[Subject alloc] init];
    new.SubjectName = @"";
    new.SubjectShort = @"";
    return new;
}
+ (id)freeSubject {
    Subject *new = [[Subject alloc] init];
    new.SubjectName = @"(Frei)";
    new.SubjectShort = @"";
    new.SubjectColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.15];
    new.isFree = YES;
    new.SubjectID = @"Free";
    return new;
}

- (NSMutableArray *)NotizenWithViewingPerson:(Person *)viewingPerson {
    NSMutableArray *returnArray = [NSMutableArray arrayWithObjects:nil];
    for (int i = 0; i < [viewingPerson.Notizen count]; i++) if ([[[viewingPerson.Notizen objectAtIndex:i] ConnectedSubjectID] isEqualToString:SubjectID]) [returnArray addObject:[viewingPerson.Notizen objectAtIndex:i]];
    return returnArray;
}


- (NSMutableArray *)homeworksInPerson:(Person *)newPerson {
    NSMutableArray *returnArray = [NSMutableArray arrayWithObjects:nil];
    for (int i = 0; i < [newPerson.Homeworks count]; i++) {
        if ([[[newPerson.Homeworks objectAtIndex:i] ConnectedSubjectID] isEqualToString:SubjectID]) [returnArray addObject:[newPerson.Homeworks objectAtIndex:i]];
    }
    return returnArray;
}
- (NSMutableArray *)termineInPerson:(Person *)newPerson {
    NSMutableArray *returnArray = [NSMutableArray arrayWithObjects:nil];
    for (int i = 0; i < [newPerson.Termine count]; i++) {
        if ([[[newPerson.Termine objectAtIndex:i] ConnectedSubjectID] isEqualToString:SubjectID]) [returnArray addObject:[newPerson.Termine objectAtIndex:i]];
    }
    return returnArray;
}


- (NSString *)getNotificationTextAtDay:(int)dayIndex {
    NSString *completeString = [NSString stringWithFormat:@"Nächste Stunde: %@", SubjectName];
    
    for (int i = 0; i < [Infos count]; i++) {
        if (![[[Infos objectAtIndex:i] getInfoForDay:dayIndex] isEqualToString:@""]) completeString = [NSString stringWithFormat:@"%@\n%@: %@", completeString, [[Infos objectAtIndex:i] InfoName], [[Infos objectAtIndex:i] getInfoForDay:dayIndex]];
    }
    
    return completeString;
}




- (NSString *)getCompleteNote {
    float gesNoten = 0;
    float gesWehrtungen = 0;
    for (int i = 0; i < [Noten count]; i++) {
        if ([[Noten objectAtIndex:i] isEnabled]) {
            gesNoten = gesNoten + ([[Noten objectAtIndex:i] NoteWert]*[[Noten objectAtIndex:i] NoteWertung]);
            gesWehrtungen = gesWehrtungen + [[Noten objectAtIndex:i] NoteWertung];
        }
    }
    if (gesWehrtungen == 0) return @"";
    return [NSString stringWithFormat:@"%g", [MainData runden:gesNoten / gesWehrtungen stellen:2]];
}
- (NSString *)SubjectNameAndShort {
    if (![SubjectShort isEqualToString:@""]) return [NSString stringWithFormat:@"%@ (%@)", SubjectName, SubjectShort];
    return SubjectName;
}




- (void)setRed:(float)red {
    const CGFloat* components = CGColorGetComponents(SubjectColor.CGColor);
    SubjectColor = [UIColor colorWithRed:red green:components[1] blue:components[2] alpha:components[3]];
}
- (void)setGreen:(float)green {
    const CGFloat* components = CGColorGetComponents(SubjectColor.CGColor);
    SubjectColor = [UIColor colorWithRed:components[0] green:green blue:components[2] alpha:components[3]];
}
- (void)setBlue:(float)blue {
    const CGFloat* components = CGColorGetComponents(SubjectColor.CGColor);
    SubjectColor = [UIColor colorWithRed:components[0] green:components[1] blue:blue alpha:components[3]];
}
- (void)setAlpha:(float)alpha {
    const CGFloat* components = CGColorGetComponents(SubjectColor.CGColor);
    SubjectColor = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:alpha];
}




- (float)getRed {
    const CGFloat* components = CGColorGetComponents(SubjectColor.CGColor);
    return components[0];
}
- (float)getGreen {
    const CGFloat* components = CGColorGetComponents(SubjectColor.CGColor);
    return components[1];
}
- (float)getBlue {
    const CGFloat* components = CGColorGetComponents(SubjectColor.CGColor);
    return components[2];
}
- (float)getAlpha {
    const CGFloat* components = CGColorGetComponents(SubjectColor.CGColor);
    return components[3];
}




- (void)addInfo {
    [Infos addObject:[Info newInfoWithName:@"Neue Info" andRunEdit:NO]];
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:SubjectName forKey:@"Subject_SubjectName"];
    [encoder encodeObject:SubjectShort forKey:@"Subject_SubjectShort"];
    [encoder encodeObject:Infos forKey:@"Subject_Infos"];
    [encoder encodeBool:DayInfosON forKey:@"Subject_DayInfosON"];
    [encoder encodeObject:SubjectColor forKey:@"Subject_SubjectColor"];
    [encoder encodeObject:SubjectID forKey:@"Subject_SubjectID"];
    [encoder encodeBool:isMainSubject forKey:@"Subject_isMainSubject"];
    [encoder encodeInt:CustomColor forKey:@"Subject_CustomColor"];
    [encoder encodeObject:Noten forKey:@"Subject_Noten"];
    [encoder encodeBool:isFree forKey:@"Subject_isFree"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.SubjectName = [decoder decodeObjectForKey:@"Subject_SubjectName"];
        self.SubjectShort = [decoder decodeObjectForKey:@"Subject_SubjectShort"];
        self.Infos = [decoder decodeObjectForKey:@"Subject_Infos"];
        self.DayInfosON = [decoder decodeBoolForKey:@"Subject_DayInfosON"];
        self.SubjectColor = [decoder decodeObjectForKey:@"Subject_SubjectColor"];
        self.SubjectID = [decoder decodeObjectForKey:@"Subject_SubjectID"];
        self.isMainSubject = [decoder decodeBoolForKey:@"Subject_isMainSubject"];
        self.CustomColor = [decoder decodeIntForKey:@"Subject_CustomColor"];
        self.Noten = [decoder decodeObjectForKey:@"Subject_Noten"];
        self.isFree = [decoder decodeBoolForKey:@"Subject_isFree"];
        
        // Variablen neu nach 5.0
	}
	return self;
}

@end
