//
//  SBWebViewDelegate.m
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import "SBWebViewDelegate.h"

@implementation SBWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url = [[request URL] absoluteString];
    NSString* sbscheme = @"smallbridge://";
    NSRange range = [url rangeOfString:sbscheme];
    
    if ( range.location != 0 )
    {
        return NO;
    }
    else
    {
        SEL callbackSelector = @selector(onReceiveMessage:withData:);
        
        if ( ! [self respondsToSelector:callbackSelector] )
        {
            NSLog(@"subclass of SBWebViewDelegate should implement onReceiveMessage:withData:");
            return NO;
        }
        else
        {
            NSString* source = [[request allHTTPHeaderFields] objectForKey:@"Referer"];
            NSString* data = [url substringFromIndex:range.length];
            [self performSelector:callbackSelector withObject:source withObject:data];
            return YES;
        }
    }
}

@end
