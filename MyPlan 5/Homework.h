//
//  Homework.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 25.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Homework : NSObject <NSCoding> {
    NSString *HomeworkName;
    NSDate *HomeworkDate;
    UIImage *HomeworkImage;
    NSString *ConnectedSubjectID;
    NSString *HomeworkID;
}
@property (readwrite) NSString *HomeworkName;
@property (readwrite) NSDate *HomeworkDate;
@property (nonatomic, retain) UIImage *HomeworkImage;
@property (readwrite) NSString *ConnectedSubjectID;
@property (readwrite) NSString *HomeworkID;

- (id)init;
+ (id)newHomework;

- (NSString *)getRest;

- (UIImage *)HomeworkImageSmall;

- (void)prepareDelete;

@end
