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

@interface CategoriesViewController()
{
    NSMutableArray *categories;
    AFJSONRequestOperation *operation;
}

@end
@implementation CategoriesViewController

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
        
        operation = [AFJSONRequestOperation
                     JSONRequestOperationWithRequest:req
                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                         NSArray *result = [JSON objectForKey:@"results"];
                         categories = nil;
                         categories = [NSMutableArray arrayWithArray:result];
                         [myTableView reloadData];
                     }
                     failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error ,id JSON) {
                         NSLog(@"%@",[error debugDescription]);
                     }];
        
        [operation start];
    } else {
        [myTableView reloadData];
    }
}

#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategoryCell"];
    }
    NSDictionary *category = [categories objectAtIndex:indexPath.row];
    [cell.textLabel setText:[category valueForKey:@"name"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
