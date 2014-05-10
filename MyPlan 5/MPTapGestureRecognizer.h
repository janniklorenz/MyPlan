//
//  MPTapGestureRecognizer.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 19.01.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"

@interface MPTapGestureRecognizer : UITapGestureRecognizer {
    Subject *subject;
    BOOL done;
    int zeile;
    int spalte;
    NSIndexPath *indexPath;
}
@property (readwrite) Subject *subject;
@property (readwrite) BOOL done;
@property (readwrite) int zeile;
@property (readwrite) int spalte;
@property (readwrite) NSIndexPath *indexPath;

@end
