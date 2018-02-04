/*
 *  Copyright (c) 2014-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import <UIKit/UIKit.h>

#import <Theodolite/TheodoliteAsyncTransactionContainer.h>

@class TheodoliteAsyncTransaction;

/// A group of transaction container layers, for which the current transactions are committed together at the end of the next runloop tick.
@interface TheodoliteAsyncTransactionGroup : NSObject

/// The main transaction group is scheduled to commit on every tick of the main runloop.
+ (instancetype)mainTransactionGroup;

/// Add a transaction container to be committed.
/// @param containerLayer A layer containing a transaction to be commited. May or may not be a container layer.
/// @see TheodoliteAsyncTransactionContainer
- (void)addTransactionContainer:(CALayer *)containerLayer;

@end
