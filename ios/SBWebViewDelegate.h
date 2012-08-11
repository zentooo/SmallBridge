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

-(void) addMessageListener:(NSString *)messageType callback:(MessageListenerCallback)callback;
-(void) addMessageListener:(NSString *)messageType target:(id)target selector:(SEL)selector;

@end
