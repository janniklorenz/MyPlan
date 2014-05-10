//
//  Vertretung.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 21.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vertretung : NSObject <NSCoding> {
    NSMutableArray *VertretungInfos;
    NSDate *VertretungsDatum;
    NSString *VertretungsID;
    NSString *VertretungsName;
    
    NSString *SubjectID;
    int SubjectHoureIndex;
}
@property (readwrite) NSMutableArray *VertretungInfos;
@property (readwrite) NSDate *VertretungsDatum;
@property (readwrite) NSString *VertretungsID;
@property (readwrite) NSString *VertretungsName;

@property (readwrite) NSString *SubjectID;
@property (readwrite) int SubjectHoureIndex;

- (id)init;
+ (id)newVertretung;

- (void)addInfo;

@end
