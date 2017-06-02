//
//  CMHTMLScriptTransformer.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/16/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMHTMLScriptTransformer.h"
#import "CMHTMLScriptTransformer_Private.h"
#import "CMPlatformDefines.h"

#import "Ono.h"

#if TARGET_OS_IPHONE
#import <CoreText/CTStringAttributes.h>
#endif

@implementation CMHTMLScriptTransformer {
    CMHTMLScriptStyle _style;
    CGFloat _fontSizeRatio;
    CGFloat _baselineOffset;
}

- (instancetype)initWithStyle:(CMHTMLScriptStyle)style fontSizeRatio:(CGFloat)ratio baselineOffset:(CGFloat)offset
{
    if ((self = [super init])) {
        _style = style;
        _fontSizeRatio = ratio;
        _baselineOffset = offset;
    }
    return self;
}

#pragma mark - CMHTMLElementTransformer

+ (NSString *)tagName
{
    NSAssert(NO, @"Must be implemented by a subclass");
    return nil;
}

- (NSAttributedString *)attributedStringForElement:(ONOXMLElement *)element attributes:(NSDictionary *)attributes
{
    CMAssertCorrectTag(element);
    
    NSMutableDictionary *allAttributes = [attributes mutableCopy];
    NSString *superscriptAttribute = nil;
#if TARGET_OS_IPHONE
    superscriptAttribute = (__bridge NSString *)kCTSuperscriptAttributeName;
#else
    superscriptAttribute = NSSuperscriptAttributeName;
#endif
    allAttributes[superscriptAttribute] = @(_style);
    CMFont *font = attributes[NSFontAttributeName];
    if (font != nil) {
        font = [CMFont fontWithDescriptor:font.fontDescriptor size:font.pointSize * _fontSizeRatio];
        allAttributes[NSFontAttributeName] = font;
    }
    if (_baselineOffset != 0.0) {
        allAttributes[NSBaselineOffsetAttributeName] = @(_baselineOffset);
    }

    return [[NSAttributedString alloc] initWithString:element.stringValue attributes:allAttributes];
}

@end
