//
//  MPDate.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPDate : NSObject <NSCoding> {
    int startMinute;
    int startHoure;
    int stopMinute;
    int stopHoure;
    BOOL isClear;
}
@property (readwrite) int startMinute;
@property (readwrite) int startHoure;
@property (readwrite) int stopMinute;
@property (readwrite) int stopHoure;
@property (readwrite) BOOL isClear;

- (id)init;
+ (id)newTimeFromHoure:(int)fH andMinute:(int)fM toHoure:(int)tH andMinute:(int)tM;
+ (id)clearDate;

- (NSString *)getTime;
- (NSString *)from;
- (NSString *)to;

- (int)fromSec;
- (int)toSec;

+ (NSString *)getMinSecFormated:(float)duration;

@end
