 /*
 *  Copyright (c) 2014-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "TheodoliteAsyncTransactionGroup.h"

#import "TheodoliteMacros.h"

#import "TheodoliteAsyncTransaction.h"
#import "TheodoliteAsyncTransactionContainer+Private.h"

static void _transactionGroupRunLoopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);

@implementation TheodoliteAsyncTransactionGroup {
  NSHashTable *_containerLayers;
}

+ (TheodoliteAsyncTransactionGroup *)mainTransactionGroup
{
  TheodoliteAssertMainThread();
  static TheodoliteAsyncTransactionGroup *mainTransactionGroup;

  if (mainTransactionGroup == nil) {
    mainTransactionGroup = [[TheodoliteAsyncTransactionGroup alloc] init];
    [self registerTransactionGroupAsMainRunloopObserver:mainTransactionGroup];
  }
  return mainTransactionGroup;
}

+ (void)registerTransactionGroupAsMainRunloopObserver:(TheodoliteAsyncTransactionGroup *)transactionGroup
{
  TheodoliteAssertMainThread();
  static CFRunLoopObserverRef observer;
  NSAssert(observer == NULL, @"A TheodoliteAsyncTransactionGroup should not be registered on the main runloop twice");
  // defer the commit of the transaction so we can add more during the current runloop iteration
  CFRunLoopRef runLoop = CFRunLoopGetCurrent();
  CFOptionFlags activities = (kCFRunLoopBeforeWaiting | // before the run loop starts sleeping
                              kCFRunLoopExit);          // before exiting a runloop run
  CFRunLoopObserverContext context = {
    0,           // version
    (__bridge void *)transactionGroup,  // info
    &CFRetain,   // retain
    &CFRelease,  // release
    NULL         // copyDescription
  };

  observer = CFRunLoopObserverCreate(NULL,        // allocator
                                     activities,  // activities
                                     YES,         // repeats
                                     INT_MAX,     // order after CA transaction commits
                                     &_transactionGroupRunLoopObserverCallback,  // callback
                                     &context);   // context
  CFRunLoopAddObserver(runLoop, observer, kCFRunLoopCommonModes);
  CFRelease(observer);
}

- (id)init
{
  if ((self = [super init])) {
    _containerLayers = [[NSHashTable alloc] initWithOptions:NSHashTableStrongMemory|NSHashTableObjectPointerPersonality capacity:0];
  }
  return self;
}

#pragma mark Public methods

- (void)addTransactionContainer:(CALayer *)containerLayer
{
  TheodoliteAssertMainThread();
  TheodoliteAssertNotNil(containerLayer, @"Cannot add a nil layer to the group");
  [_containerLayers addObject:containerLayer];
}

#pragma mark Transactions

- (void)commit
{
  TheodoliteAssertMainThread();

  if ([_containerLayers count]) {
    NSSet *containerLayersToCommit = [_containerLayers copy];
    [_containerLayers removeAllObjects];

    for (CALayer *containerLayer in containerLayersToCommit) {
      // Note that the act of committing a transaction may open a new transaction,
      // so we must nil out the transaction we're committing first.
      TheodoliteAsyncTransaction *transaction = containerLayer.ck_currentAsyncLayerTransaction;
      containerLayer.ck_currentAsyncLayerTransaction = nil;
      [transaction commit];
    }
  }
}

@end

static void _transactionGroupRunLoopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
  TheodoliteCAssertMainThread();
  TheodoliteAsyncTransactionGroup *group = (__bridge TheodoliteAsyncTransactionGroup *)info;
  [group commit];
}
