/*
 *  Copyright (c) 2014-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "TheodoliteAsyncTransactionContainer+Private.h"

#import "TheodoliteMacros.h"

#import "TheodoliteAsyncTransaction.h"
#import "TheodoliteAsyncTransactionGroup.h"

#import <objc/runtime.h>

@implementation CALayer (TheodoliteAsyncTransactionContainerTransactions)
@dynamic ck_asyncLayerTransactions;
@dynamic ck_currentAsyncLayerTransaction;

// No-ops in the base class. Mostly exposed for testing.
- (void)ck_asyncTransactionContainerWillBeginTransaction:(TheodoliteAsyncTransaction *)transaction {}
- (void)ck_asyncTransactionContainerDidCompleteTransaction:(TheodoliteAsyncTransaction *)transaction {}
@end

@implementation CALayer (TheodoliteAsyncTransactionContainer)

@dynamic ck_asyncTransactionContainer;

- (TheodoliteAsyncTransactionContainerState)ck_asyncTransactionContainerState
{
  return ([self.ck_asyncLayerTransactions count] == 0) ? TheodoliteAsyncTransactionContainerStateNoTransactions : TheodoliteAsyncTransactionContainerStatePendingTransactions;
}

- (void)ck_cancelAsyncTransactions
{
  // If there was an open transaction, commit and clear the current transaction. Otherwise:
  // (1) The run loop observer will try to commit a canceled transaction which is not allowed
  // (2) We leave the canceled transaction attached to the layer, dooming future operations
  TheodoliteAsyncTransaction *currentTransaction = self.ck_currentAsyncLayerTransaction;
  [currentTransaction commit];
  self.ck_currentAsyncLayerTransaction = nil;

  for (TheodoliteAsyncTransaction *transaction in [self.ck_asyncLayerTransactions copy]) {
    [transaction cancel];
  }
}

- (void)ck_asyncTransactionContainerStateDidChange
{
  id delegate = self.delegate;
  if ([delegate respondsToSelector:@selector(ck_asyncTransactionContainerStateDidChange)]) {
    [delegate ck_asyncTransactionContainerStateDidChange];
  }
}

- (TheodoliteAsyncTransaction *)ck_asyncTransaction
{
  TheodoliteAsyncTransaction *transaction = self.ck_currentAsyncLayerTransaction;
  if (transaction == nil) {
    NSHashTable *transactions = self.ck_asyncLayerTransactions;
    if (transactions == nil) {
      transactions = [[NSHashTable alloc] initWithOptions:NSHashTableStrongMemory|NSHashTableObjectPointerPersonality capacity:0];
      self.ck_asyncLayerTransactions = transactions;
    }
    transaction = [[TheodoliteAsyncTransaction alloc] initWithCallbackQueue:dispatch_get_main_queue() completionBlock:^(TheodoliteAsyncTransaction *completedTransaction, BOOL cancelled) {
      [transactions removeObject:completedTransaction];
      [self ck_asyncTransactionContainerDidCompleteTransaction:completedTransaction];
      if ([transactions count] == 0) {
        [self ck_asyncTransactionContainerStateDidChange];
      }
    }];
    [transactions addObject:transaction];
    self.ck_currentAsyncLayerTransaction = transaction;
    [self ck_asyncTransactionContainerWillBeginTransaction:transaction];
    if ([transactions count] == 1) {
      [self ck_asyncTransactionContainerStateDidChange];
    }
  }
  [[TheodoliteAsyncTransactionGroup mainTransactionGroup] addTransactionContainer:self];
  return transaction;
}

- (CALayer *)ck_parentTransactionContainer
{
  CALayer *containerLayer = self;
  while (containerLayer && !containerLayer.ck_isAsyncTransactionContainer) {
    containerLayer = containerLayer.superlayer;
  }
  return containerLayer;
}

@end

@implementation UIView (TheodoliteAsyncTransactionContainer)

- (BOOL)ck_isAsyncTransactionContainer
{
  return self.layer.ck_isAsyncTransactionContainer;
}

- (void)ck_setAsyncTransactionContainer:(BOOL)asyncTransactionContainer
{
  self.layer.ck_asyncTransactionContainer = asyncTransactionContainer;
}

- (TheodoliteAsyncTransactionContainerState)ck_asyncTransactionContainerState
{
  return self.layer.ck_asyncTransactionContainerState;
}

- (void)ck_cancelAsyncTransactions
{
  [self.layer ck_cancelAsyncTransactions];
}

- (void)ck_asyncTransactionContainerStateDidChange
{
  // No-op in the base class.
}

@end

static void *ck_asyncTransactionContainerKey = &ck_asyncTransactionContainerKey;
static void *ck_asyncLayerTransactionsKey = &ck_asyncLayerTransactionsKey;
static void *ck_currentAsyncLayerTransactionKey = &ck_currentAsyncLayerTransactionKey;

@implementation CALayer (TheodoliteAsyncTransactionContainerStorage)

- (BOOL)ck_isAsyncTransactionContainer
{
  return [objc_getAssociatedObject(self, ck_asyncTransactionContainerKey) boolValue];
}

- (void)ck_setAsyncTransactionContainer:(BOOL)asyncTransactionContainer
{
  objc_setAssociatedObject(self, ck_asyncTransactionContainerKey, @(asyncTransactionContainer), OBJC_ASSOCIATION_RETAIN);
}
// https://github.com/facebook/Theodolite/issues/761
- (NSHashTable *)ck_asyncLayerTransactions
{
  return objc_getAssociatedObject(self, ck_asyncLayerTransactionsKey);
}

- (void)ck_setAsyncLayerTransactions:(NSHashTable *)transactions
{
  objc_setAssociatedObject(transactions, ck_asyncLayerTransactionsKey, transactions, OBJC_ASSOCIATION_RETAIN);
}

- (TheodoliteAsyncTransaction *)ck_currentAsyncLayerTransaction
{
  return objc_getAssociatedObject(self, ck_currentAsyncLayerTransactionKey);
}

- (void)ck_setCurrentAsyncLayerTransaction:(TheodoliteAsyncTransaction *)transaction
{
  objc_setAssociatedObject(self, ck_currentAsyncLayerTransactionKey, transaction, OBJC_ASSOCIATION_RETAIN);
}

@end
