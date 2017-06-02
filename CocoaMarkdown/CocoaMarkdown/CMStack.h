//
//  CMStack.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/16/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Array backed stack.
 */
@interface CMStack : NSObject
@property (nonatomic, readonly) NSArray *objects;

- (void)push:(id)object;
- (id)pop;
- (id)peek;
@end
