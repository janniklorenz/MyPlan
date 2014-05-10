//
//  Noten.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 24.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Note.h"
#import "MainData.h"

@implementation Note

@synthesize NoteWert;
@synthesize NoteWertung;
@synthesize NoteNotiz;
@synthesize isEnabled;
@synthesize NoteImage;
@synthesize NoteID;


- (id)init {
    self.NoteWert = 0;
    self.NoteWertung = 1;
    self.NoteNotiz = @"";
    self.isEnabled = YES;
    self.NoteID = [NSString stringWithFormat:@"Note%i-%i", arc4random() % 9999999, arc4random() % 9999999];
    return self;
}

+ (id)newNote {
    Note *new = [[Note alloc] init];
    return new;
}



- (void)prepareDelete {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", NoteID]];
    [fileManager removeItemAtPath:path error:NULL];
    NSString *path2 = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.jpg", NoteID]];
    [fileManager removeItemAtPath:path2 error:NULL];
}

- (UIImage *)NoteImage {
    if ([NoteID isEqualToString:@""] || NoteID == nil) return nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", NoteID]];
    return [UIImage imageWithContentsOfFile:path];
}
- (UIImage *)NoteImageSmall {
    if ([NoteID isEqualToString:@""] || NoteID == nil) return nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_small.jpg", NoteID]];
    return [UIImage imageWithContentsOfFile:path];
}
- (void)setNoteImage:(UIImage *)newNoteImage {
    if (newNoteImage != nil) {
        [MainData saveSmallImg:newNoteImage withName:[NSString stringWithFormat:@"%@.jpg", NoteID] withFactor:0.8];
        [MainData saveSmallImg:newNoteImage withName:[NSString stringWithFormat:@"%@_small.jpg", NoteID] withFactor:0.3];
    }
}




- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeFloat:NoteWert forKey:@"Note_NoteWert"];
    [encoder encodeFloat:NoteWertung forKey:@"Note_NoteWertung"];
    [encoder encodeObject:NoteNotiz forKey:@"Note_NoteNotiz"];
    [encoder encodeBool:isEnabled forKey:@"Note_isEnabled"];
    [encoder encodeObject:NoteID forKey:@"Note_NoteID"];
    [encoder encodeObject:NoteImage forKey:@"Note_NoteImage"];
}
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.NoteWert = [decoder decodeFloatForKey:@"Note_NoteWert"];
        self.NoteWertung = [decoder decodeFloatForKey:@"Note_NoteWertung"];
        self.NoteNotiz = [decoder decodeObjectForKey:@"Note_NoteNotiz"];
        self.isEnabled = [decoder decodeBoolForKey:@"Note_isEnabled"];
        self.NoteID = [decoder decodeObjectForKey:@"Note_NoteID"];
        self.NoteImage = [decoder decodeObjectForKey:@"Note_NoteImage"];
	}
	return self;
}

@end
