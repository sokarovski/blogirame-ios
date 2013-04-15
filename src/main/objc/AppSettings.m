//
//  AppDelegate.h
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "AppSettings.h"

#define NewstPostsAreDefault @"newestPostsAreDefaultPosts"

@implementation AppSettings
+ (BOOL)shouldShowNewestPosts
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults valueForKey:NewstPostsAreDefault]) {
        return [userDefaults boolForKey:NewstPostsAreDefault];
    } else {
        [userDefaults setBool:YES forKey:NewstPostsAreDefault];
        [userDefaults synchronize];
        return YES;
    }
}

+ (void)setNewestPostsAsDefault
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:NewstPostsAreDefault];
    [userDefaults synchronize];
    
}
+ (void)setTopPostsAsDefault
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:NewstPostsAreDefault];
    [userDefaults synchronize];
}
@end
