//
//  MPNavigationBar.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 23.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "MPNavigationBar.h"
#import "MainData.h"

@implementation MPNavigationBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


- (void)setOpaque:(BOOL)opaque {
    [super setOpaque:NO];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    //// Color Declarations
//    UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.7];
//    UIColor* textColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 1];
//    
//    //// Abstracted Attributes
//    NSString* textContent = @"Hello, World!";
//    
//    
//    //// Rectangle Drawing
//    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(2, 2, self.frame.size.width-4, self.frame.size.height-4)];
//    [fillColor setFill];
//    [rectanglePath fill];
//    
//    
//    //// Text Drawing
//    CGRect textRect = CGRectMake(8, 50, 223, 17);
//    [textColor setFill];
//    [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"Helvetica" size: 12] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
//
//    
//    CGRect frame = CGRectMake(0, 0, 320, 44);
//    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.text = [self.topItem.title copy];
//    [label setBackgroundColor:[UIColor clearColor]];
//    label.font = [UIFont boldSystemFontOfSize: 19.0];
//    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:1];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor blackColor];
//    label.text = self.topItem.title;
//    self.topItem.titleView = label;
    
    

}



@end
