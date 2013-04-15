//
//  AppDelegate.h
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryCell : UITableViewCell
{
    UIImageView *itemImageView;
    UILabel *titleLabel;
    UILabel *descriptionLabel;
    UILabel *dateLabel;
    UILabel *blogTitleLabel;
    BOOL hasImage;
}

- (void)setupWithEntry:(NSDictionary *)entry;
+ (CGFloat)heightForEntry:(NSDictionary *)entry;
@end
