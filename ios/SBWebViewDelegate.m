//
//  SBWebViewDelegate.m
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import "SBWebViewDelegate.h"

@implementation SBWebViewDelegate
{
    NSString* sbscheme;
    SBJsonParser *jsonParser;
    NSMutableDictionary *listeners;
}

- (id) init
{
    self = [super init];
    if ( self != nil ) {
        sbscheme = @"smallbridge://";
        jsonParser = [[SBJsonParser alloc] init];
        listeners = [[NSMutableDictionary alloc] init];
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
    NSRange range = [url rangeOfString:sbscheme];

    if ( range.location == NSNotFound )
    {
        return YES;
    }
    else
    {
        NSString *source = [[request allHTTPHeaderFields] objectForKey:@"Referer"];
        
        NSString *jsonMessage = [url substringFromIndex:range.length];
        NSDictionary *message = (NSDictionary *)[jsonParser objectWithString:jsonMessage];
        
        NSString *type = [message objectForKey:@"type"];
        NSDictionary *data = [message objectForKey:@"data"];
        NSNumber *callbackId = [message objectForKey:@"callbackId"];
        
        SBResult* result = [[SBResult alloc] init:webView messageType:type callbackId:callbackId];
        
        [self onReceiveMessage:source type:type data:data result:result];
        
        return NO;
    }
}

-(void) onReceiveMessage:(NSString *)source type:(NSString *)type data:(NSDictionary *)data result:(SBResult *)result
{
    id callback = [listeners objectForKey:type];

    if ( callback == nil )
    {
        return;
    }
    else if ( [callback isKindOfClass:[NSDictionary class]] )
    {
        NSDictionary *dict = (NSDictionary *)callback;
        id target = [dict objectForKey:@"target"];
        SEL selector = NSSelectorFromString([dict objectForKey:@"selector"]);
        
        if ( [target respondsToSelector:selector] ) {
            NSMethodSignature *sig = [target methodSignatureForSelector:selector];
            NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
            [inv setTarget:target];
            [inv setSelector:selector];
            [inv setArgument:&type atIndex:2];
            [inv setArgument:&data atIndex:3];
            [inv setArgument:&result atIndex:4];
            [inv invoke];
        }
        
    }
    else {
        ((MessageListenerCallback)callback)(source, data, result);
    }
}

-(void) addMessageListener:(NSString *)type callback:(MessageListenerCallback)callback
{
    [listeners setObject:callback forKey:type];
}

-(void) addMessageListener:(NSString *)type target:(id)target selector:(SEL)selector
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:target, @"target", NSStringFromSelector(selector), @"selector", nil];
    [listeners setObject:dict forKey:type];
}

#if __has_feature(objc_arc)
#else
-(void) dealloc
{
    [sbscheme release];
    [jsonParser release];
    [listeners release];
    [super dealloc];
}
#endif

@end