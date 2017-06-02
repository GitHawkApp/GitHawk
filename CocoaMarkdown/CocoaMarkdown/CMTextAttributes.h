//
//  CMTextAttributes.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/15/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Container for sets of text attributes used to style 
 *  attributed strings.
 */
@interface CMTextAttributes : NSObject

/**
 *  Initializes the receiver with the default attributes.
 *
 *  @return An initialized instance of the receiver.
 */
- (instancetype)init;

/**
 *  @param level The header level.
 *
 *  @return The attributes for the specified header level.
 */
- (NSDictionary *)attributesForHeaderLevel:(NSInteger)level;

/**
 *  Attributes used to style text.
 *
 *  On iOS, defaults to using the Dynamic Type font with style `UIFontTextStyleBody`
 *  On OS X, defaults to using the user font with size 12pt.
 */
@property (nonatomic) NSDictionary *textAttributes;

/**
 *  Attributes used to style level 1 headers.
 *
 *  On iOS, defaults to using the Dynamic Type font with style `UIFontTextStyleHeadline`
 *  On OS X, defaults to using the user font with size 24pt.
 */
@property (nonatomic) NSDictionary *h1Attributes;

/**
 *  Attributes used to style level 2 headers.
 *
 *  On iOS, defaults to using the Dynamic Type font with style `UIFontTextStyleHeadline`
 *  On OS X, defaults to using the user font with size 18pt.
 */
@property (nonatomic) NSDictionary *h2Attributes;

/**
 *  Attributes used to style level 3 headers.
 *
 *  On iOS, defaults to using the Dynamic Type font with style `UIFontTextStyleHeadline`
 *  On OS X, defaults to using the user font with size 14pt.
 */
@property (nonatomic) NSDictionary *h3Attributes;

/**
 *  Attributes used to style level 4 headers.
 *
 *  On iOS, defaults to using the Dynamic Type font with style `UIFontTextStyleSubheadline`
 *  On OS X, defaults to using the user font with size 12pt.
 */
@property (nonatomic) NSDictionary *h4Attributes;

/**
 *  Attributes used to style level 5 headers.
 *
 *  On iOS, defaults to using the Dynamic Type font with style `UIFontTextStyleSubheadline`
 *  On OS X, defaults to using the user font with size 10pt.
 */
@property (nonatomic) NSDictionary *h5Attributes;

/**
 *  Attributes used to style level 6 headers.
 *
 *  On iOS, defaults to using the Dynamic Type font with style `UIFontTextStyleSubheadline`
 *  On OS X, defaults to using the user font with size 8pt.
 */
@property (nonatomic) NSDictionary *h6Attributes;

/**
 *  Attributes used to style emphasized text.
 *
 *  If not set, the renderer will attempt to infer the emphasized font from the
 *  regular text font.
 */
@property (nonatomic) NSDictionary *emphasisAttributes;

/**
 *  Attributes used to style strong text.
 *
 *  If not set, the renderer will attempt to infer the strong font from the
 *  regular text font.
 */
@property (nonatomic) NSDictionary *strongAttributes;

/**
 *  Attributes used to style linked text.
 *
 *  Defaults to using a blue foreground color and a single line underline style.
 */
@property (nonatomic) NSDictionary *linkAttributes;

/**
 *  Attributes used to style code blocks.
 *
 *  On iOS, defaults to the Menlo font when available, or Courier as a fallback.
 *  On OS X, defaults to the user monospaced font.
 */
@property (nonatomic) NSDictionary *codeBlockAttributes;

/**
 *  Attributes used to style inline code.
 *
 *  On iOS, defaults to the Menlo font when available, or Courier as a fallback.
 *  On OS X, defaults to the user monospaced font.
 */
@property (nonatomic) NSDictionary *inlineCodeAttributes;

/**
 *  Attributes used to style block quotes.
 *
 *  Defaults to using a paragraph style with a head indent of 30px.
 */
@property (nonatomic) NSDictionary *blockQuoteAttributes;

/**
 *  Attributes used to style ordered lists.
 *
 *  These attributes will apply to the entire list (unless overriden by attributes
 *  for the list items), including the numbers.
 *
 *  Defaults to using a paragraph style with a head indent of 30px.
 */
@property (nonatomic) NSDictionary *orderedListAttributes;

/**
 *  Attributes used to style unordered lists.
 *
 *  These attributes will apply to the entire list (unless overriden by attributes
 *  for the list items), including the bullets.
 *
 *  Defaults to using a paragraph style with a head indent of 30px.
 */
@property (nonatomic) NSDictionary *unorderedListAttributes;

/**
 *  Attributes used to style ordered sublists.
 *
 *  These attributes will apply to the entire list (unless overriden by attributes
 *  for the list items), including the numbers.
 *
 *  Defaults to using a paragraph style with a head indent of 30px.
 */
@property (nonatomic) NSDictionary *orderedSublistAttributes;

/**
 *  Attributes used to style unordered sublists.
 *
 *  These attributes will apply to the entire list (unless overriden by attributes
 *  for the list items), including the bullets.
 *
 *  Defaults to using a paragraph style with a head indent of 30px.
 */
@property (nonatomic) NSDictionary *unorderedSublistAttributes;

/**
 *  Attributes used to style ordered list items.
 *
 *  These attribtues do _not_ apply to the numbers.
 */
@property (nonatomic) NSDictionary *orderedListItemAttributes;

/**
 *  Attributes used to style unordered list items.
 *
 *  These attribtues do _not_ apply to the bullets.
 */
@property (nonatomic) NSDictionary *unorderedListItemAttributes;

@end
