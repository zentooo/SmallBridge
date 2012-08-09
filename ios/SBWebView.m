//
//  SBWebView.m
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import "SBWebView.h"

@implementation SBWebView

@synthesize listenerRegistry;

-(id) init
{
    self = [super init];
    if ( self != nil ) {
        self.listenerRegistry = [[NSDictionary alloc] init];
    }
    return self;
}

-(BOOL) onReceiveMessage:(NSString *)source type:(NSString *)type data:(NSDictionary *)data result:(SBResult *)result
{
    id callback = [self.listenerRegistry objectForKey:type];

    // FIXME
    if ( callback is block ) {
        callback(source, data, result);
    }
    else {
    }
}

-(BOOL) addMessageListener:(NSString *)type withCallback:(MessageListenerBlock)callback
{
    [self.listenerRegistry setObject:callback forKey:type];
}

-(BOOL) addMessageListener:(NSString *)type target:(id)target selector:(SEL)selector
{
    NSDictionary* callback = nil; // FIXME: set target and selector
    [self.listenerRegistry setObject:callback forKey:type];
}

@end
