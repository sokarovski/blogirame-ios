//
//  AppDelegate+Navigation.m
//  Blogirame
//
//  Created by Aleksandra Gavrilovska on 4/16/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "AppDelegate+Navigation.h"
#import "WebViewController.h"

@implementation AppDelegate (Navigation)
- (void)showEntryDetailViewWithValues:(NSDictionary *)values
{
    WebViewController *next = [[WebViewController alloc] init];
    if (values && [next conformsToProtocol:@protocol(NSCoding)]) {
        [next setValuesForKeysWithDictionary:values];
    }
    [self.navigationController pushViewController:next animated:YES];
}
@end
