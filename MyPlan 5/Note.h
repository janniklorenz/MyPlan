//
//  Noten.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 24.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject <NSCoding> {
    float NoteWert;
    float NoteWertung;
    NSString *NoteNotiz;
    BOOL isEnabled;
    UIImage *NoteImage;
    NSString *NoteID;
}
@property (readwrite) float NoteWert;
@property (readwrite) float NoteWertung;
@property (readwrite) NSString *NoteNotiz;
@property (readwrite) BOOL isEnabled;
@property (nonatomic, retain) UIImage *NoteImage;
@property (readwrite) NSString *NoteID;

- (id)init;
+ (id)newNote;

- (void)prepareDelete;

- (UIImage *)NoteImageSmall;

@end
