//
//  CMParserTestObject.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/14/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMParserTestObject.h"
#import <CocoaMarkdown/CocoaMarkdown.h>

@interface CMParserTestObject () <CMParserDelegate>
@end

@implementation CMParserTestObject {
    CMParser *_parser;
    NSMutableArray *_foundText;
    NSMutableArray *_didStartHeader;
    NSMutableArray *_didEndHeader;
    NSMutableArray *_didStartLink;
    NSMutableArray *_didEndLink;
    NSMutableArray *_didStartImage;
    NSMutableArray *_didEndImage;
    NSMutableArray *_foundHTML;
    NSMutableArray *_foundInlineHTML;
    NSMutableArray *_foundCodeBlock;
    NSMutableArray *_foundInlineCode;
    NSMutableArray *_didStartUnorderedList;
    NSMutableArray *_didEndUnorderedList;
    NSMutableArray *_didStartOrderedList;
    NSMutableArray *_didEndOrderedList;
}

- (instancetype)initWithDocument:(CMDocument *)document
{
    NSParameterAssert(document);
    if ((self = [super init])) {
        _parser = [[CMParser alloc] initWithDocument:document delegate:self];
        
        _foundText = [[NSMutableArray alloc] init];
        _didStartHeader = [[NSMutableArray alloc] init];
        _didEndHeader = [[NSMutableArray alloc] init];
        _didStartLink = [[NSMutableArray alloc] init];
        _didEndLink = [[NSMutableArray alloc] init];
        _didStartImage = [[NSMutableArray alloc] init];
        _didEndImage = [[NSMutableArray alloc] init];
        _foundHTML = [[NSMutableArray alloc] init];
        _foundInlineHTML = [[NSMutableArray alloc] init];
        _foundCodeBlock = [[NSMutableArray alloc] init];
        _foundInlineCode = [[NSMutableArray alloc] init];
        _didStartUnorderedList = [[NSMutableArray alloc] init];
        _didEndUnorderedList = [[NSMutableArray alloc] init];
        _didStartOrderedList = [[NSMutableArray alloc] init];
        _didEndOrderedList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parse
{
    [_parser parse];
}

#pragma mark - CMParserDelegate

- (void)parserDidStartDocument:(CMParser *)parser
{
    _didStartDocument++;
    if (_abortOnStart) {
        [parser abortParsing];
    }
}

- (void)parserDidEndDocument:(CMParser *)parser
{
    _didEndDocument++;
}

- (void)parserDidAbort:(CMParser *)parser
{
    _didAbort++;
}

- (void)parser:(CMParser *)parser foundText:(NSString *)text
{
    [_foundText addObject:text];
}

- (void)parserFoundHRule:(CMParser *)parser
{
    _foundHRule++;
}

- (void)parser:(CMParser *)parser didStartHeaderWithLevel:(NSInteger)level
{
    [_didStartHeader addObject:@(level)];
}

- (void)parser:(CMParser *)parser didEndHeaderWithLevel:(NSInteger)level
{
    [_didEndHeader addObject:@(level)];
}

- (void)parserDidStartParagraph:(CMParser *)parser
{
    _didStartParagraph++;
}

- (void)parserDidEndParagraph:(CMParser *)parser
{
    _didEndParagraph++;
}

- (void)parserDidStartEmphasis:(CMParser *)parser
{
    _didStartEmphasis++;
}

- (void)parserDidEndEmphasis:(CMParser *)parser
{
    _didEndEmphasis++;
}

- (void)parserDidStartStrong:(CMParser *)parser
{
    _didStartStrong++;
}

- (void)parserDidEndStrong:(CMParser *)parser
{
    _didEndStrong++;
}

- (void)parser:(CMParser *)parser didStartLinkWithURL:(NSURL *)URL title:(NSString *)title
{
    NSParameterAssert(URL);
    [_didStartLink addObject:@[URL, title ?: NSNull.null]];
}

- (void)parser:(CMParser *)parser didEndLinkWithURL:(NSURL *)URL title:(NSString *)title
{
    NSParameterAssert(URL);
    [_didEndLink addObject:@[URL, title ?: NSNull.null]];
}

- (void)parser:(CMParser *)parser didStartImageWithURL:(NSURL *)URL title:(NSString *)title
{
    NSParameterAssert(URL);
    [_didStartImage addObject:@[URL, title ?: NSNull.null]];
}

- (void)parser:(CMParser *)parser didEndImageWithURL:(NSURL *)URL title:(NSString *)title
{
    NSParameterAssert(URL);
    [_didEndImage addObject:@[URL, title ?: NSNull.null]];
}

- (void)parser:(CMParser *)parser foundHTML:(NSString *)HTML
{
    NSParameterAssert(HTML);
    [_foundHTML addObject:HTML];
}

- (void)parser:(CMParser *)parser foundInlineHTML:(NSString *)HTML
{
    NSParameterAssert(HTML);
    [_foundInlineHTML addObject:HTML];
}

- (void)parser:(CMParser *)parser foundCodeBlock:(NSString *)code info:(NSString *)info
{
    NSParameterAssert(code);
    [_foundCodeBlock addObject:@[code, info ?: NSNull.null]];
}

- (void)parser:(CMParser *)parser foundInlineCode:(NSString *)code
{
    [_foundInlineCode addObject:code];
}

- (void)parserFoundSoftBreak:(CMParser *)parser
{
    _foundSoftBreak++;
}

- (void)parserFoundLineBreak:(CMParser *)parser
{
    _foundLineBreak++;
}

- (void)parserDidStartBlockQuote:(CMParser *)parser
{
    _didStartBlockQuote++;
}

- (void)parserDidEndBlockQuote:(CMParser *)parser
{
    _didEndBlockQuote++;
}

- (void)parser:(CMParser *)parser didStartUnorderedListWithTightness:(BOOL)tight
{
    [_didStartUnorderedList addObject:@(tight)];
}

- (void)parser:(CMParser *)parser didEndUnorderedListWithTightness:(BOOL)tight
{
    [_didEndUnorderedList addObject:@(tight)];
}

- (void)parser:(CMParser *)parser didStartOrderedListWithStartingNumber:(NSInteger)num tight:(BOOL)tight
{
    [_didStartOrderedList addObject:@[@(num), @(tight)]];
}

- (void)parser:(CMParser *)parser didEndOrderedListWithStartingNumber:(NSInteger)num tight:(BOOL)tight
{
    [_didEndOrderedList addObject:@[@(num), @(tight)]];
}

- (void)parserDidStartListItem:(CMParser *)parser
{
    _didStartListItem++;
}

- (void)parserDidEndListItem:(CMParser *)parser
{
    _didEndListItem++;
}

@end
