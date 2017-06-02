//
//  CMIterator.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/13/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CMEventType) {
    CMEventTypeNone,
    CMEventTypeDone,
    CMEventTypeEnter,
    CMEventTypeExit
};

@class CMNode;

/**
 *  Walks through a tree of nodes.
 */
@interface CMIterator : NSObject

/**
 *  Initializes the receiver with a root node.
 *
 *  @param rootNode Root node to start traversing from.
 *
 *  @return An initialized instance of the receiver.
 */
- (instancetype)initWithRootNode:(CMNode *)rootNode;

/**
 *  Returns the current node.
 */
@property (readonly) CMNode *currentNode;

/**
 *  Returns the current event type.
 */
@property (readonly) CMEventType currentEvent;

/**
 *  Walks through a tree of nodes, starting from the root node.
 *
 *  @discussion See the section on iterators in cmark.h for more details.
 *
 *  @param block Block to call upon entering or exiting a node during traversal.
 *  Set `stop` to `YES` to stop iteration.
 */
- (void)enumerateUsingBlock:(void (^)(CMNode *node, CMEventType event, BOOL *stop))block;

/**
 *  Resets the iterator to the specified node and event. The node must be either
 *  the root node or a child of the root node.
 *
 *  @param node      The node to reset to.
 *  @param eventType The event to reset to.
 */
- (void)resetToNode:(CMNode *)node withEventType:(CMEventType)eventType;

@end
