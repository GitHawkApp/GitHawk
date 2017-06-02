//
//  CMHTMLSuperscriptTransformer.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/16/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMHTMLSuperscriptTransformer.h"
#import "CMHTMLScriptTransformer_Private.h"

@implementation CMHTMLSuperscriptTransformer

- (instancetype)init
{
    return [self initWithFontSizeRatio:0.7];
}

- (instancetype)initWithFontSizeRatio:(CGFloat)ratio
{
    return [self initWithStyle:CMHTMLScriptStyleSuperscript fontSizeRatio:ratio baselineOffset:0.0];
}

- (instancetype)initWithFontSizeRatio:(CGFloat)ratio baselineOffset:(CGFloat)offset
{
    return [super initWithStyle:CMHTMLScriptStyleSuperscript fontSizeRatio:ratio baselineOffset:offset];
}

#pragma mark - CMHTMLElementTransformer

+ (NSString *)tagName { return @"sup"; };

@end
