//
//  AppDelegate.m
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "AppDelegate.h"

#import "PostListViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    PostListViewController *rootView = [[PostListViewController alloc]
                                        initWithNibName:@"PostListViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:rootView];
    //tint color HEX:4c4b71
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.298 green:0.294 blue:0.439 alpha:1]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
