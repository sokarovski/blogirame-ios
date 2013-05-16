//
//  AppDelegate+StatusBar.m
//  Blogirame
//
//  Created by Aleksandra Gavrilovska on 5/16/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "AppDelegate+StatusBar.h"

@implementation AppDelegate (StatusBar)
- (void)showNetworkActivityIndicator
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)hideNetworkActivityIndicator
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
@end
