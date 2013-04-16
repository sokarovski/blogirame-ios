//
//  WebViewController.m
//  Blogirame
//
//  Created by Aleksandra Gavrilovska on 4/16/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () {
    UIWebView *aWebView;
}
@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self loadWebView];
}

- (void)setupView
{
    //TODO add toolbar with back and forward buttons
    if (!aWebView) {
        aWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        [aWebView setDelegate:self];
        [[aWebView scrollView] setScrollEnabled:YES];
    }
    [self.view addSubview:aWebView];
}

- (void)loadWebView
{
    NSURL *requestURL = [NSURL URLWithString:[self.postEntry valueForKey:@"mobile_url"]];
    if (requestURL) {
        [aWebView loadRequest:[NSURLRequest requestWithURL:requestURL]];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    [self resizeForm];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //TODO Show alert
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)resizeForm
{
    NSString *string = [aWebView stringByEvaluatingJavaScriptFromString:@"document.height;"];
    CGFloat height = MAX(self.view.frame.size.height, [string floatValue]);
    CGRect webViewFrame = CGRectMake(0, 0, self.view.frame.size.width, height + 44);
    [[aWebView scrollView] setContentSize:CGSizeMake(self.view.frame.size.width, webViewFrame.size.height)];
}

#pragma mark - NSCoding Protocol Methods
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.postEntry forKey:@"postEntry"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.postEntry = [coder decodeObjectForKey:@"postEntry"];
    }
    return self;
}
@synthesize postEntry;
@end
