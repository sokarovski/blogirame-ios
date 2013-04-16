//
//  UIColor+WebColors.m
//  Blogirame
//
//  Created by Petar Sokarovski on 11/13/12.
//  Copyright (c) 2012 ID. All rights reserved.
//

#import "UIColor+WebColors.h"

@implementation UIColor (WebColors)

+ (UIColor *)colorWithHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)colorWithHex:(UInt32)hex andAlfa:(CGFloat)alfa {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alfa];
}

@end
