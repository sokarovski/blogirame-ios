//
//  AppDelegate.m
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "AppDelegate.h"
#import "ContentViewController.h"
#import "UIColor+WebColors.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ContentViewController *rootView = [[ContentViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:rootView];
    //tint color HEX:4c4b71
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHex:0x4C4B71]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
