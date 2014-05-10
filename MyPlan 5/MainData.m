//
//  MainData.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "MainData.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import "MainTableFile4.h"
#import "MainTableFile5.h"
#import "MainTableFile6.h"
#import "MainTableFile7.h"
#import "MainTableFile8.h"
#import "MainTableFile9.h"
#import "MainTableFile10.h"
#import "MainTableFile11.h"
#import "MainTableFile12.h"
#import "MainTableFile13.h"
#import "MainTableFile14.h"
#import "MainTableFile15.h"
#import "MainTableFile16.h"
#import "MainTableFile17.h"
#import "SubjectCell1.h"
#import "SubjectCell2.h"
#import "SubjectCell3.h"
#import "SubjectCell4.h"
#import "SubjectCell5.h"
#import "Subject.h"
#import <QuartzCore/QuartzCore.h>
#import "AppData.h"
#import "Person.h"

@implementation MainData

+ (NSString *)selectedBackgroundImg {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"BackgroundSelected.png"];
}
+ (NSString *)menuBackgroundImg {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"BackgroundSelected.png"];
}




// --------------------------------------
// -------------- Table View ------------
// --------------------------------------
+ (id)getCellType:(int)x {
    if (x == 1) {
        static NSString *xibName = @"MainTableFile";
        MainTableFile *MainTableCell;
        if (MainTableCell == nil) {NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:2];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 2) {
        static NSString *xibName = @"MainTableFile2";
        MainTableFile2 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile2 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:2];
        MainTableCell.backgroundView = [MainData getViewType:0];
        MainTableCell.custumTextLabel1.textColor = [UIColor blackColor];
        MainTableCell.custumTextLabel1.highlightedTextColor = [UIColor blackColor];
        return MainTableCell;
    }
    else if (x == 3) {
        static NSString *xibName = @"MainTableFile3";
        MainTableFile3 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile3 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:2];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 4) {
        static NSString *xibName = @"MainTableFile4";
        MainTableFile4 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile4 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 5) {
        static NSString *xibName = @"MainTableFile5";
        MainTableFile5 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile5 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 6) {
        static NSString *xibName = @"MainTableFile6";
        MainTableFile6 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile6 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 7) {
        static NSString *xibName = @"MainTableFile7";
        MainTableFile7 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile7 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 8) {
        static NSString *xibName = @"MainTableFile8";
        MainTableFile8 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile8 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 9) {
        static NSString *xibName = @"MainTableFile9";
        MainTableFile9 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile9 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 10) {
        static NSString *xibName = @"MainTableFile10";
        MainTableFile10 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile10 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 11) {
        static NSString *xibName = @"MainTableFile11";
        MainTableFile11 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile11 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 12) {
        static NSString *xibName = @"MainTableFile12";
        MainTableFile12 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile12 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 13) {
        static NSString *xibName = @"MainTableFile13";
        MainTableFile13 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile13 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 14) {
        static NSString *xibName = @"MainTableFile14";
        MainTableFile14 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile14 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 15) {
        static NSString *xibName = @"MainTableFile15";
        MainTableFile15 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile15 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 16) {
        static NSString *xibName = @"MainTableFile16";
        MainTableFile16 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile16 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:6];
        MainTableCell.backgroundView = [MainData getViewType:6];
        return MainTableCell;
    }
    else if (x == 17) {
        static NSString *xibName = @"MainTableFile17";
        MainTableFile17 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (MainTableFile17 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:6];
        MainTableCell.backgroundView = [MainData getViewType:6];
        return MainTableCell;
    }
    
    // ----------------------
    
    else if (x == 101) {
        static NSString *xibName = @"SubjectCell1";
        SubjectCell1 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (SubjectCell1 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 102) {
        static NSString *xibName = @"SubjectCell2";
        SubjectCell2 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (SubjectCell2 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 103) {
        static NSString *xibName = @"SubjectCell3";
        SubjectCell3 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (SubjectCell3 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 104) {
        static NSString *xibName = @"SubjectCell4";
        SubjectCell4 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (SubjectCell4 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:0];
        MainTableCell.backgroundView = [MainData getViewType:0];
        return MainTableCell;
    }
    else if (x == 105) {
        static NSString *xibName = @"SubjectCell5";
        SubjectCell5 *MainTableCell;
        if (MainTableCell == nil) { NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];for (id currentObject in topLevelObjects) {if ([currentObject isKindOfClass:[UITableViewCell class]]) {MainTableCell = (SubjectCell5 *) currentObject;break;}}}
        MainTableCell.selectedBackgroundView = [MainData getViewType:6];
        MainTableCell.backgroundView = [MainData getViewType:6];
        return MainTableCell;
    }
    return 0;
}
+ (UIView *)getViewWithColor:(UIColor *)col {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = col;
    backView.layer.borderColor = [UIColor whiteColor].CGColor;
    backView.layer.borderWidth = 0.2;
    backView.layer.cornerRadius = 2.0;
    
    return backView;
}
+ (UIView *)getViewType:(int)x {
    if (x == 0) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
        backView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        backView.layer.borderColor = [UIColor blackColor].CGColor;
        backView.layer.borderWidth = 0.5;
        backView.layer.cornerRadius = 2.0;
        
        backView.layer.shadowOpacity = 1;
        backView.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7].CGColor;
        backView.layer.shadowOffset = CGSizeMake(1,-2);
        backView.layer.shadowRadius = 4;
        
        return backView;
    }
    else if (x == 1) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
        backView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        backView.layer.borderColor = [UIColor whiteColor].CGColor;
        backView.layer.borderWidth = 0.5;
        backView.layer.cornerRadius = 2.0;
        
        backView.layer.shadowOpacity = 1;
        backView.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7].CGColor;
        backView.layer.shadowOffset = CGSizeMake(1,-1);
        backView.layer.shadowRadius = 4;
        return backView;
    }
    else if (x == 2) {
        UIView *BackgroundSecected = [[UIView alloc] init];
        BackgroundSecected.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
        BackgroundSecected.layer.borderColor = [UIColor whiteColor].CGColor;
        BackgroundSecected.layer.borderWidth = 1.0;
        BackgroundSecected.layer.cornerRadius = 2.0;
        return BackgroundSecected;
    }
    else if (x == 3) {
        UIView *BackgroundSecected = [[UIView alloc] init];
        BackgroundSecected.backgroundColor = [UIColor colorWithRed:0.212 green:0.564 blue:0.933 alpha:1.0];
        BackgroundSecected.layer.borderColor = [UIColor whiteColor].CGColor;
        BackgroundSecected.layer.borderWidth = 0.0;
        BackgroundSecected.layer.cornerRadius = 2.0;
        return BackgroundSecected;
    }
    else if (x == 4) {
        UIView *BackgroundSecected = [[UIView alloc] init];
        BackgroundSecected.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
        BackgroundSecected.layer.borderColor = [UIColor whiteColor].CGColor;
        BackgroundSecected.layer.borderWidth = 0.2;
        BackgroundSecected.layer.cornerRadius = 2.0;
        return BackgroundSecected;
    }
    else if (x == 5) {
        UIView *BackgroundSecected = [[UIView alloc] init];
        BackgroundSecected.backgroundColor = [UIColor colorWithRed:1.0 green:0.137 blue:0.0 alpha:0.8];
        BackgroundSecected.layer.borderColor = [UIColor whiteColor].CGColor;
        BackgroundSecected.layer.borderWidth = 0.2;
        BackgroundSecected.layer.cornerRadius = 2.0;
        return BackgroundSecected;
    }
    else if (x == 6) {
        UIView *BackgroundSecected = [[UIView alloc] init];
        BackgroundSecected.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
        BackgroundSecected.layer.borderColor = [UIColor whiteColor].CGColor;
        BackgroundSecected.layer.borderWidth = 0.0;
        BackgroundSecected.layer.cornerRadius = 2.0;
        return BackgroundSecected;
    }
    else if (x == 7) {
        UIView *BackgroundSecected = [[UIView alloc] init];
        BackgroundSecected.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
        BackgroundSecected.layer.borderColor = [UIColor whiteColor].CGColor;
        BackgroundSecected.layer.borderWidth = 0.5;
        BackgroundSecected.layer.cornerRadius = 2.0;
        return BackgroundSecected;
    }
    return 0;
}


+ (UIColor *)getTextColorForBackgroundColor:(UIColor *)back {
    const CGFloat* components = CGColorGetComponents(back.CGColor);
    if (components[3] <= 0.2) return [UIColor whiteColor];
    if (components[0] + components[1] + components[2] >= 1.5) return [UIColor blackColor];
    return [UIColor whiteColor];
}

+ (UIImage *)getVertretungImgForBackgroundColor:(UIColor *)back {
    const CGFloat* components = CGColorGetComponents(back.CGColor);
    if (components[0] + components[1] + components[2] >= 1.5) return [UIImage imageNamed:@"MyPlan_Vertretung_B.png"];
    return [UIImage imageNamed:@"MyPlan_Vertretung_W.png"];
}
// --------------------------------------
// --------------------------------------
// --------------------------------------





// --------------------------------------
// ---------------- Save ----------------
// --------------------------------------
+ (void)Save:(id)toSave underName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *DataPath1 = [documentsDirectory stringByAppendingPathComponent:name];
    [NSKeyedArchiver archiveRootObject:toSave toFile:DataPath1];
}
+ (id)LoadName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *DataPath1 = [documentsDirectory stringByAppendingPathComponent:name];
    id toLoad = [NSKeyedUnarchiver unarchiveObjectWithFile:DataPath1];
    return toLoad;
}

+ (NSString *)SaveImg:(UIImage *)img {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *DataPath1 = [documentsDirectory stringByAppendingPathComponent:@"MyPlan 5 - Foto"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:DataPath1 error:NULL];
    [UIImagePNGRepresentation(img) writeToFile:DataPath1 atomically:YES];
    return DataPath1;
}


+ (void)SaveMain:(NSMutableArray *)Main {
    [self Save:Main underName:@"Main.mp"];
}
+ (NSMutableArray *)LoadMain {
    NSMutableArray *ret = [self LoadName:@"Main.mp"];
    if (ret == nil) ret = [NSMutableArray arrayWithObjects:nil];
    return ret;
}

+ (id)copyObject:(id)object {
    [self Save:object underName:@"copyTemp"];
    return [self LoadName:@"copyTemp"];
}




+ (NSString *)SavePersonToSend:(Person *)sendPerson {
    [self Save:sendPerson underName:[NSString stringWithFormat:@"MyPlan Export - Person (%@).MyPlan5", sendPerson.PersonName]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"MyPlan Export - Person (%@).MyPlan5", sendPerson.PersonName]];
}
+ (Person *)LoadPersonFormSend:(NSURL *)url {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:url.relativePath];
}




+ (void)SaveAppData:(AppData *)AppData {[self Save:AppData underName:@"AppData.mp"];}
+ (AppData *)LoadAppData {return [self LoadName:@"AppData.mp"];}

+ (void)SaveBackgroundImg:(UIImage *)image {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *DataPath1 = [documentsDirectory stringByAppendingPathComponent:@"BackgroundSelected.png"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:DataPath1 error:NULL];
    [UIImageJPEGRepresentation(image, 1) writeToFile:DataPath1 atomically:YES];
}
// --------------------------------------
// --------------------------------------
// --------------------------------------



+ (int)daySecondsForDate:(NSDate *)dat {
    NSDateFormatter *UhrH = [[NSDateFormatter alloc] init];
    [UhrH setDateFormat:@"HH"];
    int UhrHint = [[UhrH stringFromDate:dat] intValue];
    NSDateFormatter *UhrM = [[NSDateFormatter alloc] init];
    [UhrM setDateFormat:@"mm"];
    int UhrMint = [[UhrM stringFromDate:dat] intValue];
    NSDateFormatter *UhrS = [[NSDateFormatter alloc] init];
    [UhrS setDateFormat:@"ss"];
    int UhrSint = [[UhrS stringFromDate:dat] intValue];
    return UhrHint*60*60 + UhrMint*60 + UhrSint;
}
+ (int)daySeconds {
    return [self daySecondsForDate:[NSDate date]];
}
+ (int)dayIndex {
    NSDateFormatter *Heute2 = [[NSDateFormatter alloc] init];
	[Heute2 setDateFormat:@"e"];
    NSString *Today2 = [Heute2 stringFromDate:[NSDate date]];
    if ([Today2 intValue] == 0) return 0;
    return [Today2 intValue] - 1;
}
+ (int)dayIndexForDate:(NSDate *)newDate {
    NSDateFormatter *Heute2 = [[NSDateFormatter alloc] init];
	[Heute2 setDateFormat:@"e"];
    NSString *Today2 = [Heute2 stringFromDate:newDate];
    if ([Today2 intValue] == 0) return 0;
    return [Today2 intValue] - 1;
}
+ (NSDate *)dateForDayIndex:(int)ndeDayIndex {
    NSDate *dateMo = [NSDate dateWithTimeIntervalSinceNow:[self dayIndex]*24*60*60 * -1];
    return [NSDate dateWithTimeInterval:ndeDayIndex*24*60*60 sinceDate:dateMo];
}
+ (NSDate *)dayDateForDate:(NSDate *)dat {
    return [NSDate dateWithTimeInterval:-[self daySecondsForDate:dat] sinceDate:dat];
}

+ (NSString *)dayTime {
    NSDateFormatter *UhrH = [[NSDateFormatter alloc] init];
    [UhrH setDateFormat:@"HH"];
    NSDateFormatter *UhrM = [[NSDateFormatter alloc] init];
    [UhrM setDateFormat:@"mm"];
    return [NSString stringWithFormat:@"%@:%@", [UhrH stringFromDate:[NSDate date]], [UhrM stringFromDate:[NSDate date]]];
}






+ (float)runden:(float)zahl stellen:(int)stellen {
	float a1 = zahl * (pow(10, stellen));
	int a2 = a1;
	if (a1 - a2 >= 0.5) a2++;
	float b1 = a2;
	float b2 = b1 / (pow(10, stellen));
	
	return b2;
}
+ (NSString *)kommaDurchPunktErsetzen:(NSString *)Input {
	NSString *OutputString = @"";
	NSArray *LogArray1 = [Input componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
	if ([LogArray1 count] == 1) OutputString = [LogArray1 objectAtIndex:0];
	else if ([LogArray1 count] > 1) OutputString = [NSString stringWithFormat:@"%@.%@", [LogArray1 objectAtIndex:0], [LogArray1 objectAtIndex:1]];
	else OutputString = Input;
	
	return OutputString;
}


+ (UIImage *)imageWithImage:(UIImage *)image {
    CGSize newSize = CGSizeMake(image.size.width*0.40, image.size.height*0.40);
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) UIGraphicsBeginImageContextWithOptions(newSize, YES, 2.0);
        else UIGraphicsBeginImageContext(newSize);
    }
    else UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




// -----------------------------



+ (void)saveSmallImg:(UIImage *)img withName:(NSString *)name withFactor:(float)factor {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    UIGraphicsBeginImageContext(CGSizeMake(imageView.frame.size.width*factor, imageView.frame.size.height*factor));
    [img drawInRect:CGRectMake(0, 0, imageView.frame.size.width*factor, imageView.frame.size.height*factor)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *DataPath1 = [documentsDirectory stringByAppendingPathComponent:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:DataPath1 error:NULL];
    [UIImageJPEGRepresentation(newImage, 1) writeToFile:DataPath1 atomically:YES];
}



+ (void)setAdFree:(BOOL)newAdFree {
    AppData *appData = [MainData LoadAppData];
    appData.AdFree = newAdFree;
    [MainData SaveAppData:appData];
}


@end
