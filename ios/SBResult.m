//
//  SBResult.m
//  Unreader
//
//  Created by Yokoe zentooo on 12/08/09.
//  Copyright (c) 2012年 zentooo. All rights reserved.
//

#import "SBResult.h"

@implementation SBResult
{
    SBJsonWriter *jsonWriter;
    UIWebView *webView;
    NSString *messageType;
    NSNumber *callbackId;
}

-(id) init:(UIWebView *)wv messageType:(NSString *)type callbackId:(NSNumber *)cid
{
    self = [super init];
    if ( self != nil ) {
        jsonWriter = [[SBJsonWriter alloc] init];
#if __has_feature(objc_arc)
        webView = wv;
#else
        webView = [wv retain];
#endif
        messageType = type;
        callbackId = cid;
    }
    return self;
}

-(void) provide:(NSDictionary *)data error:(NSError *)error
{
    NSString* jsString;

    if ( error == nil ) {
        jsString = [NSString stringWithFormat:@"SmallBridge._receive('%@', %@, void 0, %@);",
            messageType,
            callbackId,
            [jsonWriter stringWithObject:data]
        ];
    }
    else {
        jsString = [NSString stringWithFormat:@"SmallBridge._receive('%@', %@, %@, %@);",
            messageType,
            callbackId,
            error,
            [jsonWriter stringWithObject:data]
        ];
    }

    [webView stringByEvaluatingJavaScriptFromString:jsString];
}

#if __has_feature(objc_arc)
#else
-(void) dealloc
{
    [jsonWriter release];
    [webView release];
    [messageType release];
    [callbackId release];
    [super dealloc];
}
#endif

@end