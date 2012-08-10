//
//  SBResult.m
//  Unreader
//
//  Created by Yokoe zentooo on 12/08/09.
//  Copyright (c) 2012年 zentooo. All rights reserved.
//

#import "SBResult.h"

@implementation SBResult

@synthesize jsonWriter;
@synthesize webView;
@synthesize type;
@synthesize callbackId;

-(id) init
{
    self = [super init];
    if ( self != nil ) {
        self.jsonWriter = [[SBJsonWriter alloc] init];
    }
    return self;
}

-(void) provide:(NSDictionary *)data error:(NSError *)error
{
    NSString* jsString;

    if ( error == nil ) {
        jsString = [NSString stringWithFormat:@"SmallBridge._receive('%@', %@, void 0, %@);",
            self.type,
            self.callbackId,
            [self.jsonWriter stringWithObject:data]
        ];
    }
    else {
        jsString = [NSString stringWithFormat:@"SmallBridge._receive('%@', %@, %@, %@);",
            self.type,
            self.callbackId,
            error,
            [self.jsonWriter stringWithObject:data]
        ];
    }

    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
}

@end
