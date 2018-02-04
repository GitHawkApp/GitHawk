/*
 *  Copyright (c) 2014-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import <Theodolite/TheodoliteAsyncLayer.h>
#import <Theodolite/TheodoliteAsyncTransaction.h>

@class TheodoliteAsyncTransaction;

@protocol TheodoliteAsyncLayerDrawingDelegate
- (void)drawAsyncLayerInContext:(CGContextRef)context parameters:(NSObject *)parameters;
@end

@interface TheodoliteAsyncLayer ()
{
  int32_t _displaySentinel;
}

/**
 @summary The dispatch queue used for async display.

 @desc This is exposed here for tests only.
 */
+ (dispatch_queue_t)displayQueue;

+ (ck_async_transaction_operation_block_t)asyncDisplayBlockWithBounds:(CGRect)bounds
                                                        contentsScale:(CGFloat)contentsScale
                                                               opaque:(BOOL)opaque
                                                      backgroundColor:(CGColorRef)backgroundColor
                                                      displaySentinel:(int32_t *)displaySentinel
                                         expectedDisplaySentinelValue:(int32_t)expectedDisplaySentinelValue
                                                      drawingDelegate:(id<TheodoliteAsyncLayerDrawingDelegate>)drawingDelegate
                                                       drawParameters:(NSObject *)drawParameters;

@end
