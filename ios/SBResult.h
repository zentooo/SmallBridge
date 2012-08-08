//
//  SBResult.h
//  Unreader
//
//  Created by zentooo on 12/08/09.
//  Copyright (c) 2012年 zentooo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJsonWriter.h"

@interface SBResult : NSObject

@property (strong, nonatomic) SBJsonWriter *jsonWriter;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSNumber *callbackId;

-(void) obtain:(NSDictionary *) data;

@end
