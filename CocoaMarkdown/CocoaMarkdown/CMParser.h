//
//  CMParser.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/13/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMNode;

@class CMDocument;
@protocol CMParserDelegate;

/**
 *  Not really a parser, but you can pretend it is. 
 *
 *  This class takes a `CMDocument` (which contains the tree for the already-parsed 
 *  Markdown data) and traverses the tree to implement `NSXMLParser`-style delegate 
 *  callbacks.
 *
 *  This is useful for implementing custom renderers.
 *
 *  @warning This class is not thread-safe and can only be accessed from a single
 *  thread at a time.
 */
@interface CMParser : NSObject

/**
 *  Initializes the receiver with a document.
 *
 *  @param document CommonMark document.
 *  @param delegate Delegate to receive callbacks during parsing.
 *
 *  @return An initialized instance of the receiver.
 */
- (instancetype)initWithDocument:(CMDocument *)document delegate:(id<CMParserDelegate>)delegate;

/**
 *  Document being parsed.
 */
@property (nonatomic, readonly) CMDocument *document;

/**
 *  Delegate to receive callbacks during parsing.
 */
@property (nonatomic, weak, readonly) id<CMParserDelegate> delegate;

/**
 *  Returns the node currently being parsed, or `nil` if not parsing.
 */
@property (atomic, readonly) CMNode *currentNode;

/**
 *  Start parsing.
 */
- (void)parse;

/**
 *  Stop parsing. If implemented, `-parserDidAbort:` will be called on the delegate.
 */
- (void)abortParsing;

@end

@protocol CMParserDelegate <NSObject>
@optional
- (void)parserDidStartDocument:(CMParser *)parser;
- (void)parserDidEndDocument:(CMParser *)parser;
- (void)parserDidAbort:(CMParser *)parser;

- (void)parser:(CMParser *)parser foundText:(NSString *)text;
- (void)parserFoundHRule:(CMParser *)parser;

- (void)parser:(CMParser *)parser didStartHeaderWithLevel:(NSInteger)level;
- (void)parser:(CMParser *)parser didEndHeaderWithLevel:(NSInteger)level;

- (void)parserDidStartParagraph:(CMParser *)parser;
- (void)parserDidEndParagraph:(CMParser *)parser;

- (void)parserDidStartEmphasis:(CMParser *)parser;
- (void)parserDidEndEmphasis:(CMParser *)parser;

- (void)parserDidStartStrong:(CMParser *)parser;
- (void)parserDidEndStrong:(CMParser *)parser;

- (void)parser:(CMParser *)parser didStartLinkWithURL:(NSURL *)URL title:(NSString *)title;
- (void)parser:(CMParser *)parser didEndLinkWithURL:(NSURL *)URL title:(NSString *)title;

- (void)parser:(CMParser *)parser didStartImageWithURL:(NSURL *)URL title:(NSString *)title;
- (void)parser:(CMParser *)parser didEndImageWithURL:(NSURL *)URL title:(NSString *)title;

- (void)parser:(CMParser *)parser foundHTML:(NSString *)HTML;
- (void)parser:(CMParser *)parser foundInlineHTML:(NSString *)HTML;

- (void)parser:(CMParser *)parser foundCodeBlock:(NSString *)code info:(NSString *)info;
- (void)parser:(CMParser *)parser foundInlineCode:(NSString *)code;

- (void)parserFoundSoftBreak:(CMParser *)parser;
- (void)parserFoundLineBreak:(CMParser *)parser;

- (void)parserDidStartBlockQuote:(CMParser *)parser;
- (void)parserDidEndBlockQuote:(CMParser *)parser;

- (void)parser:(CMParser *)parser didStartUnorderedListWithTightness:(BOOL)tight;
- (void)parser:(CMParser *)parser didEndUnorderedListWithTightness:(BOOL)tight;

- (void)parser:(CMParser *)parser didStartOrderedListWithStartingNumber:(NSInteger)num tight:(BOOL)tight;
- (void)parser:(CMParser *)parser didEndOrderedListWithStartingNumber:(NSInteger)num tight:(BOOL)tight;

- (void)parserDidStartListItem:(CMParser *)parser;
- (void)parserDidEndListItem:(CMParser *)parser;

@end

