//
//  SBWebViewDelegate.m
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import "SBWebViewDelegate.h"

@implementation SBWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString: @"SmallBridge.setPlatform('ios');"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url = [[request URL] absoluteString];
    NSString* sbscheme = @"smallbridge://";
    NSRange range = [url rangeOfString:sbscheme];
    
    if ( range.location == NSNotFound )
    {
        return YES;
    }
    else
    {
        SEL callbackSelector = @selector(onReceiveMessage:withData:);
        
        if ( ! [self respondsToSelector:callbackSelector] )
        {
            NSLog(@"subclass of SBWebViewDelegate should implement -(BOOL)onReceiveMessage:(NSData *)source withData:(NSData *)data");
            return YES;
        }
        else
        {
            NSString* source = [[request allHTTPHeaderFields] objectForKey:@"Referer"];
            NSString* data = [url substringFromIndex:range.length];
            return (BOOL)[self performSelector:callbackSelector withObject:source withObject:data];
        }
    }
}

@end
