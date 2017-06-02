//
//  CMHTMLScriptTransformer_Private.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/16/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMHTMLScriptTransformer.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

typedef NS_ENUM(NSInteger, CMHTMLScriptStyle) {
    CMHTMLScriptStyleSubscript = -1,
    CMHTMLScriptStyleSuperscript = 1
};

@interface CMHTMLScriptTransformer ()
- (instancetype)initWithStyle:(CMHTMLScriptStyle)style fontSizeRatio:(CGFloat)ratio baselineOffset:(CGFloat)offset;
@end
