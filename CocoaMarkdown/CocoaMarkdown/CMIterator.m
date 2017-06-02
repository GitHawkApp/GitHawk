//
//  CMIterator.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/13/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMIterator.h"
#import "CMNode_Private.h"

@implementation CMIterator {
    cmark_iter *_iter;
}

#pragma mark - Initialization

- (instancetype)initWithRootNode:(CMNode *)rootNode
{
    NSParameterAssert(rootNode);
    
    if ((self = [super init])) {
        _iter = cmark_iter_new(rootNode.node);
        if (_iter == NULL) return nil;
    }
    return self;
}

- (void)dealloc
{
    cmark_iter_free(_iter);
}

#pragma mark - Accessors

- (CMNode *)currentNode
{
    return [[CMNode alloc] initWithNode:cmark_iter_get_node(_iter) freeWhenDone:NO];
}

- (CMEventType)currentEvent
{
    return (CMEventType)cmark_iter_get_event_type(_iter);
}

#pragma mark - Iteration

- (void)enumerateUsingBlock:(void (^)(CMNode *node, CMEventType event, BOOL *stop))block
{
    NSParameterAssert(block);
    
    cmark_event_type event;
    BOOL stop = NO;
    
    while ((event = cmark_iter_next(_iter)) != CMARK_EVENT_DONE) {
        CMNode *currentNode = [[CMNode alloc] initWithNode:cmark_iter_get_node(_iter) freeWhenDone:NO];
        block(currentNode, (CMEventType)event, &stop);
        if (stop) break;
    }
}

- (void)resetToNode:(CMNode *)node withEventType:(CMEventType)eventType
{
    cmark_iter_reset(_iter, node.node, (cmark_event_type)eventType);
}

@end
