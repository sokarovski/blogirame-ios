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
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
