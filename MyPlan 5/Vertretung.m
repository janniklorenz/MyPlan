//
//  Vertretung.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 21.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Vertretung.h"
#import "Info.h"

@implementation Vertretung

@synthesize VertretungInfos;
@synthesize VertretungsDatum;
@synthesize VertretungsID;
@synthesize VertretungsName;
@synthesize SubjectID;
@synthesize SubjectHoureIndex;


- (id)init {
    VertretungInfos = [NSMutableArray arrayWithObjects:nil];
    [VertretungInfos addObject:[Info newInfoWithName:@"Raum" andRunEdit:NO]];
    [VertretungInfos addObject:[Info newInfoWithName:@"Lehrer" andRunEdit:NO]];
    [VertretungInfos addObject:[Info newInfoWithName:@"Notiz" andRunEdit:YES]];
    VertretungsDatum = [NSDate date];
    VertretungsID = @"";
    VertretungsName = @"";
    SubjectID = @"";
    SubjectHoureIndex = 0;
    return self;
}
+ (id)newVertretung {
    Vertretung *new = [[Vertretung alloc] init];
    new.VertretungsID = [NSString stringWithFormat:@"Vertretung-%i%i", arc4random() % 9999999, arc4random() % 9999999];
    return new;
}




- (void)addInfo {
    [VertretungInfos addObject:[Info newInfoWithName:@"Neue Info" andRunEdit:NO]];
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:VertretungInfos forKey:@"Vertretung_VertretungInfos"];
    [encoder encodeObject:VertretungsDatum forKey:@"Vertretung_VertretungsDatum"];
    [encoder encodeObject:VertretungsID forKey:@"Vertretung_VertretungsID"];
    [encoder encodeObject:VertretungsName forKey:@"Vertretung_VertretungsName"];
    [encoder encodeObject:SubjectID forKey:@"Vertretung_SubjectID"];
    [encoder encodeInt:SubjectHoureIndex forKey:@"Vertretung_SubjectHoureIndex"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.VertretungInfos = [decoder decodeObjectForKey:@"Vertretung_VertretungInfos"];
        self.VertretungsDatum = [decoder decodeObjectForKey:@"Vertretung_VertretungsDatum"];
        self.VertretungsID = [decoder decodeObjectForKey:@"Vertretung_VertretungsID"];
        self.VertretungsName = [decoder decodeObjectForKey:@"Vertretung_VertretungsName"];
        self.SubjectID = [decoder decodeObjectForKey:@"Vertretung_SubjectID"];
        self.SubjectHoureIndex = [decoder decodeIntForKey:@"Vertretung_SubjectHoureIndex"];
	}
	return self;
}

@end
