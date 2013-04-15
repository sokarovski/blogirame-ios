//
//  AppDelegate.h
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "EntryCell.h"

@implementation EntryCell
#define TITLE_FONT [UIFont boldSystemFontOfSize:15]
#define DESCRIPTION_FONT [UIFont systemFontOfSize:13]

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 80, 80)];
        [self.contentView addSubview:itemImageView];
        titleLabel = [[UILabel alloc] init];
        [titleLabel setNumberOfLines:0];
        [titleLabel setFont:TITLE_FONT];
        //TODO titleLabel style can be set here
        [self.contentView addSubview:titleLabel];
        //TODO descriptionLabel style can be set here
        descriptionLabel = [[UILabel alloc] init];
        [descriptionLabel setNumberOfLines:0];
        [descriptionLabel setFont:DESCRIPTION_FONT];
        [self.contentView addSubview:descriptionLabel];
        //TODO blogTitleLabel style can be set here
        blogTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:blogTitleLabel];
        dateLabel = [[UILabel alloc] init];
        [self.contentView addSubview:dateLabel];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)adjustFrames
{
    CGSize titleSize = [[titleLabel text] sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(hasImage? 215 : 300, MAXFLOAT)];
    [titleLabel setFrame:CGRectMake(hasImage ? 95 : 10, 3, titleSize.width, titleSize.height)];
    CGSize descriptionSize = [[descriptionLabel text] sizeWithFont:[descriptionLabel font] constrainedToSize:CGSizeMake(hasImage? 215 : 300, MAXFLOAT)];
    [descriptionLabel setFrame:CGRectMake(hasImage? 95 : 10, titleSize.height + 5, descriptionSize.width, descriptionSize.height)];
}

- (void)setupWithEntry:(NSDictionary *)entry
{
    hasImage = [[entry valueForKey:@"thumb"] isKindOfClass:[NSNull class]] ? NO : YES;
    [titleLabel setText:[entry valueForKey:@"title"]];
    [blogTitleLabel setText:[entry valueForKey:@"feedTitle"]];
    [descriptionLabel setText:[entry valueForKey:@"description"]];
    //TODO format the date according to date locale
    [dateLabel setText:[entry valueForKey:@"date"]];
    [self adjustFrames];
}

+ (CGFloat)heightForEntry:(NSDictionary *)entry
{
    BOOL entryHasImage = [[entry valueForKey:@"thumb"] isKindOfClass:[NSNull class]] ? NO : YES;
    float size = 0;
    CGSize titleSize = [[entry valueForKey:@"title"] sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(entryHasImage? 215 : 300, MAXFLOAT)];
    size += titleSize.height + 3;
    CGSize descriptionSize = [[entry valueForKey:@"description"] sizeWithFont:DESCRIPTION_FONT constrainedToSize:CGSizeMake(entryHasImage? 215 : 300, MAXFLOAT)];
    size += descriptionSize.height + 5;
    return size;
}

@end
