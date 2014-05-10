//
//  Homework.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 25.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Homework.h"
#import "MainData.h"

@implementation Homework

@synthesize HomeworkName;
@synthesize HomeworkDate;
@synthesize HomeworkImage;
@synthesize ConnectedSubjectID;
@synthesize HomeworkID;

- (id)init {
    self.HomeworkName = @"";
    self.HomeworkDate = [NSDate date];
    self.ConnectedSubjectID = @"";
    self.HomeworkID = [NSString stringWithFormat:@"Homework%i", arc4random() % 9999999];
    return self;
}
+ (id)newHomework {
    Homework *new = [[Homework alloc] init];
    return new;
}




- (NSString *)getRest {
    float restDays = ([[MainData dayDateForDate:HomeworkDate] timeIntervalSince1970] - [[MainData dayDateForDate:[NSDate date]] timeIntervalSince1970])/60/60/24;
    restDays = [MainData runden:restDays stellen:2];
    NSString *returnString = @"";
    if (restDays < -2) returnString = [NSString stringWithFormat:@"vor %g Tagen", [MainData runden:-restDays stellen:0]];
    else if (-2 <= restDays && restDays < -1) returnString = @"Vorgestern";
    else if (-1 <= restDays && restDays < 0) returnString = @"Gestern";
    else if (0 <= restDays && restDays < 1) returnString = @"Heute";
    else if (1 <= restDays && restDays < 2) returnString = @"Morgen";
    else if (2 <= restDays && restDays < 3) returnString = @"Übermorgen";
    else if (3 <= restDays) returnString = [NSString stringWithFormat:@"in %g Tagen", [MainData runden:restDays stellen:0]];
    
    return returnString;
}




- (void)prepareDelete {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", HomeworkID]];
    [fileManager removeItemAtPath:path error:NULL];
    NSString *path2 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.jpg", HomeworkID]];
    [fileManager removeItemAtPath:path2 error:NULL];
}




- (UIImage *)HomeworkImage {
    if ([HomeworkID isEqualToString:@""] || HomeworkID == nil) return nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", HomeworkID]];
    return [UIImage imageWithContentsOfFile:path];
}
- (UIImage *)HomeworkImageSmall {
    if ([HomeworkID isEqualToString:@""] || HomeworkID == nil) return nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.jpg", HomeworkID]];
    return [UIImage imageWithContentsOfFile:path];
}
- (void)setHomeworkImage:(UIImage *)newHomeworkImage {
    if (newHomeworkImage != nil) {
        [MainData saveSmallImg:newHomeworkImage withName:[NSString stringWithFormat:@"%@.jpg", HomeworkID] withFactor:0.8];
        [MainData saveSmallImg:newHomeworkImage withName:[NSString stringWithFormat:@"%@_small.jpg", HomeworkID] withFactor:0.3];
    }
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:HomeworkName forKey:@"Homework_HomeworkName"];
    [encoder encodeObject:HomeworkDate forKey:@"Homework_HomeworkDate"];
    [encoder encodeObject:HomeworkImage forKey:@"Homework_HomeworkImage"];
    [encoder encodeObject:ConnectedSubjectID forKey:@"Homework_ConnectedSubjectID"];
    [encoder encodeObject:HomeworkID forKey:@"Homework_HomeworkID"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.HomeworkName = [decoder decodeObjectForKey:@"Homework_HomeworkName"];
        self.HomeworkDate = [decoder decodeObjectForKey:@"Homework_HomeworkDate"];
        self.HomeworkImage = [decoder decodeObjectForKey:@"Homework_HomeworkImage"];
        self.ConnectedSubjectID = [decoder decodeObjectForKey:@"Homework_ConnectedSubjectID"];
        self.HomeworkID = [decoder decodeObjectForKey:@"Homework_HomeworkID"];
	}
	return self;
}

@end
