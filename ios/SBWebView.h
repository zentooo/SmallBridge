//
//  SBWebView.h
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MessageListenerBlock)(NSString *source, NSDictionary *data, SBResult *result)

@interface SBWebView : UIWebView

@property (strong, nonatomic) NSDictionary *listenerRegistry;

-(BOOL) onReceiveMessage:(NSString *)source type:(NSString *)type data:(NSDictionary *)data result:(SBResult *)result;

-(BOOL) addMessageListener:(NSString *)type callback:(MessageListenerBlock)callback;
-(BOOL) addMessageListener:(NSString *)type target:(id)target selector:(SEL)selector;

@end
