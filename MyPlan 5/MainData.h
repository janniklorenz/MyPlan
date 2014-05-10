//
//  MainData.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppData;
@class Subject;
@class Person;

@interface MainData : NSObject


// --------- Table View --------
+ (NSString *)selectedBackgroundImg;
+ (NSString *)menuBackgroundImg;
+ (id)getCellType:(int)x;
+ (UIView *)getViewWithColor:(UIColor *)col;
+ (UIColor *)getTextColorForBackgroundColor:(UIColor *)back;
+ (UIImage *)getVertretungImgForBackgroundColor:(UIColor *)back;
+ (UIView *)getViewType:(int)x;
// -----------------------------


// ------- Save Load -------
+ (NSString *)SaveImg:(UIImage *)img;

+ (void)SaveMain:(NSMutableArray *)Main;
+ (NSMutableArray *)LoadMain;

+ (void)SaveAppData:(AppData *)AppData;
+ (AppData *)LoadAppData;

+ (id)copyObject:(id)object;

+ (NSString *)SavePersonToSend:(Person *)sendPerson;
+ (Person *)LoadPersonFormSend:(NSURL *)url;

+ (void)SaveBackgroundImg:(UIImage *)image;
// -------------------------

+ (int)daySecondsForDate:(NSDate *)dat;
+ (int)daySeconds;
+ (int)dayIndex;
+ (int)dayIndexForDate:(NSDate *)newDate;
+ (NSDate *)dateForDayIndex:(int)ndeDayIndex;
+ (NSDate *)dayDateForDate:(NSDate *)dat;
+ (NSString *)dayTime;


+ (float)runden:(float)zahl stellen:(int)stellen;
+ (NSString *)kommaDurchPunktErsetzen:(NSString *)Input;

+ (UIImage *)imageWithImage:(UIImage *)image;


// -------

+ (void)saveSmallImg:(UIImage *)img withName:(NSString *)name withFactor:(float)factor;


+ (void)setAdFree:(BOOL)newAdFree;

@end
