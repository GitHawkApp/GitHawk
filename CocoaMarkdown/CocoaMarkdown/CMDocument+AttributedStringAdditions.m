//
//  CMDocument+AttributedStringAdditions.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/20/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMDocument+AttributedStringAdditions.h"
#import "CMAttributedStringRenderer.h"

@implementation CMDocument (AttributedStringAdditions)

- (NSAttributedString *)attributedStringWithAttributes:(CMTextAttributes *)attributes
{
    CMAttributedStringRenderer *renderer = [[CMAttributedStringRenderer alloc] initWithDocument:self attributes:attributes];
    return [renderer render];
}

@end
