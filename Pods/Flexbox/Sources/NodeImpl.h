#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Yoga.h"

NS_ASSUME_NONNULL_BEGIN

/// The private wrapper around `YGNodeRef`.
/// @warning This should not be used directly.
@interface NodeImpl : NSObject

@property (nonatomic, readonly, assign) YGNodeRef node;

@property (nonatomic, copy) NSArray *children;

@property (nonatomic, readonly, assign) CGRect frame;

@property (nonatomic, copy) CGSize (^measure)(CGSize size);

- (void)layout;

- (void)layoutWithMaxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
