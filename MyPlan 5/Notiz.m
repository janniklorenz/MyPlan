//
//  Notiz.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 30.04.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Notiz.h"
#import "MainData.h"

@implementation Notiz

@synthesize NotizName;
@synthesize NotizDatum;
@synthesize NotizImage;
@synthesize NotizID;
@synthesize ConnectedSubjectID;

- (id)init {
    self.NotizName = @"";
    self.NotizID = [NSString stringWithFormat:@"Note%i-%i", arc4random() % 9999999, arc4random() % 9999999];
    self.NotizDatum = [NSDate date];
    self.ConnectedSubjectID = @"";
    return self;
}

+ (id)newNotizWithName:(NSString *)name {
    Notiz *new = [[Notiz alloc] init];
    new.NotizName = name;
    return new;
}


- (void)prepareDelete {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", NotizID]];
    [fileManager removeItemAtPath:path error:NULL];
    NSString *path2 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.jpg", NotizID]];
    [fileManager removeItemAtPath:path2 error:NULL];
}

- (UIImage *)NotizImage {
    if ([NotizID isEqualToString:@""] || NotizID == nil) return nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", NotizID]];
    return [UIImage imageWithContentsOfFile:path];
}
- (UIImage *)NotizImageSmall {
    if ([NotizID isEqualToString:@""] || NotizID == nil) return nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.jpg", NotizID]];
    return [UIImage imageWithContentsOfFile:path];
}
- (void)setNotizImage:(UIImage *)newNotizImage {
    if (newNotizImage != nil) {
        [MainData saveSmallImg:newNotizImage withName:[NSString stringWithFormat:@"%@.jpg", NotizID] withFactor:0.8];
        [MainData saveSmallImg:newNotizImage withName:[NSString stringWithFormat:@"%@_small.jpg", NotizID] withFactor:0.3];
    }
}



- (NSString *)getRest {
    float restDays = ([[MainData dayDateForDate:NotizDatum] timeIntervalSince1970] - [[MainData dayDateForDate:[NSDate date]] timeIntervalSince1970])/60/60/24;
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


- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:NotizName forKey:@"Notiz_NotizName"];
    [encoder encodeObject:NotizDatum forKey:@"Notiz_NotizDatum"];
    [encoder encodeObject:NotizImage forKey:@"Notiz_NotizImage"];
    [encoder encodeObject:NotizID forKey:@"Notiz_NotizID"];
    [encoder encodeObject:ConnectedSubjectID forKey:@"Notiz_ConnectedSubjectID"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.NotizName = [decoder decodeObjectForKey:@"Notiz_NotizName"];
        self.NotizDatum = [decoder decodeObjectForKey:@"Notiz_NotizDatum"];
        self.NotizImage = [decoder decodeObjectForKey:@"Notiz_NotizImage"];
        self.NotizID = [decoder decodeObjectForKey:@"Notiz_NotizID"];
        self.ConnectedSubjectID = [decoder decodeObjectForKey:@"Notiz_ConnectedSubjectID"];
	}
	return self;
}

@end
