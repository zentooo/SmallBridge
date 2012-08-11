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

-(id) init:(UIWebView *)webView messageType:(NSString *)messageType callbackId:(NSNumber *)callbackId;
-(void) provide:(NSDictionary *) data error:(NSError *)error;

@end
