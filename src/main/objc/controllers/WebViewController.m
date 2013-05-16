//
//  WebViewController.m
//  Blogirame
//
//  Created by Aleksandra Gavrilovska on 4/16/13.
//  Copyright (c) 2013 ID. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate+StatusBar.h"

@interface WebViewController () {
    UIWebView *aWebView;
    UIBarButtonItem *shareButton;
}
@end

@implementation WebViewController

- (void)setupNavigationItem
{
    if (!shareButton) {
        shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                    target:self
                                                                    action:@selector(shareItem)];
    }
    [self.navigationItem setRightBarButtonItem:shareButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationItem];
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
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] showNetworkActivityIndicator];
        [aWebView loadRequest:[NSURLRequest requestWithURL:requestURL]];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideNetworkActivityIndicator];
    [self resizeForm];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //TODO Show alert
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hideNetworkActivityIndicator];
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

#pragma mark Share
- (void)shareByActivityController
{
    NSArray *activityItems = [NSArray arrayWithObjects:
                              [postEntry valueForKey:@"title"], [postEntry valueForKey:@"url"],  nil];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                             applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    
    [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed) {
        NSLog(@"Activity = %@",activityType);
        NSLog(@"Completed Status = %d",completed);
        
        if (completed) {
            //TODO maybe nothing
        } else {
            //TODO show alert
        }
    }];
    
}

- (void)shareByActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share post"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Email", @"Twitter", @"Facebook", nil];
    [actionSheet showInView:self.view];
}

- (void)shareItem
{
    Class class = NSClassFromString(@"UIActivityViewController");
    if (class) {
        [self shareByActivityController];
    } else {
        [self shareByActionSheet];
    }
}
@synthesize postEntry;
@end
