//
//  CMCascadingAttributeStack.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/15/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMCascadingAttributeStack.h"
#import "CMAttributeRun.h"
#import "CMPlatformDefines.h"
#import "CMStack.h"

static CMFont * CMFontWithTraits(CMFontSymbolicTraits traits, CMFont *font)
{
    CMFontSymbolicTraits combinedTraits = font.fontDescriptor.symbolicTraits | (traits & 0xFFFF);
#if TARGET_OS_IPHONE
    UIFontDescriptor *descriptor = [font.fontDescriptor fontDescriptorWithSymbolicTraits:combinedTraits];
    return [UIFont fontWithDescriptor:descriptor size:font.pointSize];
#else
    NSDictionary *attributes = @{
        NSFontFamilyAttribute: font.familyName,
        NSFontTraitsAttribute: @{
            NSFontSymbolicTrait: @(combinedTraits)
        },
    };
    NSFontDescriptor *descriptor = [NSFontDescriptor fontDescriptorWithFontAttributes:attributes];
    return [NSFont fontWithDescriptor:descriptor size:font.pointSize];
#endif
}

@implementation CMCascadingAttributeStack {
    CMStack *_stack;
    NSDictionary *_cascadedAttributes;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _stack = [[CMStack alloc] init];
    }
    return self;
}

- (void)push:(CMAttributeRun *)run
{
    [_stack push:run];
    _cascadedAttributes = nil;
}

- (CMAttributeRun *)pop
{
    _cascadedAttributes = nil;
    return [_stack pop];
}

- (CMAttributeRun *)peek
{
    return [_stack peek];
}

- (NSDictionary *)cascadedAttributes
{
    if (_cascadedAttributes == nil) {
        NSMutableDictionary *allAttributes = [[NSMutableDictionary alloc] init];
        for (CMAttributeRun *run in _stack.objects) {
            CMFont *baseFont;
            CMFont *adjustedFont;
            if (run.fontTraits != 0 &&
                (baseFont = allAttributes[NSFontAttributeName]) &&
                (adjustedFont = CMFontWithTraits(run.fontTraits, baseFont))) {
                
                NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:run.attributes];
                attributes[NSFontAttributeName] = adjustedFont;
                [allAttributes addEntriesFromDictionary:attributes];
            } else if (run.attributes != nil) {
                [allAttributes addEntriesFromDictionary:run.attributes];
            }
        }
        _cascadedAttributes = allAttributes;
    }
    return _cascadedAttributes;
}

@end
