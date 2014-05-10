//
//  AppData.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 03.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface AppData : NSObject <NSCoding> {
    // ----- System -----
    NSString *AppVersion;
    int AppStarts;
    int MessageStarts;
    BOOL ShowMessageAgain;
    BOOL AppStoreReview;
    NSString *selectedPersonID;
    
    // ----- Notifications -----
    BOOL HouresOn;
    BOOL TermineOn;
    int MinutesBevor;
    NSMutableArray *Notifications;
    NSMutableArray *TermineNotifications;
    
    // ------- Start Ansicht -------
    BOOL StartAnsichtOn;
    int StartAnsichtIndex;
    
    BOOL AdFree;
}
// ----- System -----
@property (readwrite) NSString *AppVersion;
@property (readwrite) int AppStarts;
@property (readwrite) int MessageStarts;
@property (readwrite) BOOL ShowMessageAgain;
@property (readwrite) BOOL AppStoreReview;
@property (readwrite) NSString *selectedPersonID;

// ----- Notifications -----
@property (readwrite) BOOL HouresOn;
@property (readwrite) BOOL TermineOn;
@property (readwrite) int MinutesBevor;
@property (readwrite) NSMutableArray *Notifications;
@property (readwrite) NSMutableArray *TermineNotifications;

// ------- Start Ansicht -------
@property (readwrite) BOOL StartAnsichtOn;
@property (readwrite) int StartAnsichtIndex;

@property (readwrite) BOOL AdFree;

- (void)saveStart;

- (BOOL)showAdMessage;

- (BOOL)checkForFirstStart;
- (BOOL)checkForUpdateWithVersion:(NSString *)newVersion;

+ (id)newAppDataWithVersion:(NSString *)newVersion;

@end
