//
//  CMHTMLRenderer.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/20/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMDocument;

/**
 *  Renders HTML from a Markdown document.
 */
@interface CMHTMLRenderer : NSObject

/**
 *  Designated initializer.
 *
 *  @param document A Markdown document.
 *  @param options  Rendering options.
 *
 *  @return An initialized instance of the receiver.
 */
- (instancetype)initWithDocument:(CMDocument *)document;

/**
 *  Renders HTML from the Markdown document.
 *
 *  @return A string containing the HTML representation
 *  of the document.
 */
- (NSString *)render;

@end
