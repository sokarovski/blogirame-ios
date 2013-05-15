/*
 * @(#) $$CVSHeader: $$
 *
 * Copyright (C) 2013 by Netcetera AG.
 * All rights reserved.
 *
 * The copyright to the computer program(s) herein is the property of
 * Netcetera AG, Switzerland.  The program(s) may be used and/or copied
 * only with the written permission of Netcetera AG or in accordance
 * with the terms and conditions stipulated in the agreement/contract
 * under which the program(s) have been supplied.
 *
 * @(#) $$Id: ContentViewController.m 69 2011-05-06 14:26:45Z djovanos $$
 */

#import "ContentViewController.h"
#import "PostListViewController.h"
#import "CategoriesViewController.h"
#import "AppSettings.h"

@interface ContentViewController () {
    UIBarButtonItem *newestButtonItem;
    UIBarButtonItem *topButtonItem;
    UIBarButtonItem *categoriesButtonItem;
    PostListViewController *itemsVC;
    CategoriesViewController *categoriesVC;
    BOOL sideMenuVisible;
}
@end
    
@implementation ContentViewController

- (void)setupNavigationBar
{
    if (!newestButtonItem) {
        newestButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New"
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(showNewestEntries)];
    }
    if (!topButtonItem) {
        topButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Top"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(showTopEntries)];
    }
    if (!categoriesButtonItem) {
        categoriesButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Categories"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(showCategories)];
    }
    
    if ([AppSettings shouldShowNewestPosts]) {
        [self.navigationItem setRightBarButtonItem:topButtonItem];
    } else {
        [self.navigationItem setRightBarButtonItem:newestButtonItem];
    }
    
    [self.navigationItem setLeftBarButtonItem:categoriesButtonItem];
    
}

- (void)createChildViews
{
    if (!itemsVC) {
        itemsVC = [[PostListViewController alloc] initWithNibName:@"PostListViewController" bundle:nil];
    }
    [self addChildViewController:itemsVC];
    [self.view addSubview:itemsVC.view];
    
    if (!categoriesVC) {
        categoriesVC = [[CategoriesViewController alloc] initWithNibName:@"CategoriesViewController" bundle:nil];
    }
    [self.view insertSubview:categoriesVC.view belowSubview:itemsVC.view];
    [self addChildViewController:categoriesVC];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];
    [self createChildViews];
}

#pragma mark BarButtonItem
- (void)showNewestEntries
{
    if (sideMenuVisible) {
        [self hideSideMenu];
    }
    [AppSettings setNewestPostsAsDefault];
    [self.navigationItem setTitle:@"Newest Entries"];
    [self.navigationItem setRightBarButtonItem:topButtonItem];
    [itemsVC showNewestEntries];
}

- (void)showTopEntries
{
    if (sideMenuVisible) {
        [self hideSideMenu];
    }
    
    [AppSettings setTopPostsAsDefault];
    [self.navigationItem setTitle:@"Top Entries"];
    [self.navigationItem setRightBarButtonItem:newestButtonItem];
    [itemsVC showTopEntries];
}

- (void)showCategories
{
    if (!sideMenuVisible) {
        [categoriesVC showCategories];
        [self showSideMenu];
    } else {
        [self hideSideMenu];
    }
}

- (void)showSideMenu
{
    sideMenuVisible = YES;
    CGPoint origin = CGPointMake(250, 0);
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect itemsFrame = itemsVC.view.frame;
                         itemsFrame.origin = origin;
                         [itemsVC.view setFrame:itemsFrame];
                     }
                     completion:^(BOOL finished) {
    }];
}

- (void)hideSideMenu
{
    sideMenuVisible = NO;
    CGPoint origin = CGPointMake(0, 0);
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect itemsFrame = itemsVC.view.frame;
                         itemsFrame.origin = origin;
                         [itemsVC.view setFrame:itemsFrame];
                     }
                     completion:^(BOOL finished) {
    }];
}
@end
