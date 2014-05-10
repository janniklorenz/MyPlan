//
//  ViewController.m
//  MyPlan 4
//
//  Created by Jannik Lorenz on 24.01.12.
//  Copyright (c) 2012 J.L. Production. All rights reserved.
//
// "Übrig bleibt, was wichtig ist", Steve Jobs
//

#import <UIKit/UIKit.h>

@protocol MainTableFile10Delegate <NSObject>
@optional
- (void)valueChangedTo:(float)value atIndex:(NSIndexPath *)index;
@end

@interface MainTableFile10 : UITableViewCell {
    IBOutlet UILabel *Label1;
    IBOutlet UISlider *slider1;
    NSIndexPath *indexPath;
    id delegate;
}
@property (nonatomic, retain) IBOutlet UILabel *Label1;
@property (nonatomic, retain) IBOutlet UISlider *slider1;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) id delegate;

- (IBAction)valueChanged:(id)sender;

@end
//CODE MADE BY JANNIK LORENZ