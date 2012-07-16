//
//  SBWebView.h
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SBWebView : UIWebView

-(void) sendMessage:(NSBundle *)bundle withData:(NSString *)data;

@end
