//
//  AppData.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 03.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "AppData.h"
#import "MainData.h"

@implementation AppData

@synthesize AppVersion;
@synthesize AppStarts;
@synthesize selectedPersonID;
@synthesize HouresOn;
@synthesize TermineOn;
@synthesize MinutesBevor;
@synthesize Notifications;
@synthesize TermineNotifications;
@synthesize StartAnsichtOn;
@synthesize StartAnsichtIndex;
@synthesize AdFree;
@synthesize MessageStarts;
@synthesize ShowMessageAgain;
@synthesize AppStoreReview;

- (id)init {
    self.AppVersion = @"";
    self.AppStarts = 0;
    self.selectedPersonID = @"";
    self.HouresOn = YES;
    self.TermineOn = YES;
    self.MinutesBevor = 0;
    self.Notifications = [NSMutableArray arrayWithObjects:nil];
    self.TermineNotifications = [NSMutableArray arrayWithObjects:nil];
    self.AdFree = NO;
    return self;
}

+ (id)newAppDataWithVersion:(NSString *)newVersion {
    AppData *new = [[AppData alloc] init];
    new.AppVersion = newVersion;
    [MainData SaveAppData:new];
    return new;
}




- (void)saveStart {
    AppStarts++;
    NSLog(@"%i", MessageStarts);
    if (MessageStarts == 14) {
        MessageStarts = 0;
        ShowMessageAgain = YES;
    }
    else MessageStarts++;
    [MainData SaveAppData:self];
}
- (BOOL)showAdMessage {
    if (ShowMessageAgain) {
        ShowMessageAgain = NO;
        [MainData SaveAppData:self];
        return YES;
    }
    return NO;
    [MainData SaveAppData:self];
}

- (BOOL)checkForFirstStart {
    if (AppStarts == 0) return YES;
    return NO;
}
- (BOOL)checkForUpdateWithVersion:(NSString *)newVersion {
    if (![newVersion isEqualToString:AppVersion]) {
        AppVersion = newVersion;
        [MainData SaveAppData:self];
        return YES;
    }
    return NO;
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:AppVersion forKey:@"AppData_AppVersion"];
	[encoder encodeInt:AppStarts forKey:@"AppData_AppStarts"];
    [encoder encodeObject:selectedPersonID forKey:@"AppData_selectedPersonID"];
    [encoder encodeBool:HouresOn forKey:@"AppData_HouresOn"];
    [encoder encodeBool:TermineOn forKey:@"AppData_TermineOn"];
    [encoder encodeInt:MinutesBevor forKey:@"AppData_MinutesBevor"];
    [encoder encodeObject:Notifications forKey:@"AppData_Notifications"];
    [encoder encodeObject:TermineNotifications forKey:@"AppData_TermineNotifications"];
    [encoder encodeBool:StartAnsichtOn forKey:@"AppData_StartAnsichtOn"];
    [encoder encodeInt:StartAnsichtIndex forKey:@"AppData_StartAnsichtIndex"];
    [encoder encodeBool:AdFree forKey:@"AppData_AdFree"];
    [encoder encodeInt:MessageStarts forKey:@"AppData_MessageStarts"];
    [encoder encodeBool:ShowMessageAgain forKey:@"AppData_ShowMessageAgain"];
    [encoder encodeBool:AppStoreReview forKey:@"AppData_AppStoreReview"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.AppVersion = [decoder decodeObjectForKey:@"AppData_AppVersion"];
        self.AppStarts = [decoder decodeIntForKey:@"AppData_AppStarts"];
        self.selectedPersonID = [decoder decodeObjectForKey:@"AppData_selectedPersonID"];
        self.HouresOn = [decoder decodeBoolForKey:@"AppData_HouresOn"];
        self.TermineOn = [decoder decodeBoolForKey:@"AppData_TermineOn"];
        self.MinutesBevor = [decoder decodeIntForKey:@"AppData_MinutesBevor"];
        self.Notifications = [decoder decodeObjectForKey:@"AppData_Notifications"];
        self.TermineNotifications = [decoder decodeObjectForKey:@"AppData_TermineNotifications"];
        self.StartAnsichtOn = [decoder decodeBoolForKey:@"AppData_StartAnsichtOn"];
        self.StartAnsichtIndex = [decoder decodeIntForKey:@"AppData_StartAnsichtIndex"];
        self.AdFree = [decoder decodeBoolForKey:@"AppData_AdFree"];
        self.MessageStarts = [decoder decodeIntForKey:@"AppData_MessageStarts"];
        self.ShowMessageAgain = [decoder decodeBoolForKey:@"AppData_ShowMessageAgain"];
        self.AppStoreReview = [decoder decodeBoolForKey:@"AppData_AppStoreReview"];
	}
	return self;
}

@end
