//
//  CMAttributeRun.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/15/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMAttributeRun.h"

CMAttributeRun * CMDefaultAttributeRun(NSDictionary *attributes)
{
    return [[CMAttributeRun alloc] initWithAttributes:attributes fontTraits:0 orderedListNumber:0];
}

CMAttributeRun * CMTraitAttributeRun(NSDictionary *attributes, CMFontSymbolicTraits traits)
{
    return [[CMAttributeRun alloc] initWithAttributes:attributes fontTraits:traits orderedListNumber:0];
}

CMAttributeRun * CMOrderedListAttributeRun(NSDictionary *attributes, NSInteger startingNumber)
{
    return [[CMAttributeRun alloc] initWithAttributes:attributes fontTraits:0 orderedListNumber:startingNumber];
}

@implementation CMAttributeRun

- (instancetype)initWithAttributes:(NSDictionary *)attributes
                        fontTraits:(CMFontSymbolicTraits)fontTraits
                 orderedListNumber:(NSInteger)orderedListNumber
{
    if ((self = [super init])) {
        _attributes = attributes;
        _fontTraits = fontTraits;
        _orderedListItemNumber = orderedListNumber;
    }
    return self;
}

@end
