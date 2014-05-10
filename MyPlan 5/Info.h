//
//  Info.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 14.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject <NSCoding> {
    NSString *InfoName;
    NSMutableArray *Infos;
    BOOL RunEdit;
}
@property (readwrite) NSString *InfoName;
@property (readwrite) NSMutableArray *Infos;
@property (readwrite) BOOL RunEdit;

- (id)init;
+ (id)newInfoWithName:(NSString *)newName andRunEdit:(BOOL)newRunEdit;

- (void)changeInfoForDay:(int)index to:(NSString *)newInfo;
- (void)changeInfoTo:(NSString *)newInfo;
- (void)changeNameTo:(NSString *)newName;

- (void)overwrite;

- (NSString *)getInfoForDay:(int)index;
- (BOOL)DifferentInfos;

@end
