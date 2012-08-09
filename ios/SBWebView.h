//
//  SBWebView.h
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MessageListenerBlock)(NSString *source, NSDictionary *data, SBResult *result)
typedef void (^SendMessageResultBlock)(NSDictionary *data)

static int callbackId = 0;

@interface SBWebView : UIWebView

@property (strong, nonatomic) NSDictionary *listenerRegistry;

-(void) sendMessage:(NSString *)type withData:(NSString *)data callback:(SendMessageResultBlock);
-(void) sendMessage:(NSString *)type withData:(NSString *)data target:(id)target selector:(SEL)selector;

-(BOOL) onReceiveMessage:(NSString *)source type:(NSString *)type data:(NSDictionary *)data result:(SBResult *)result;
-(BOOL) addMessageListener:(NSString *)type callback:(MessageListenerBlock)callback;

@end
