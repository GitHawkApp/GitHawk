//
//  CMHTMLElementTransformer.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/16/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ONOXMLElement;

/**
 *  Interface for an object that can transform an HTML element to an attributed string.
 */
@protocol CMHTMLElementTransformer <NSObject>
/**
 *  @return The name of the tag that this transformer handles.
 */
+ (NSString *)tagName;

/**
 *  Transforms an HTML element to an attributed string.
 *
 *  @param document   The HTML element to transform.
 *  @param attributes The base attributes to be applied to the attributed string.
 *
 *  @return An attributed string.
 */
- (NSAttributedString *)attributedStringForElement:(ONOXMLElement *)element attributes:(NSDictionary *)attributes;

@end

/**
 *  Use this macro inside an implementation of `-attributedStringForElement:attributes:`
 *  to assert that the root element's tag matches the transformer's tag.
 */
#define CMAssertCorrectTag(element) \
    NSAssert([element.tag isEqualToString:self.class.tagName], @"Tag does not match");
