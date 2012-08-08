//
//  SBWebViewDelegate.m
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import "SBWebViewDelegate.h"

@implementation SBWebViewDelegate

@synthesize jsonParser;

- (id) init
{
    self = [super init];
    if ( self != nil ) {
        self.jsonParser = [[SBJsonParser alloc] init];
    }
    
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString: @"SmallBridge.setPlatform('ios');"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* sbscheme = @"smallbridge://";
    NSRange range = [url rangeOfString:sbscheme];
    
    if ( range.location == NSNotFound )
    {
        return YES;
    }
    else
    {
        NSString* source = [[request allHTTPHeaderFields] objectForKey:@"Referer"];
        NSString* jsonMessage = [url substringFromIndex:range.length];
        NSDictionary* message = (NSDictionary *)[self.jsonParser objectWithString:jsonMessage];
        
        SBResult* result = [[SBResult alloc] init];
        result.webView = webView;
        result.type = [message objectForKey:@"type"];
        result.callbackId = [message objectForKey:@"callbackId"];
        
        return [self onReceiveMessage:source type:[message objectForKey:@"type"] data:[message objectForKey:@"data"] result:result];
    }
}

-(BOOL) onReceiveMessage:(NSString *)source type:(NSString *)type data:(NSDictionary *)data result:(SBResult *)result
{
    NSLog(@"subclass of SBWebViewDelegate should implement -(BOOL) onReceiveMessage:(NSString *)source type:(NSString *)type data:(NSDictionary *)data result:(SBResult *)result");
}

@end
