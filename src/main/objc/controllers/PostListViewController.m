//
//  ViewController.m
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "PostListViewController.h"
#import "AFNetworking.h"
#import "EntryCell.h"
#import "AppSettings.h"
#import "Utils.h"
#import "AppDelegate.h"
#import "AppDelegate+Navigation.h"

@interface PostListViewController () {
    AFJSONRequestOperation *operation;
    NSMutableArray *newestEntriesHeights;
    NSMutableArray *topEntriesHeights;
    NSArray *currentEntriesArray;
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
    if ([AppSettings shouldShowNewestPosts]) {
        [self showNewestEntries];
    } else {
        [self showTopEntries];
    }
}

#pragma mark reloadView
- (void)showNewestEntries
{
    if (!newestPosts) {
        [self fetchNewestPostsList];
    } else {
        if ([myTableView numberOfRowsInSection:0] > 0) {
            [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        currentEntriesArray = nil;
        currentEntriesArray = newestPosts;
        [myTableView reloadData];
    }
}

- (void)showTopEntries
{
    if (!topPosts) {
        [self fetchTopPostsList];
    } else {
        if ([myTableView numberOfRowsInSection:0] > 0) {
            [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        currentEntriesArray = nil;
        currentEntriesArray = topPosts;
        [myTableView reloadData];
    }
}

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [currentEntriesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EntryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostItemCell"];
    if (!cell) {
        cell = [[EntryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PostItemCell"];
    }
    NSDictionary *postEntry = [currentEntriesArray objectAtIndex:indexPath.row];
    [cell setupWithEntry:postEntry];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *entryHeights = nil;
    if ([AppSettings shouldShowNewestPosts]) {
        if (!newestPosts) {
            return 0;
        } else {
            entryHeights = newestEntriesHeights;
        }
    } else {
        if (!topPosts) {
            return 0;
        } else {
            entryHeights = topEntriesHeights;
        }
    }
    
    if (entryHeights && [entryHeights count] > indexPath.row && ![[entryHeights objectAtIndex:indexPath.row] isEqual:[NSNull null]]) {
        return [[entryHeights objectAtIndex:indexPath.row] floatValue];
    } else {
        CGFloat height = [EntryCell heightForEntry:[currentEntriesArray objectAtIndex:indexPath.row]];
        [entryHeights replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:height]];
        return height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *postEntry = [currentEntriesArray objectAtIndex:indexPath.row];
    if (postEntry) {
        NSDictionary *values = [NSDictionary dictionaryWithObject:postEntry forKey:@"postEntry"];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showEntryDetailViewWithValues:values];
    }
}

#pragma mark Data Download
- (void)fetchNewestPostsList
{
    if (!newestPosts) {
        NSString *url = @"http://blogirame.mk/jsonapi/main";
        NSURL *base = [NSURL URLWithString:url];
        NSURLRequest *req = [NSURLRequest requestWithURL:base];
        
        operation = [AFJSONRequestOperation
                     JSONRequestOperationWithRequest:req
                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                         NSArray *result = [JSON objectForKey:@"results"];
                         NSMutableArray *editedResults = [NSMutableArray arrayWithCapacity:[result count]];
                         newestEntriesHeights = nil;
                         newestEntriesHeights = [[NSMutableArray alloc] initWithCapacity:[newestPosts count]];
                         for (int i = 0; i < [result count]; i++) {
                             NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:[result objectAtIndex:i]];
                             [temp setValue:[Utils formattedDateStringFromDate:[temp valueForKey:@"date"]] forKey:@"formattedDate"];
                             [editedResults addObject:temp];
                             temp = nil;
                             [newestEntriesHeights addObject:[NSNull null]];
                         }
                         
                         newestPosts = nil;
                         newestPosts = editedResults;
                         
                         if ([AppSettings shouldShowNewestPosts]) {
                             if ([myTableView numberOfRowsInSection:0] > 0) {
                                 [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                             }
                             currentEntriesArray = nil;
                             currentEntriesArray = newestPosts;
                             [myTableView reloadData];
                         }
                     }
                     failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error ,id JSON) {
                         NSLog(@"%@",[error debugDescription]);
                     }];
        
        [operation start];
    }
}

- (void)fetchTopPostsList
{
    if (!topPosts) {
        NSString *url = @"http://blogirame.mk/jsonapi/main/order/popular/";
        NSURL *base = [NSURL URLWithString:url];
        NSURLRequest *req = [NSURLRequest requestWithURL:base];
        
        operation = [AFJSONRequestOperation
                     JSONRequestOperationWithRequest:req
                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                         NSArray *result = [JSON objectForKey:@"results"];
                         NSMutableArray *editedResults = [NSMutableArray arrayWithCapacity:[result count]];
                         
                         topEntriesHeights = nil;
                         topEntriesHeights = [[NSMutableArray alloc] initWithCapacity:[topPosts count]];
                         //AGA: formatted date is cached, because it is expensive operation
                         for (int i = 0; i < [result count]; i++) {
                             NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:[result objectAtIndex:i]];
                             [temp setValue:[Utils formattedDateStringFromDate:[temp valueForKey:@"date"]] forKey:@"formattedDate"];
                             [editedResults addObject:temp];
                             temp = nil;
                             [topEntriesHeights addObject:[NSNull null]];
                         }
                         
                         topPosts = nil;
                         topPosts = editedResults;
                         
                         if (![AppSettings shouldShowNewestPosts]) {
                             if ([myTableView numberOfRowsInSection:0] > 0) {
                                 [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                             }
                             currentEntriesArray = nil;
                             currentEntriesArray = topPosts;
                             [myTableView reloadData];
                         }
                     }
                     failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error ,id JSON) {
                         NSLog(@"%@",[error debugDescription]);
                     }];
        
        [operation start];
    }
}



@end
