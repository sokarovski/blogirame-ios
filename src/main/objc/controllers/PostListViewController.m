//
//  ViewController.m
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "PostListViewController.h"
#import "AFNetworking.h"

@interface PostListViewController () {
    AFJSONRequestOperation *operation;
}

@end

@implementation PostListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //TODO show loading view
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchNewestPostsList];
    //start download of the posts if they are not downloaded
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newestPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PostCell"];
    }
    NSDictionary *postEntry = [newestPosts objectAtIndex:indexPath.row];
    [cell.textLabel setText:[postEntry valueForKey:@"title"]];
    return cell;
}

#pragma mark Data Download

- (void)fetchNewestPostsList
{
    NSString *url = @"http://blogirame.mk/jsonapi/main";
    NSURL *base = [NSURL URLWithString:url];
    NSURLRequest *req = [NSURLRequest requestWithURL:base];
    
    operation = [AFJSONRequestOperation
                 JSONRequestOperationWithRequest:req
                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                     newestPosts = nil;
                     newestPosts = [JSON objectForKey:@"results"];
                     [myTableView reloadData];
                 }
                 failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error ,id JSON) {
                     NSLog(@"%@",[error debugDescription]);
                 }];
    
    [operation start];
}

- (void)fetchTopPostsList
{
    NSString *url = @"http://blogirame.mk/jsonapi/main/order/popular/";
    NSURL *base = [NSURL URLWithString:url];
    NSURLRequest *req = [NSURLRequest requestWithURL:base];
    
    operation = [AFJSONRequestOperation
                 JSONRequestOperationWithRequest:req
                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                     topPosts = nil;
                     topPosts = [JSON objectForKey:@"results"];
                     [myTableView reloadData];
                 }
                 failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error ,id JSON) {
                     NSLog(@"%@",[error debugDescription]);
                 }];
    
    [operation start];
}

@end
