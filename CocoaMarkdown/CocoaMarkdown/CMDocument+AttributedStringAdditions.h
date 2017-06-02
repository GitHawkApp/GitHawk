//
//  CMDocument+AttributedStringAdditions.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/20/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMDocument.h"

@class CMTextAttributes;

@interface CMDocument (AttributedStringAdditions)

/**
 *  Creates an attributed string from the receiver that is styled using the
 *  specified attributes.
 *
 *  @param attributes Attributes used to style the text.
 *
 *  @return Attributed string containing the formatted contents of the receiver.
 */
- (NSAttributedString *)attributedStringWithAttributes:(CMTextAttributes *)attributes;

@end
