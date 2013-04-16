//
//  WebViewController.h
//  Blogirame
//
//  Created by Aleksandra Gavrilovska on 4/16/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate, NSCoding>
@property (nonatomic, strong) NSDictionary *postEntry;
@end
