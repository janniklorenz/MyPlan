//
//  Termin.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 04.03.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;
@class MPNotification;

@interface Termin : NSObject <NSCoding> {
    NSString *TerminName;
    NSDate *TerminDate;
    UIImage *TerminImage;
    NSString *TerminID;
    NSString *ConnectedSubjectID;
    BOOL NotificationEnabled;
    MPNotification *notification;
}
@property (readwrite) NSString *TerminName;
@property (readwrite) NSDate *TerminDate;
@property (nonatomic, retain) UIImage *TerminImage;
@property (readwrite) NSString *TerminID;
@property (readwrite) NSString *ConnectedSubjectID;
@property (nonatomic) BOOL NotificationEnabled;
@property (readwrite) MPNotification *notification;

- (id)init;
+ (id)newTerminOnDate:(NSDate *)newDate;

- (UIColor *)getColorForPerson:(Person *)newPerson;

- (void)prepareDelete;
- (void)hasBeenSaved;

- (NSString *)time;

- (UIImage *)TerminImageSmall;

+ (NSString *)getRestFromDate:(NSDate *)newDate;
- (NSString *)getRest;

@end
