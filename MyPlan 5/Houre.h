//
//  Houre.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 05.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Vertretung;

@interface Houre : NSObject <NSCoding> {
    NSString *HoureSubjectID;
    NSString *HoureVertretungsID;
    Vertretung *vertretung;
    BOOL isVertretung;
}
@property (nonatomic) NSString *HoureSubjectID;
@property (readwrite) NSString *HoureVertretungsID;
@property (readwrite) Vertretung *vertretung;
@property (readwrite) BOOL isVertretung;

- (NSString *)HoureSubjectID;
- (void)addVertretungsID:(NSString *)newVertretungsID;
- (void)deleteVertretung;

+ (id)newHoureWithSubjectID:(NSString *)subjID;

@end
