
//
//  CMStack.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/16/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMStack.h"

@implementation CMStack {
    NSMutableArray *_objects;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _objects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)push:(id)object
{
    [_objects addObject:object];
}

- (id)pop
{
    id object = _objects.lastObject;
    [_objects removeLastObject];
    return object;
}

- (id)peek
{
    return _objects.lastObject;
}

@end
