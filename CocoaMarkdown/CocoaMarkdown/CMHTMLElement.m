//
//  CMHTMLElement.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/16/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMHTMLElement.h"
#import "CMHTMLElementTransformer.h"

@implementation CMHTMLElement

- (instancetype)initWithTransformer:(id<CMHTMLElementTransformer>)transformer
{
    if ((self = [super init])) {
        _transformer = transformer;
        _buffer = [[NSMutableString alloc] init];
    }
    return self;
}

- (NSString *)tagName;
{
    return [_transformer.class tagName];
}

@end
