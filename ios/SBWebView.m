//
//  SBWebView.m
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import "SBWebView.h"

@implementation SBWebView

- (void)sendMessage:(NSBundle *)bundle withData:(NSString *)data
{
    NSString* bundleId = [bundle bundleIdentifier];
    NSString* jsString = [NSString stringWithFormat:@"SmallBridge.messageCallback(\"%@\", \"%@\");", bundleId, data];
    [self stringByEvaluatingJavaScriptFromString: jsString];
}

@end
