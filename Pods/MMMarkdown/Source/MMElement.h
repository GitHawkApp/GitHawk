//
//  MMElement.h
//  MMMarkdown
//
//  Copyright (c) 2012 Matt Diephouse.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@class MMElement;

typedef NS_ENUM(NSInteger, MMElementType)
{
    MMElementTypeNone,
    MMElementTypeHeader,
    MMElementTypeParagraph,
    MMElementTypeBlockquote,
    MMElementTypeNumberedList,
    MMElementTypeBulletedList,
    MMElementTypeListItem,
    MMElementTypeCodeBlock,
    MMElementTypeHorizontalRule,
    MMElementTypeHTML,
    MMElementTypeLineBreak,
    MMElementTypeStrikethrough,
    MMElementTypeStrong,
    MMElementTypeEm,
    MMElementTypeCodeSpan,
    MMElementTypeImage,
    MMElementTypeLink,
    MMElementTypeMailTo,
    MMElementTypeDefinition,
    MMElementTypeEntity,
    MMElementTypeTable,
    MMElementTypeTableHeader,
    MMElementTypeTableHeaderCell,
    MMElementTypeTableRow,
    MMElementTypeTableRowCell,
    MMElementTypeUsername,
    MMElementTypeCheckbox,
    MMElementTypeShorthandIssues,
};

typedef NS_ENUM(NSInteger, MMTableCellAlignment)
{
    MMTableCellAlignmentNone,
    MMTableCellAlignmentLeft,
    MMTableCellAlignmentCenter,
    MMTableCellAlignmentRight,
};

@interface MMElement : NSObject

@property (assign, nonatomic) NSRange        range;
@property (assign, nonatomic) MMElementType  type;
@property (copy,   nonatomic, nonnull) NSArray       *innerRanges;

@property (assign, nonatomic) MMTableCellAlignment alignment;
@property (assign, nonatomic) NSUInteger     level;
@property (copy,   nonatomic, nullable) NSString      *href;
@property (copy,   nonatomic, nullable) NSString      *title;
@property (copy,   nonatomic, nullable) NSString      *identifier;
@property (copy,   nonatomic, nullable) NSString      *stringValue;
@property (assign, nonatomic) NSUInteger numberedListPosition;

// @username mentions
@property (copy, nonatomic, nullable) NSString *username;

// checkboxes
@property (assign, nonatomic) BOOL checked;

// shorthand links
@property (copy, nonatomic, nullable) NSString *owner;
@property (copy, nonatomic, nullable) NSString *repository;
@property (assign, nonatomic) NSInteger number;

@property (weak, nonatomic, nullable) MMElement *parent;
@property (copy,   nonatomic, nonnull) NSArray<MMElement *>   *children;

@property (copy,   nonatomic, nullable) NSString  *language;

- (void)addInnerRange:(NSRange)aRange;
- (void)removeLastInnerRange;

- (void)addChild:(MMElement * _Nonnull)aChild;
- (void)removeChild:(MMElement * _Nonnull)aChild;
- (MMElement * _Nonnull)removeLastChild;

@end
