//
//  SubAddHoureViewController.h
//  MyPlan 5
//
//  Created by Jannik Lorenz on 06.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Protocol.h"

@class Person;

@protocol SubAddHoureViewControllerDelegate <NSObject>
- (void)didSelectSubjectAtIndex:(NSIndexPath *)indexPath;
- (void)didSelectFree;
@end

@interface SubAddHoureViewController : UIViewController {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *backImg;
    IBOutlet UINavigationBar *navBar;
    
    NSIndexPath *toIndexPath;
    Person *viewingPerson;
    
    id delegate;
}
@property (readwrite) id delegate;
@property (readwrite) NSIndexPath *toIndexPath;

- (void)reloadWithPerson:(Person *)newPerson;
- (IBAction)cancel:(id)sender;

@end
