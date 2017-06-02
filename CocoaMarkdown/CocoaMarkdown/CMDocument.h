//
//  CMDocument.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/12/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMNode;

typedef NS_OPTIONS(NSInteger, CMDocumentOptions) {
    /** 
     * Include a `data-sourcepos` attribute on all block elements.
     */
    CMDocumentOptionsSourcepos = (1 << 0),
    /** 
     * Render `softbreak` elements as hard line breaks.
     */
    CMDocumentOptionsHardBreaks = (1 << 1),
    /** 
     * Normalize tree by consolidating adjacent text nodes.
     */
    CMDocumentOptionsNormalize = (1 << 3),
    /** 
     * Convert straight quotes to curly, --- to em dashes, -- to en dashes.
     */
    CMDocumentOptionsSmart = (1 << 4)
};

/**
 *  A Markdown document conforming to the CommonMark spec.
 */
@interface CMDocument : NSObject

/**
 *  Root node of the document.
 */
@property (nonatomic, readonly) CMNode *rootNode;

/**
 *  Initializes the receiver with data.
 *
 *  @param data Markdown document data.
 *  @param options Document options.
 *
 *  @return An initialized instance of the receiver.
 */
- (instancetype)initWithData:(NSData *)data options:(CMDocumentOptions)options;

/**
 *  Initializes the receiver with data read from a file.
 *
 *  @param path The file path to read from.
 *  @param options Document options.
 *
 *  @return An initialized instance of the receiver, or `nil` if the file
 *  could not be opened.
 */
- (instancetype)initWithContentsOfFile:(NSString *)path options:(CMDocumentOptions)options;

@end
