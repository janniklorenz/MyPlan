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

@protocol MainTableFile8Delegate <NSObject>
@optional
- (void)typeName:(NSString *)name index:(NSIndexPath *)index;
- (void)typeInfo:(NSString *)info index:(NSIndexPath *)index;
- (void)didEndNameAtIndex:(NSIndexPath *)index withText:(NSString *)string;
- (void)didEndInfoAtIndex:(NSIndexPath *)index withText:(NSString *)string;
- (void)didStartNameAtIndex:(NSIndexPath *)indexp;
- (void)didStartInfoAtIndex:(NSIndexPath *)indexp;
@end

@interface MainTableFile8 : UITableViewCell {
    IBOutlet UITextField *NameLabel;
    IBOutlet UITextField *InfoLabel;
    NSIndexPath *indexPath;
    id delegate;
}
@property (nonatomic, retain) IBOutlet UITextField *NameLabel;
@property (nonatomic, retain) IBOutlet UITextField *InfoLabel;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) id delegate;

- (IBAction)tName:(id)sender;
- (IBAction)tInfo:(id)sender;
- (IBAction)dStartName:(id)sender;
- (IBAction)dStartInfo:(id)sender;
- (IBAction)dEndName:(id)sender;
- (IBAction)dEndInfo:(id)sender;

@end
//CODE MADE BY JANNIK LORENZ