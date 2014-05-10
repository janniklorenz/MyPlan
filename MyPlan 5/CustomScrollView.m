//
//  CustomScrollView.m
//  FotografieBasis
//
//  Created by Jannik Lorenz on 31.10.12.
//  Copyright (c) 2012 Jannik Lorenz. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView
- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
	if (!self.dragging) [self.nextResponder touchesEnded: touches withEvent:event]; 
	[super touchesEnded: touches withEvent: event];
}

@end
