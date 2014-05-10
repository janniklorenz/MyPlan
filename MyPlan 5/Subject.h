//
//  Subject.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface Subject : NSObject <NSCoding> {
    NSString *SubjectName;
    NSString *SubjectShort;
    NSMutableArray *Infos;
    BOOL DayInfosON;
    UIColor *SubjectColor;
    NSString *SubjectID;
    BOOL isMainSubject;
    int CustomColor;
    BOOL isVertretung; // Not Saved
    NSMutableArray *Noten;
    BOOL isFree;
}
@property (readwrite) NSString *SubjectName;
@property (readwrite) NSString *SubjectShort;
@property (readwrite) NSMutableArray *Infos;
@property (readwrite) BOOL DayInfosON;
@property (readwrite) UIColor *SubjectColor;
@property (readwrite) NSString *SubjectID;
@property (readwrite) BOOL isMainSubject;
@property (readwrite) int CustomColor;
@property (readwrite) BOOL isVertretung; // Not Saved
@property (readwrite) NSMutableArray *Noten;
@property (readwrite) BOOL isFree;

- (id)init;
+ (id)newSubjectWithName:(NSString *)newName andShort:(NSString *)shortn isMain:(BOOL)isMain;
+ (id)clearSubject;
+ (id)freeSubject;
- (void)addInfo;

- (NSMutableArray *)homeworksInPerson:(Person *)newPerson;
- (NSMutableArray *)termineInPerson:(Person *)newPerson;

- (void)setRed:(float)red;
- (void)setGreen:(float)green;
- (void)setBlue:(float)blue;
- (void)setAlpha:(float)alpha;
- (float)getRed;
- (float)getGreen;
- (float)getBlue;
- (float)getAlpha;

- (NSMutableArray *)NotizenWithViewingPerson:(Person *)viewingPerson;

- (NSString *)getNotificationTextAtDay:(int)dayIndex;

- (NSString *)getCompleteNote;

- (NSString *)SubjectNameAndShort;

@end
