//
//  CMDocument+HTMLAdditions.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/20/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMDocument+HTMLAdditions.h"

@implementation CMDocument (HTMLAdditions)

- (NSString *)HTMLString
{
    CMHTMLRenderer *renderer = [[CMHTMLRenderer alloc] initWithDocument:self];
    return [renderer render];
}

@end
