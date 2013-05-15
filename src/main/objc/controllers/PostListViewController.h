//
//  ViewController.h
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *myTableView;
    NSMutableArray *topPosts;
    NSMutableArray *newestPosts;
    NSMutableArray *categories;
}

- (void)showNewestEntries;
- (void)showTopEntries;
@end
