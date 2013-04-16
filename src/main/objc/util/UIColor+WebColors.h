//
//  UIColor+WebColors.h
//  Blogirame
//
//  Created by Petar Sokarovski on 11/13/12.
//  Copyright (c) 2012 ID. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WebColors)

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex andAlfa:(CGFloat)alfa;
@end
