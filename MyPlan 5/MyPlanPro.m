//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "MyPlanPro.h"
#import "MainTableFile.h"
#import "MainTableFile2.h"
#import "MainTableFile3.h"
#import <QuartzCore/QuartzCore.h>
#import "MainData.h"
#import "GAI.h"
#import "IAPHelper.h"
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>

@interface MyPlanPro () {
    NSArray *_products;
    NSNumberFormatter * _priceFormatter;
}
@end

@implementation MyPlanPro

@synthesize delegate;
@synthesize hud = _hud;
@synthesize refreshControl;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[MyPlanPro alloc] initWithNibName:@"MyPlanPro_iPhone" bundle:nil];
    else self = [[MyPlanPro alloc] initWithNibName:@"MyPlanPro_iPad" bundle:nil];
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    table.backgroundView = nil;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self reload];
    [self.refreshControl beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            [table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            
            if (idx == 0) { // Werbung Entfernt
                [MainData setAdFree:YES];
                [[[GAI sharedInstance] defaultTracker] sendView:@"Werbung Entfernt"];
            }
            
            *stop = YES;
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)reload {
    _products = nil;
    [table reloadData];
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            [table reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_products.count == 0) return 1;
        return _products.count;
    }
    else {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainTableFile2 *MainTableCell = [MainData getCellType:2];
    
    if (indexPath.section == 0) {
        if (_products.count == 0) {
            MainTableCell.custumTextLabel1.text = @"Verbinden mit iTunes...";
            MainTableCell.backgroundView = [MainData getViewType:4];
        }
        else {
            MainTableCell.backgroundView = [MainData getViewType:0];
            SKProduct * product = (SKProduct *) _products[indexPath.row];
            [_priceFormatter setLocale:product.priceLocale];
            MainTableCell.custumTextLabel1.text = [NSString stringWithFormat:@"%@ (%@)", product.localizedTitle, [_priceFormatter stringFromNumber:product.price]];
            if ([[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
                MainTableCell.accessoryType = UITableViewCellAccessoryCheckmark;
                MainTableCell.userInteractionEnabled = NO;
            }
            else {
                MainTableCell.accessoryType = UITableViewCellAccessoryNone;
                MainTableCell.userInteractionEnabled = YES;
            }
        }
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        MainTableCell.custumTextLabel1.text = @"Kauf Wiederherstellen";
        MainTableCell.backgroundView = [MainData getViewType:4];
    }
    
    return MainTableCell;
}

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_products.count != 0 && indexPath.section == 0) {
        SKProduct *product = _products[indexPath.row];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[RageIAPHelper sharedInstance] buyProduct:product];
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        [[RageIAPHelper sharedInstance] restoreCompletedTransactions];
    }
    
    
}



// Cancel Edit
- (IBAction)cancel:(id)sender {
    [self.delegate viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
