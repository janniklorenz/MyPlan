//
//  Notiz.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 30.04.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notiz : NSObject <NSCoding> {
    NSString *NotizName;
    NSDate *NotizDatum;
    UIImage *NotizImage;
    NSString *NotizID;
    NSString *ConnectedSubjectID;
}
@property (readwrite) NSString *NotizName;
@property (readwrite) NSDate *NotizDatum;
@property (nonatomic, retain)UIImage *NotizImage;
@property (readwrite) NSString *NotizID;
@property (readwrite) NSString *ConnectedSubjectID;

+ (id)newNotizWithName:(NSString *)name;

- (void)prepareDelete;
- (UIImage *)NotizImage;
- (void)setNotizImage:(UIImage *)newNotizImage;

- (NSString *)getRest;

- (UIImage *)NotizImageSmall;

@end
