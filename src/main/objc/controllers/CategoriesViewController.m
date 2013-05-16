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
 * @(#) $$Id: CategoriesViewController.m 69 2011-05-06 14:26:45Z djovanos $$
 */

#import "CategoriesViewController.h"
#import "AFNetworking.h"
#import "AppDelegate+StatusBar.h"

@interface CategoriesViewController()
{
    NSMutableArray *categories;
    AFJSONRequestOperation *operation;
    NSDictionary *currentCategory;
}

@end
@implementation CategoriesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentCategory = nil;
}

- (void)showCategories
{
    [self fetchCategories];
}

- (void)fetchCategories
{
    if (!categories) {
        NSString *url = @"http://blogirame.mk/jsonapi/categories/";
        NSURL *base = [NSURL URLWithString:url];
        NSURLRequest *req = [NSURLRequest requestWithURL:base];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showNetworkActivityIndicator];
        operation = [AFJSONRequestOperation
                     JSONRequestOperationWithRequest:req
                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                         NSArray *result = [JSON objectForKey:@"results"];
                         categories = nil;
                         categories = [NSMutableArray arrayWithArray:result];
                         [myTableView reloadData];
                         [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideNetworkActivityIndicator];
                     }
                     failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error ,id JSON) {
                         NSLog(@"%@",[error debugDescription]);
                         [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideNetworkActivityIndicator];
                     }];
        
        [operation start];
    } else {
        [myTableView reloadData];
    }
}

#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categories count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryCell"];
    }
    if (indexPath.row == 0) {
        [cell.textLabel setText:@"All"];
        if (!currentCategory) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    } else {
        NSDictionary *category = [categories objectAtIndex:indexPath.row - 1];
        [cell.textLabel setText:[category valueForKey:@"name"]];
        if ([[category valueForKey:@"slug"] isEqual:[currentCategory valueForKey:@"slug"]]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    return cell;
}

- (void)resetCategories
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *category = nil;
    if (indexPath.row != 0) {
        category = [categories objectAtIndex:indexPath.row - 1];
    } else {
        currentCategory = nil;
    }
    
    BOOL categoryChanged = !(currentCategory && [[currentCategory valueForKey:@"slug"] isEqual:[category valueForKey:@"slug"]]);
    currentCategory = nil;
    currentCategory = [[NSDictionary alloc] initWithDictionary:category];
    [[NSNotificationCenter defaultCenter] postNotificationName:N_CATEGORY_SELECTED
                                                        object:nil
                                                      userInfo:currentCategory];
    if (categoryChanged) {
        [[NSNotificationCenter defaultCenter] postNotificationName:N_CATEGORY_CHANGED
                                                            object:nil
                                                          userInfo:currentCategory];
    }
}

- (NSDictionary *)currentCategory
{
    return currentCategory;
}
@end

