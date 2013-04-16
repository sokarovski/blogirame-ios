//
//  AppDelegate.h
//  Blogirame
//
//  Created by Petar Sokarovski on 4/4/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "EntryCell.h"
#import "UIImageView+AFNetworking.h"
#import "Utils.h"

@implementation EntryCell

#define TITLE_FONT [UIFont boldSystemFontOfSize:15]
#define DESCRIPTION_FONT [UIFont systemFontOfSize:13]
#define BLOG_TITLE_FONT [UIFont boldSystemFontOfSize:12]
#define BLOG_TITLE_COLOR [UIColor colorWithRed:0.701 green:0.831 blue:0.988 alpha:1]
#define DATE_FONT [UIFont systemFontOfSize:12]
#define DATE_FONT_COLOR [UIColor lightGrayColor]
static UIImage *placeholderImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 80, 60)];
        [itemImageView setContentMode:UIViewContentModeScaleAspectFit];
        [itemImageView setContentScaleFactor:1];
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
        [blogTitleLabel setFont:BLOG_TITLE_FONT];
        [blogTitleLabel setTextColor:BLOG_TITLE_COLOR];
        [self.contentView addSubview:blogTitleLabel];
        
        dateLabel = [[UILabel alloc] init];
        [dateLabel setFont:DATE_FONT];
        [dateLabel setTextColor:DATE_FONT_COLOR];
        [dateLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:dateLabel];
        
        if (!placeholderImage) {
            placeholderImage = [UIImage imageNamed:@"noimage.png"];
        }
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)adjustFrames
{
    CGSize titleSize = [[titleLabel text] sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(215, MAXFLOAT)];
    [titleLabel setFrame:CGRectMake(95, 3, titleSize.width, titleSize.height)];
    CGSize descriptionSize = [[descriptionLabel text] sizeWithFont:[descriptionLabel font] constrainedToSize:CGSizeMake(215, MAXFLOAT)];
    [descriptionLabel setFrame:CGRectMake(95, titleSize.height + 5, descriptionSize.width, descriptionSize.height)];
    float height = titleSize.height + descriptionSize.height + 8;
    [dateLabel setFrame:CGRectMake(10, MAX(height, 68), 80, 16)];
    [blogTitleLabel setFrame:CGRectMake(95, MAX(height, 68), 215, 16)];
}

- (void)setupWithEntry:(NSDictionary *)entry
{
    [titleLabel setText:[entry valueForKey:@"title"]];
    [blogTitleLabel setText:[entry valueForKey:@"feedTitle"]];
    [descriptionLabel setText:[entry valueForKey:@"description"]];
    [dateLabel setText:[entry valueForKey:@"formattedDate"]];
    
    NSURL *imageURL = nil;
    if (![[entry valueForKey:@"thumb"] isKindOfClass:[NSNull class]]) {
        imageURL = [NSURL URLWithString:[entry valueForKey:@"thumb"]];
    }
    [itemImageView setImageWithURL:imageURL placeholderImage:placeholderImage];
    [self adjustFrames];
}

+ (CGFloat)heightForEntry:(NSDictionary *)entry
{
    float size = 0;
    CGSize titleSize = [[entry valueForKey:@"title"] sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(215, MAXFLOAT)];
    size += titleSize.height + 3;
    CGSize descriptionSize = [[entry valueForKey:@"description"] sizeWithFont:DESCRIPTION_FONT constrainedToSize:CGSizeMake(215, MAXFLOAT)];
    size += descriptionSize.height + 5;
    size += 18;
    return MAX(size, 84);
}

@end
