//
//  ViewController.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 01.02.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "Update.h"
#import "MainData.h"

@interface Update ()

@end

@implementation Update

@synthesize isFirst;
@synthesize delegate;

- (id)init {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self = [[Update alloc] initWithNibName:@"Update_iPhone" bundle:nil];
    else self = [[Update alloc] initWithNibName:@"Update_iPad" bundle:nil];
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
//    backImg.image = [UIImage imageWithContentsOfFile:[MainData selectedBackgroundImg]];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"HTML"]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.delegate doneIsFirst:isFirst];
}

@end
