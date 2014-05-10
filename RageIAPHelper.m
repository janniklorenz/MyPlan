//
//  RageIAPHelper.m
//  MyPlan 5
//
//  Created by Jannik Lorenz on 28.04.13.
//  Copyright (c) 2013 Jannik Lorenz. All rights reserved.
//

#import "RageIAPHelper.h"

@implementation RageIAPHelper

+ (RageIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static RageIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.jlproduction.MyPlan5.noAds", nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
