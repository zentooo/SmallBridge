//
//  SBWebViewDelegate.h
//
//  Created by zentooo on 12/07/14.
//  Copyright (c) 2012 zentooo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "SBResult.h"

@interface SBWebViewDelegate : NSObject <UIWebViewDelegate>

@property (strong, nonatomic) SBJsonParser *jsonParser;

@end
