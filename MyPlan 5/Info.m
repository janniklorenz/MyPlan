//
//  Info.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 14.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Info.h"

@implementation Info

@synthesize InfoName;
@synthesize Infos;
@synthesize RunEdit;


- (id)init {
    self.InfoName = @"";
    self.Infos = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", nil];
    self.RunEdit = NO;
    return self;
}
+ (id)newInfoWithName:(NSString *)newName andRunEdit:(BOOL)newRunEdit {
    Info *new = [[Info alloc] init];
    new.InfoName = newName;
    new.RunEdit = newRunEdit;
    return new;
}




- (void)changeInfoForDay:(int)index to:(NSString *)newInfo {
    if ([Infos count] > index) {
        [Infos removeObjectAtIndex:index];
        [Infos insertObject:newInfo atIndex:index];
    }
}
- (void)changeInfoTo:(NSString *)newInfo {
    for (int i = 0; i < [Infos count]; i++) {
        [Infos removeObjectAtIndex:i];
        [Infos insertObject:newInfo atIndex:i];
    }
}
- (void)changeNameTo:(NSString *)newName {
    InfoName = newName;
}




- (void)overwrite {
    for (int i = 1; i < [Infos count]; i++) {
        [Infos removeObjectAtIndex:i];
        [Infos insertObject:[Infos objectAtIndex:0] atIndex:i];
    }
}




- (NSString *)getInfoForDay:(int)index {
    if ([Infos count] > index) return [Infos objectAtIndex:index];
    return @"";
}




- (BOOL)DifferentInfos {
    if ([Infos count] <= 1) return NO;
    for (int i = 1; i < [Infos count]; i++) if (![[Infos objectAtIndex:i-1] isEqualToString:[Infos objectAtIndex:i]]) return YES;
    return NO;
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:InfoName forKey:@"Info_InfoName"];
    [encoder encodeObject:Infos forKey:@"Info_Infos"];
    [encoder encodeBool:RunEdit forKey:@"Info_RunEdit"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.InfoName = [decoder decodeObjectForKey:@"Info_InfoName"];
        self.Infos = [decoder decodeObjectForKey:@"Info_Infos"];
        self.RunEdit = [decoder decodeBoolForKey:@"Info_RunEdit"];
	}
	return self;
}

@end
