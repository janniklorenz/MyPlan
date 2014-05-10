//
//  HTMLObject.h
//  MyPlan
//
//  Created by Jannik Lorenz on 22.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMLObject : NSObject

+ (NSString *)MakeHTMLTable:(NSMutableArray *)Datensatze Spalten:(int)Spalten Header:(NSString *)Header;
+ (NSString *)MakeCSVTable:(NSMutableArray *)Datensatze Spalten:(int)Spalten Header:(NSString *)Header;
+ (NSString *)MakePDF:(NSMutableArray *)Datensatze Spalten:(int)Spalten Header:(NSString *)Header;

+ (NSString *)uploadContend:(NSString *)Contend andName:(NSString *)Name;

@end
