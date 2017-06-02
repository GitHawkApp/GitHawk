//
//  CMHTMLUnderlineTransformer.h
//  CocoaMarkdown
//
//  Created by Damien Rambout on 19/01/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMHTMLElementTransformer.h"
#import "CMPlatformDefines.h"

/**
 Transforms HTML underline elements (<u>) into attributed strings.
 */
@interface CMHTMLUnderlineTransformer : NSObject <CMHTMLElementTransformer>

/**
 *  Initializes the receiver with the default attributes -- a single line
 *  style and a color that matches the color of the text.
 *
 *  @return An initialized instance of the receiver.
 */
- (instancetype)init;

/**
 *  Initializes the receiver with a custom style and color.
 *
 *  @param style Strikethrough style.
 *  @param color Strikethrough color. If `nil`, the transformer uses
 *  the color of the text if it has been specified.
 *
 *  @return An initialized instance of the receiver.
 */
- (instancetype)initWithUnderlineStyle:(CMUnderlineStyle)style color:(CMColor *)color;

@end
