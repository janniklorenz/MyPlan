//
//  Person.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 04.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Subject;
@class Week;

@interface Person : NSObject <NSCoding> {
    NSString *PersonName;
    NSMutableArray *Weeks;
    BOOL PersoniCloudON;
    NSString *PersonID;
    NSString *selectedWeekID;
    NSMutableArray *Subjects;
    NSMutableArray *Homeworks;
    NSMutableArray *Termine;
    NSMutableArray *Notizen; // Seit 5.0.1
}
@property (readwrite) NSString *PersonName;
@property (readwrite) NSMutableArray *Weeks;
@property (readwrite) BOOL PersoniCloudON;
@property (readwrite) NSString *PersonID;
@property (readwrite) NSString *selectedWeekID;
@property (readwrite) NSMutableArray *Subjects;
@property (readwrite) NSMutableArray *Homeworks;
@property (readwrite) NSMutableArray *Termine;
@property (readwrite) NSMutableArray *Notizen; // Seit 5.0.1

- (Subject *)getSubjectForID:(NSString *)subID onDate:(NSDate *)onDate andHoure:(int)houre inWeek:(Week *)week;
- (int)getSubjectIndexForID:(NSString *)subID;
- (Subject *)getSubjectForID:(NSString *)subID;

- (NSMutableArray *)getVertretungenForWeek:(Week *)week;
- (void)deleteVertretungForWeek:(Week *)week atIndex:(int)delIndex;

- (void)newID;

- (NSString *)getMainNoten;
- (NSString *)getHauptFaecherNoten;

- (id)init;
+ (id)newPersonWithName:(NSString *)newPersonName;

@end
