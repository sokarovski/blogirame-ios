//
//  AppDelegate.h
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

/**
 * This class manage application state, setting, user defaults.
 */
@interface AppSettings : NSObject
+ (BOOL)shouldShowNewestPosts;
+ (void)setNewestPostsAsDefault;
+ (void)setTopPostsAsDefault;
@end
