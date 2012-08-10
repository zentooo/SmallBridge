//
//  SBWebViewDelegate.h
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "SBResult.h"

typedef void (^MessageListenerCallback)(NSString *source, NSDictionary *data, SBResult *result);

@interface SBWebViewDelegate : NSObject <UIWebViewDelegate>

-(void) onReceiveMessage:(NSString *)source type:(NSString *)type data:(NSDictionary *)data result:(SBResult *)result;

-(void) addMessageListener:(NSString *)type callback:(MessageListenerCallback)callback;
-(void) addMessageListener:(NSString *)type target:(id)target selector:(SEL)selector;

@end
