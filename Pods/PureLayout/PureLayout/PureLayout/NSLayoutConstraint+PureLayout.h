//
//  NSLayoutConstraint+PureLayout.h
//  https://github.com/PureLayout/PureLayout
//
//  Copyright (c) 2013-2015 Tyler Fox
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#import "PureLayoutDefines.h"


PL__ASSUME_NONNULL_BEGIN

#pragma mark NSLayoutConstraint+PureLayout

/**
 A category on NSLayoutConstraint that allows constraints to be easily installed & removed.
 */
@interface NSLayoutConstraint (PureLayout)


#pragma mark Batch Constraint Creation

/** Creates all of the constraints in the block, then installs (activates) them all at once.
    All constraints created from calls to the PureLayout API in the block are returned in a single array.
    This may be more efficient than installing (activating) each constraint one-by-one. */
+ (PL__NSArray_of(NSLayoutConstraint *) *)autoCreateAndInstallConstraints:(__attribute__((noescape)) ALConstraintsBlock)block;

/** Creates all of the constraints in the block but prevents them from being automatically installed (activated).
    All constraints created from calls to the PureLayout API in the block are returned in a single array. */
+ (PL__NSArray_of(NSLayoutConstraint *) *)autoCreateConstraintsWithoutInstalling:(__attribute__((noescape)) ALConstraintsBlock)block;


#pragma mark Set Priority For Constraints

/** Sets the constraint priority to the given value for all constraints created using the PureLayout API within the given constraints block.
    NOTE: This method will have no effect (and will NOT set the priority) on constraints created or added without using the PureLayout API! */
+ (void)autoSetPriority:(ALLayoutPriority)priority forConstraints:(__attribute__((noescape)) ALConstraintsBlock)block;


#pragma mark Identify Constraints

#if PL__PureLayout_MinBaseSDK_iOS_8_0 || PL__PureLayout_MinBaseSDK_OSX_10_10

/** Sets the identifier for all constraints created using the PureLayout API within the given constraints block.
    NOTE: This method will have no effect (and will NOT set the identifier) on constraints created or added without using the PureLayout API! */
+ (void)autoSetIdentifier:(NSString *)identifier forConstraints:(__attribute__((noescape)) ALConstraintsBlock)block;

/** Sets the string as the identifier for this constraint. Available in iOS 7.0 and OS X 10.9 and later. */
- (instancetype)autoIdentify:(NSString *)identifier;

#endif /* PL__PureLayout_MinBaseSDK_iOS_8_0 || PL__PureLayout_MinBaseSDK_OSX_10_10 */


#pragma mark Install & Remove Constraints

/** Activates the the constraint. */
- (void)autoInstall;

/** Deactivates the constraint. */
- (void)autoRemove;

@end

PL__ASSUME_NONNULL_END
