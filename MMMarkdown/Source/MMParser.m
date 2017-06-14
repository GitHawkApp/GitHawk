//
//  MMParser.m
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

#import "MMParser.h"


#import "MMDocument.h"
#import "MMDocument_Private.h"
#import "MMElement.h"
#import "MMHTMLParser.h"
#import "MMScanner.h"
#import "MMSpanParser.h"

typedef NS_ENUM(NSInteger, MMListType) {
    MMListTypeBulleted,
    MMListTypeNumbered,
};

static NSString * __HTMLEntityForCharacter(unichar character)
{
    switch (character)
    {
        case '&':
            return @"&amp;";
        case '<':
            return @"&lt;";
        case '>':
            return @"&gt;";
        default:
            return @"";
    }
}

@interface MMParser ()
@property (assign, nonatomic, readonly) MMMarkdownExtensions extensions;
@property (strong, nonatomic, readonly) MMHTMLParser *htmlParser;
@property (strong, nonatomic, readonly) MMSpanParser *spanParser;
@end

@implementation MMParser

#pragma mark - Public Methods

- (id)initWithExtensions:(MMMarkdownExtensions)extensions
{
    self = [super init];
    
    if (self)
    {
        _extensions = extensions;
        _htmlParser = [MMHTMLParser new];
        _spanParser = [[MMSpanParser alloc] initWithExtensions:extensions];
    }
    
    return self;
}

- (MMDocument *)parseMarkdown:(NSString *)markdown error:(__autoreleasing NSError **)error
{
    // It would be better to not replace all the tabs with spaces. But this will do for now.
    markdown = [self _removeTabsFromString:markdown];
    
    MMScanner  *scanner  = [MMScanner scannerWithString:markdown];
    MMDocument *document = [MMDocument documentWithMarkdown:markdown];
    
    document.elements = [self _parseElementsWithScanner:scanner];
    [self _updateLinksFromDefinitionsInDocument:document];
    
    return document;
}


#pragma mark - Private Methods

// Add the remainder of the line as an inner range to the element.
//
// If the line contains the start of a multi-line HTML comment, then multiple lines will be added
// to the element.
- (void)_addTextLineToElement:(MMElement *)element withScanner:(MMScanner *)scanner
{
    NSCharacterSet *nonAngleSet = [[NSCharacterSet characterSetWithCharactersInString:@"<"] invertedSet];
    NSCharacterSet *nonDashSet  = [[NSCharacterSet characterSetWithCharactersInString:@"-"] invertedSet];
    
    NSRange lineRange = scanner.currentRange;
    
    // Check for an HTML comment, which could span blank lines
    [scanner beginTransaction];
    NSMutableArray *commentRanges = [NSMutableArray new];
    // Look for the start of a comment on the current line
    while (!scanner.atEndOfLine)
    {
        [scanner skipCharactersFromSet:nonAngleSet];
        if ([scanner matchString:@"<!--"])
        {
            // Look for the end of the comment
            while (!scanner.atEndOfString)
            {
                [scanner skipCharactersFromSet:nonDashSet];
                
                if (scanner.atEndOfLine)
                {
                    [commentRanges addObject:[NSValue valueWithRange:lineRange]];
                    [scanner advanceToNextLine];
                    lineRange = scanner.currentRange;
                    continue;
                }
                if ([scanner matchString:@"-->"])
                {
                    break;
                }
                [scanner advance];
            }
        }
        else
            [scanner advance];
    }
    [scanner commitTransaction:commentRanges.count > 0];
    if (commentRanges.count > 0)
    {
        for (NSValue *value in commentRanges)
        {
            [element addInnerRange:value.rangeValue];
        }
    }
    
    [element addInnerRange:lineRange];
    [scanner advanceToNextLine];
}

- (NSString *)_removeTabsFromString:(NSString *)aString
{
    NSMutableString *result = [aString mutableCopy];
    
    NSCharacterSet *tabAndNewline = [NSCharacterSet characterSetWithCharactersInString:@"\t\n"];
    
    NSRange searchRange = NSMakeRange(0, aString.length);
    NSRange resultRange;
    NSUInteger lineLocation;
    NSArray *strings = @[ @"", @" ", @"  ", @"   ", @"    " ];
    
    resultRange  = [result rangeOfCharacterFromSet:tabAndNewline options:0 range:searchRange];
    lineLocation = 0;
    while (resultRange.location != NSNotFound)
    {
        unichar character = [result characterAtIndex:resultRange.location];
        if (character == '\n')
        {
            lineLocation = 1 + resultRange.location;
            searchRange = NSMakeRange(lineLocation, result.length-lineLocation);
        }
        else
        {
            NSUInteger numOfSpaces = 4 - ((resultRange.location - lineLocation) % 4);
            [result replaceCharactersInRange:resultRange withString:[strings objectAtIndex:numOfSpaces]];
            searchRange = NSMakeRange(resultRange.location, result.length-resultRange.location);
        }
        resultRange = [result rangeOfCharacterFromSet:tabAndNewline options:0 range:searchRange];
    }
    
    return result;
}

- (NSArray *)_parseElementsWithScanner:(MMScanner *)scanner
{
    NSMutableArray *result = [NSMutableArray new];
    
    while (!scanner.atEndOfString)
    {
        MMElement *element = [self _parseBlockElementWithScanner:scanner];
        if (element)
        {
            [result addObject:element];
        }
        else
        {
            [scanner skipCharactersFromSet:NSCharacterSet.whitespaceCharacterSet];
            if (scanner.atEndOfLine)
            {
                [scanner advanceToNextLine];
            }
        }
    }
    
    return result;
}

- (MMElement *)_parseBlockElementWithScanner:(MMScanner *)scanner
{
    MMElement *element;
    
    [scanner beginTransaction];
    element = [self.htmlParser parseCommentWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseHTMLWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parsePrefixHeaderWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseUnderlinedHeaderWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseBlockquoteWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    // Check code first because its four-space behavior trumps most else
    [scanner beginTransaction];
    element = [self _parseCodeBlockWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    if (self.extensions & MMMarkdownExtensionsFencedCodeBlocks)
    {
        [scanner beginTransaction];
        element = [self _parseFencedCodeBlockWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
    }
    
    if (self.extensions & MMMarkdownExtensionsTables)
    {
        [scanner beginTransaction];
        element = [self _parseTableWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
    }
    
    // Check horizontal rules before lists since they both start with * or -
    [scanner beginTransaction];
    element = [self _parseHorizontalRuleWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseListWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseLinkDefinitionWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseParagraphWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    return nil;
}

- (MMElement *)_parseHTMLWithScanner:(MMScanner *)scanner
{
    // At the beginning of the line
    if (!scanner.atBeginningOfLine)
        return nil;
    
    return [self.htmlParser parseBlockTagWithScanner:scanner];
}

- (MMElement *)_parsePrefixHeaderWithScanner:(MMScanner *)scanner
{
    NSUInteger level = 0;
    while (scanner.nextCharacter == '#' && level < 6)
    {
        level++;
        [scanner advance];
    }
    
    if (level == 0)
        return nil;
    
    if ([scanner skipWhitespace] == 0)
        return nil;
    
    NSRange headerRange = scanner.currentRange;
    
    // Check for trailing #s
    while (headerRange.length > 0)
    {
        unichar character = [scanner.string characterAtIndex:NSMaxRange(headerRange)-1];
        if (character == '#')
            headerRange.length--;
        else
            break;
    }
    
    // Remove trailing whitespace
    NSCharacterSet *whitespaceSet = NSCharacterSet.whitespaceCharacterSet;
    while (headerRange.length > 0)
    {
        unichar character = [scanner.string characterAtIndex:NSMaxRange(headerRange)-1];
        if ([whitespaceSet characterIsMember:character])
            headerRange.length--;
        else
            break;
    }
    
    [scanner advanceToNextLine];
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeHeader;
    element.range = NSMakeRange(scanner.startLocation, NSMaxRange(scanner.currentRange)-scanner.startLocation);
    element.level = level;
    [element addInnerRange:headerRange];
    
    if (element.innerRanges.count > 0)
    {
        MMScanner *innerScanner = [MMScanner scannerWithString:scanner.string lineRanges:element.innerRanges];
        element.children = [self.spanParser parseSpansInBlockElement:element withScanner:innerScanner];
    }
    
    return element;
}

- (MMElement *)_parseUnderlinedHeaderWithScanner:(MMScanner *)scanner
{
    [scanner beginTransaction];
    
    // Make sure that the first line isn't empty
    [scanner skipCharactersFromSet:NSCharacterSet.whitespaceCharacterSet];
    if (scanner.atEndOfLine)
    {
        [scanner commitTransaction:NO];
        return nil;
    }
    
    [scanner advanceToNextLine];
    
    // There has to be more to the string
    if (scanner.atEndOfString)
    {
        [scanner commitTransaction:NO];
        return nil;
    }
    
    // The first character has to be a - or =
    unichar character = scanner.nextCharacter;
    if (character != '-' && character != '=')
    {
        [scanner commitTransaction:NO];
        return nil;
    }
    
    // Every other character must also be a - or =
    while (!scanner.atEndOfLine)
    {
        if (character != scanner.nextCharacter)
        {
            // If it's not a - or =, check if it's just optional whitespace before the newline
            [scanner skipCharactersFromSet:NSCharacterSet.whitespaceCharacterSet];
            if (scanner.atEndOfLine)
                break;
            
            [scanner commitTransaction:NO];
            return nil;
        }
        [scanner advance];
    }
    [scanner commitTransaction:NO];
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeHeader;
    element.level = character == '=' ? 1 : 2;
    [element addInnerRange:scanner.currentRange];
    
    [scanner advanceToNextLine]; // The header
    [scanner advanceToNextLine]; // The underlines
    
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    if (element.innerRanges.count > 0)
    {
        MMScanner *innerScanner = [MMScanner scannerWithString:scanner.string lineRanges:element.innerRanges];
        element.children = [self.spanParser parseSpansInBlockElement:element withScanner:innerScanner];
    }
    
    return element;
}

- (MMElement *)_parseBlockquoteWithScanner:(MMScanner *)scanner
{
    // Skip up to 3 leading spaces
    NSCharacterSet *spaceCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" "];
    [scanner skipCharactersFromSet:spaceCharacterSet max:3];
    
    // Must have a >
    if (scanner.nextCharacter != '>')
        return nil;
    [scanner advance];
    
    // Can be followed by a space
    if (scanner.nextCharacter == ' ')
        [scanner advance];
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeBlockquote;
    
    [element addInnerRange:scanner.currentRange];
    [scanner advanceToNextLine];
    
    // Parse each remaining line
    NSCharacterSet *whitespaceSet = NSCharacterSet.whitespaceCharacterSet;
    while (!scanner.atEndOfString)
    {
        [scanner beginTransaction];
        [scanner skipCharactersFromSet:whitespaceSet];
        
        // It's a continuation of the blockquote unless it's a blank line
        if (scanner.atEndOfLine)
        {
            [scanner commitTransaction:NO];
            break;
        }
        
        // If there's a >, then skip it and an optional space
        if (scanner.nextCharacter == '>')
        {
            [scanner advance];
            [scanner skipCharactersFromSet:whitespaceSet max:1];
        }
        else
        {
            //
            // If the following line is a list item
            // then break the blockquote parsering.
            //
            [scanner beginTransaction];
            [scanner skipIndentationUpTo:2];
            BOOL hasListMarker = [self _parseListMarkerWithScanner:scanner listType:MMListTypeBulleted]
            || [self _parseListMarkerWithScanner:scanner listType:MMListTypeNumbered];
            [scanner commitTransaction:NO];
            if (hasListMarker)
                break;
        }
        
        [element addInnerRange:scanner.currentRange];
        
        [scanner commitTransaction:YES];
        [scanner advanceToNextLine];
    }
    
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    
    if (element.innerRanges.count > 0)
    {
        MMScanner *innerScanner = [MMScanner scannerWithString:scanner.string lineRanges:element.innerRanges];
        element.children = [self _parseElementsWithScanner:innerScanner];
    }
    
    return element;
}

- (NSArray *)_parseCodeLinesWithScanner:(MMScanner *)scanner
{
    NSMutableArray *children = [NSMutableArray new];
    
    // &, <, and > need to be escaped
    NSCharacterSet *entities    = [NSCharacterSet characterSetWithCharactersInString:@"&<>"];
    NSCharacterSet *nonEntities = [entities invertedSet];
    
    while (!scanner.atEndOfString)
    {
        NSUInteger textLocation = scanner.location;
        
        [scanner skipCharactersFromSet:nonEntities];
        
        if (textLocation != scanner.location)
        {
            MMElement *text = [MMElement new];
            text.type  = MMElementTypeNone;
            text.range = NSMakeRange(textLocation, scanner.location-textLocation);
            [children addObject:text];
        }
        
        // Add the entity
        if (!scanner.atEndOfLine)
        {
            unichar    character = [scanner.string characterAtIndex:scanner.location];
            MMElement *entity    = [MMElement new];
            entity.type  = MMElementTypeEntity;
            entity.range = NSMakeRange(scanner.location, 1);
            entity.stringValue = __HTMLEntityForCharacter(character);
            [children addObject:entity];
            [scanner advance];
        }
        
        if (scanner.atEndOfLine)
        {
            [scanner advanceToNextLine];
            
            // Add a newline
            MMElement *newline = [MMElement new];
            newline.type  = MMElementTypeNone;
            newline.range = NSMakeRange(scanner.location, 0);
            [children addObject:newline];
        }
    }
    
    return children;
}

- (MMElement *)_parseCodeBlockWithScanner:(MMScanner *)scanner
{
    NSUInteger indentation = [scanner skipIndentationUpTo:4];
    if (indentation != 4 || scanner.atEndOfLine)
        return nil;
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeCodeBlock;
    
    [element addInnerRange:scanner.currentRange];
    [scanner advanceToNextLine];
    
    while (!scanner.atEndOfString)
    {
        // Skip empty lines
        NSUInteger numOfEmptyLines = [scanner skipEmptyLines];
        for (NSUInteger idx=0; idx<numOfEmptyLines; idx++)
        {
            [element addInnerRange:NSMakeRange(scanner.location, 0)];
        }
        
        // Need 4 spaces to continue the code block
        [scanner beginTransaction];
        NSUInteger indentation = [scanner skipIndentationUpTo:4];
        if (indentation < 4)
        {
            [scanner commitTransaction:NO];
            break;
        }
        [scanner commitTransaction:YES];
        
        [element addInnerRange:scanner.currentRange];
        [scanner advanceToNextLine];
    }
    
    // Remove any trailing blank lines
    while (element.innerRanges.count > 0 && [[element.innerRanges lastObject] rangeValue].length == 0)
    {
        [element removeLastInnerRange];
    }
    
    // Remove any trailing whitespace from the last line
    if (element.innerRanges.count > 0)
    {
        NSRange lineRange = [[element.innerRanges lastObject] rangeValue];
        [element removeLastInnerRange];
        
        NSCharacterSet *whitespaceSet = NSCharacterSet.whitespaceCharacterSet;
        while (lineRange.length > 0)
        {
            unichar character = [scanner.string characterAtIndex:NSMaxRange(lineRange)-1];
            if ([whitespaceSet characterIsMember:character])
                lineRange.length--;
            else
                break;
        }
        
        [element addInnerRange:lineRange];
    }
    
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    
    if (element.innerRanges.count > 0)
    {
        MMScanner *innerScanner = [MMScanner scannerWithString:scanner.string lineRanges:element.innerRanges];
        element.children = [self _parseCodeLinesWithScanner:innerScanner];
    }
    
    return element;
}

- (MMElement *)_parseFencedCodeBlockWithScanner:(MMScanner *)scanner
{
    if (![scanner matchString:@"```"])
        return nil;
    
    // skip additional backticks and language
    [scanner skipWhitespace];
    
    NSMutableCharacterSet *languageNameSet = NSMutableCharacterSet.alphanumericCharacterSet;
    [languageNameSet addCharactersInString:@"-_"];
    NSString *language = [scanner nextWordWithCharactersFromSet:languageNameSet];
    scanner.location += language.length;
    
    [scanner skipWhitespace];
    if (!scanner.atEndOfLine)
        return nil;
    [scanner advanceToNextLine];
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeCodeBlock;
    element.language = (language.length == 0 ? nil : language);

    // block ends when it hints a line starting with ``` or the end of the string
    while (!scanner.atEndOfString)
    {
        [scanner beginTransaction];
        if ([scanner matchString:@"```"])
        {
            [scanner skipWhitespace];
            if (scanner.atEndOfLine)
            {
                [scanner commitTransaction:YES];
                break;
            }
        }
        [scanner commitTransaction:NO];
        [element addInnerRange:scanner.currentRange];
        [scanner advanceToNextLine];
    }
    
    [scanner advanceToNextLine];
    
    if (element.innerRanges.count > 0)
    {
        MMScanner *innerScanner = [MMScanner scannerWithString:scanner.string lineRanges:element.innerRanges];
        element.children = [self _parseCodeLinesWithScanner:innerScanner];
    }
    
    return element;
}

- (MMElement *)_parseHorizontalRuleWithScanner:(MMScanner *)scanner
{
    // skip initial whitescape
    [scanner skipCharactersFromSet:NSCharacterSet.whitespaceCharacterSet];
    
    unichar character = scanner.nextCharacter;
    if (character != '*' && character != '-' && character != '_')
        return nil;
    
    unichar    nextChar = character;
    NSUInteger count    = 0;
    while (!scanner.atEndOfLine && nextChar == character)
    {
        count++;
        
        // The *, -, or _
        [scanner advance];
        nextChar = scanner.nextCharacter;
        
        // An optional space
        if (nextChar == ' ')
        {
            [scanner advance];
            nextChar = scanner.nextCharacter;
        }
    }
    
    // There must be at least 3 *, -, or _
    if (count < 3)
        return nil;
    
    // skip trailing whitespace
    [scanner skipCharactersFromSet:NSCharacterSet.whitespaceCharacterSet];
    
    // must be at the end of the line at this point
    if (!scanner.atEndOfLine)
        return nil;
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeHorizontalRule;
    element.range = NSMakeRange(scanner.startLocation, scanner.location - scanner.startLocation);
    
    return element;
}

- (BOOL)_parseListMarkerWithScanner:(MMScanner *)scanner listType:(MMListType)listType
{
    switch (listType)
    {
        case MMListTypeBulleted:
            [scanner beginTransaction];
            unichar nextChar = scanner.nextCharacter;
            if (nextChar == '*' || nextChar == '-' || nextChar == '+')
            {
                [scanner advance];
                if (scanner.nextCharacter == ' ')
                {
                    [scanner advance];
                    [scanner commitTransaction:YES];
                    return YES;
                }
            }
            [scanner commitTransaction:NO];
            break;
            
        case MMListTypeNumbered:
            [scanner beginTransaction];
            NSUInteger numOfNums = [scanner skipCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet]];
            if (numOfNums != 0)
            {
                unichar nextChar = scanner.nextCharacter;
                if (nextChar == '.')
                {
                    [scanner advance];
                    if (scanner.nextCharacter == ' ')
                    {
                        [scanner advance];
                        [scanner commitTransaction:YES];
                        return YES;
                    }
                }
            }
            [scanner commitTransaction:NO];
            break;
    }
    
    return NO;
}

- (MMElement *)_parseListItemWithScanner:(MMScanner *)scanner listType:(MMListType)listType
{
    BOOL canContainBlocks = NO;
    
    if ([scanner skipEmptyLines])
    {
        canContainBlocks = YES;
    }
    
    [scanner skipIndentationUpTo:3]; // Optional space
    
    BOOL foundAnItem = [self _parseListMarkerWithScanner:scanner listType:listType];
    if (!foundAnItem)
        return nil;
    
    [scanner skipCharactersFromSet:NSCharacterSet.whitespaceCharacterSet];
    
    MMElement *element = [MMElement new];
    element.type = MMElementTypeListItem;
    
    BOOL afterBlankLine = NO;
    NSUInteger nestedListIndex = NSNotFound;
    NSUInteger nestedListIndentation = 0;
    while (!scanner.atEndOfString)
    {
        // Skip over any empty lines
        [scanner beginTransaction];
        NSUInteger numOfEmptyLines = [scanner skipEmptyLines];
        afterBlankLine = numOfEmptyLines != 0;
        
        // Check for a horizontal rule
        [scanner beginTransaction];
        BOOL newRule = [self _parseHorizontalRuleWithScanner:scanner] != nil;
        [scanner commitTransaction:NO];
        if (newRule)
        {
            [scanner commitTransaction:NO];
            break;
        }
        
        // Check for the start of a new list item
        [scanner beginTransaction];
        [scanner skipIndentationUpTo:1];
        BOOL newMarker = [self _parseListMarkerWithScanner:scanner listType:listType];
        [scanner commitTransaction:NO];
        if (newMarker)
        {
            [scanner commitTransaction:NO];
            if (afterBlankLine)
            {
                canContainBlocks = YES;
            }
            break;
        }
        
        // Check for a nested list
        [scanner beginTransaction];
        NSUInteger indentation = [scanner skipIndentationUpTo:4];
        [scanner beginTransaction];
        BOOL newList = [self _parseListMarkerWithScanner:scanner listType:MMListTypeBulleted]
                    || [self _parseListMarkerWithScanner:scanner listType:MMListTypeNumbered];
        [scanner commitTransaction:NO];
        if (indentation >= 2 && newList && nestedListIndex == NSNotFound)
        {
            [element addInnerRange:NSMakeRange(scanner.location, 0)];
            nestedListIndex = element.innerRanges.count;
            [element addInnerRange:scanner.currentRange];
            
            [scanner commitTransaction:YES];
            [scanner commitTransaction:YES];
            [scanner advanceToNextLine];
            nestedListIndentation = indentation;
            continue;
        }
        [scanner commitTransaction:NO];
        
        if (afterBlankLine)
        {
            // Must be 4 spaces past the indentation level to start a new paragraph
            [scanner beginTransaction];
            NSUInteger indentation = [scanner skipIndentationUpTo:4];
            if (indentation < 4)
            {
                [scanner commitTransaction:NO];
                [scanner commitTransaction:NO];
                break;
            }
            [scanner commitTransaction:YES];
            [scanner commitTransaction:YES];
            
            [element addInnerRange:NSMakeRange(scanner.location, 0)];
            canContainBlocks = YES;
        }
        else
        {
            [scanner commitTransaction:YES];
            
            // Don't skip past where a nested list would start because that list
            // could have its own nested list, so the whitespace will be needed.
            [scanner skipIndentationUpTo:nestedListIndentation];
        }
        
        if (nestedListIndex != NSNotFound)
        {
            [element addInnerRange:scanner.currentRange];
            [scanner advanceToNextLine];
        }
        else
        {
            [self _addTextLineToElement:element withScanner:scanner];
        }
        
        [scanner beginTransaction];
        [scanner skipIndentationUpTo:4];
        if (scanner.nextCharacter == '>')
        {
            //
            // If next line is start with blockquote mark
            // then break current list parsering.
            //
            // for example:
            //
            // > 123
            // + abc
            //
            // "+ abs" should not consider as part of blockquote
            //
            // > 234
            // 567
            //
            // "567" is part of the blockquote
            //
            [scanner commitTransaction:NO];
            break;
        }
        [scanner commitTransaction:NO];
        
    }
    
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    
    if (element.innerRanges.count > 0)
    {
        if (nestedListIndex != NSNotFound)
        {
            NSArray *preListRanges  = [element.innerRanges subarrayWithRange:NSMakeRange(0, nestedListIndex)];
            NSArray *postListRanges = [element.innerRanges subarrayWithRange:NSMakeRange(nestedListIndex, element.innerRanges.count - nestedListIndex)];
            MMScanner *preListScanner  = [MMScanner scannerWithString:scanner.string lineRanges:preListRanges];
            MMScanner *postListScanner = [MMScanner scannerWithString:scanner.string lineRanges:postListRanges];
            
            if (canContainBlocks)
            {
                element.children = [self _parseElementsWithScanner:preListScanner];
            }
            else
            {
                element.children = [self.spanParser parseSpansInBlockElement:element withScanner:preListScanner];
            }
            
            element.children = [element.children arrayByAddingObjectsFromArray:[self _parseElementsWithScanner:postListScanner]];
        }
        else
        {
            MMScanner *innerScanner = [MMScanner scannerWithString:scanner.string lineRanges:element.innerRanges];
            if (canContainBlocks)
            {
                element.children = [self _parseElementsWithScanner:innerScanner];
            }
            else
            {
                element.children = [self.spanParser parseSpansInBlockElement:element withScanner:innerScanner];
            }
        }
    }
    
    return element;
}

- (MMElement *)_parseListWithScanner:(MMScanner *)scanner
{
    [scanner beginTransaction];
    
    [scanner skipIndentationUpTo:3]; // Optional space
    unichar nextChar   = scanner.nextCharacter;
    BOOL       isBulleted = (nextChar == '*' || nextChar == '-' || nextChar == '+');
    MMListType listType   = isBulleted ? MMListTypeBulleted : MMListTypeNumbered;
    BOOL       hasMarker  = [self _parseListMarkerWithScanner:scanner listType:listType];
    [scanner commitTransaction:NO];
    
    if (!hasMarker)
        return nil;
    
    MMElement *element = [MMElement new];
    element.type = isBulleted ? MMElementTypeBulletedList : MMElementTypeNumberedList;
    
    while (!scanner.atEndOfString)
    {
        [scanner beginTransaction];
        
        // Check for a horizontal rule first -- they look like a list marker
        [scanner skipEmptyLines];
        MMElement *rule = [self _parseHorizontalRuleWithScanner:scanner];
        
        [scanner commitTransaction:NO];
        if (rule)
            break;
        
        [scanner beginTransaction];
        MMElement *item = [self _parseListItemWithScanner:scanner listType:listType];
        if (!item)
        {
            [scanner commitTransaction:NO];
            break;
        }
        [scanner commitTransaction:YES];
        
        [element addChild:item];
    }
    
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    
    return element;
}

- (MMElement *)_parseLinkDefinitionWithScanner:(MMScanner *)scanner
{
    NSUInteger location;
    NSUInteger length;
    NSCharacterSet *whitespaceSet = NSCharacterSet.whitespaceCharacterSet;
    
    [scanner skipIndentationUpTo:3];
    
    // find the identifier
    location = scanner.location;
    length   = [scanner skipNestedBracketsWithDelimiter:'['];
    if (length == 0)
        return nil;
    
    NSRange idRange = NSMakeRange(location+1, length-2);
    
    // and the semicolon
    if (scanner.nextCharacter != ':')
        return nil;
    [scanner advance];
    
    // skip any whitespace
    [scanner skipCharactersFromSet:whitespaceSet];
    
    // find the url
    location = scanner.location;
    [scanner skipCharactersFromSet:[whitespaceSet invertedSet]];
    
    NSRange   urlRange  = NSMakeRange(location, scanner.location-location);
    NSString *urlString = [scanner.string substringWithRange:urlRange];
    
    // Check if the URL is surrounded by angle brackets
    if ([urlString hasPrefix:@"<"] && [urlString hasSuffix:@">"])
    {
        urlString = [urlString substringWithRange:NSMakeRange(1, urlString.length-2)];
    }
    
    // skip trailing whitespace
    [scanner skipCharactersFromSet:whitespaceSet];
    
    // If at the end of the line, then try to find the title on the next line
    [scanner beginTransaction];
    if (scanner.atEndOfLine)
    {
        [scanner advanceToNextLine];
        [scanner skipCharactersFromSet:whitespaceSet];
    }
    
    // check for a title
    NSRange titleRange = NSMakeRange(NSNotFound, 0);
    unichar nextChar  = scanner.nextCharacter;
    if (nextChar == '"' || nextChar == '\'' || nextChar == '(')
    {
        [scanner advance];
        unichar endChar = (nextChar == '(') ? ')' : nextChar;
        NSUInteger titleLocation = scanner.location;
        NSUInteger titleLength   = [scanner skipToLastCharacterOfLine];
        if (scanner.nextCharacter == endChar)
        {
            [scanner advance];
            titleRange = NSMakeRange(titleLocation, titleLength);
        }
    }
    
    [scanner commitTransaction:titleRange.location != NSNotFound];
    
    // skip trailing whitespace
    [scanner skipCharactersFromSet:whitespaceSet];
    
    // make sure we're at the end of the line
    if (!scanner.atEndOfLine)
        return nil;
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeDefinition;
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    element.identifier = [scanner.string substringWithRange:idRange];
    element.href       = urlString;
    
    if (titleRange.location != NSNotFound)
    {
        element.title = [scanner.string substringWithRange:titleRange];
    }
    
    return element;
}

- (MMElement *)_parseParagraphWithScanner:(MMScanner *)scanner
{
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeParagraph;
    
    NSCharacterSet *whitespaceSet = NSCharacterSet.whitespaceCharacterSet;
    while (!scanner.atEndOfString)
    {
        [scanner skipWhitespace];
        if (scanner.atEndOfLine)
        {
            [scanner advanceToNextLine];
            break;
        }
        
        // Check for a blockquote
        [scanner beginTransaction];
        [scanner skipCharactersFromSet:whitespaceSet];
        if (scanner.nextCharacter == '>')
        {
            [scanner commitTransaction:YES];
            break;
        }
        [scanner commitTransaction:NO];
        
        BOOL hasElement;
        
        // Check for a link definition
        [scanner beginTransaction];
        hasElement = [self _parseLinkDefinitionWithScanner:scanner] != nil;
        [scanner commitTransaction:NO];
        if (hasElement)
            break;
        
        // Check for an underlined header
        [scanner beginTransaction];
        hasElement = [self _parseUnderlinedHeaderWithScanner:scanner] != nil;
        [scanner commitTransaction:NO];
        if (hasElement)
            break;
        
        // Also check for a prefixed header
        [scanner beginTransaction];
        hasElement = [self _parsePrefixHeaderWithScanner:scanner] != nil;
        [scanner commitTransaction:NO];
        if (hasElement)
            break;
        
        // Check for a fenced code block under GFM
        if (self.extensions & MMMarkdownExtensionsFencedCodeBlocks)
        {
            [scanner beginTransaction];
            hasElement = [self _parseFencedCodeBlockWithScanner:scanner] != nil;
            [scanner commitTransaction:NO];
            if (hasElement)
                break;
        }
        
        // Check for a list item
        [scanner beginTransaction];
        [scanner skipIndentationUpTo:2];
        hasElement = [self _parseListMarkerWithScanner:scanner listType:MMListTypeBulleted]
                  || [self _parseListMarkerWithScanner:scanner listType:MMListTypeNumbered];
        [scanner commitTransaction:NO];
        if (hasElement)
            break;
        
        [self _addTextLineToElement:element withScanner:scanner];
    }
    
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    
    if (element.innerRanges.count == 0)
        return nil;
    
    MMScanner *innerScanner = [MMScanner scannerWithString:scanner.string lineRanges:element.innerRanges];
    element.children = [self.spanParser parseSpansInBlockElement:element withScanner:innerScanner];
    
    return element;
}

- (NSArray *)_parseTableHeaderWithScanner:(MMScanner *)scanner
{
    NSCharacterSet *dashSet = [NSCharacterSet characterSetWithCharactersInString:@"-"];
    
    [scanner skipWhitespace];
    if (scanner.nextCharacter == '|')
        [scanner advance];
    [scanner skipWhitespace];
    
    NSMutableArray *alignments = [NSMutableArray new];
    
    while (!scanner.atEndOfLine)
    {
        BOOL left = NO;
        if (scanner.nextCharacter == ':')
        {
            left = YES;
            [scanner advance];
        }
        
        NSUInteger dashes = [scanner skipCharactersFromSet:dashSet];
        if (dashes < 3)
            return nil;
        
        BOOL right = NO;
        if (scanner.nextCharacter == ':')
        {
            right = YES;
            [scanner advance];
        }
        
        MMTableCellAlignment alignment
            = left && right ? MMTableCellAlignmentCenter
            : left          ? MMTableCellAlignmentLeft
            : right         ? MMTableCellAlignmentRight
            : MMTableCellAlignmentNone;
        [alignments addObject:@(alignment)];
        
        [scanner skipWhitespace];
        if (scanner.nextCharacter != '|')
            break;
        [scanner advance];
        [scanner skipWhitespace];
    }
    
    if (!scanner.atEndOfLine)
        return nil;
    
    return alignments;
}

- (MMElement *)_parseTableRowWithScanner:(MMScanner *)scanner columns:(NSArray *)columns
{
    NSMutableCharacterSet *trimmingSet = NSMutableCharacterSet.whitespaceCharacterSet;
    [trimmingSet addCharactersInString:@"|"];
    
    NSValue   *lineRange   = [NSValue valueWithRange:scanner.currentRange];
    MMScanner *lineScanner = [MMScanner scannerWithString:scanner.string lineRanges:@[ lineRange ]];
    
    [lineScanner skipCharactersFromSet:trimmingSet];
    NSArray *cells = [self.spanParser parseSpansInTableColumns:columns withScanner:lineScanner];
    [lineScanner skipCharactersFromSet:trimmingSet];
    
    if (!cells || !lineScanner.atEndOfLine)
        return nil;
    [scanner advanceToNextLine];
    
    MMElement *row = [MMElement new];
    row.type     = MMElementTypeTableRow;
    row.children = cells;
    row.range    = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    return row;
}

- (MMElement *)_parseTableWithScanner:(MMScanner *)scanner
{
    // Look for the header first
    [scanner advanceToNextLine];
    NSArray *alignments = [self _parseTableHeaderWithScanner:scanner];
    if (!alignments)
        return nil;
    
    // Undo the outer transaction to begin at the header content again
    [scanner commitTransaction:NO];
    [scanner beginTransaction];
    
    MMElement *header = [self _parseTableRowWithScanner:scanner columns:alignments];
    if (!header)
        return nil;
    
    header.type = MMElementTypeTableHeader;
    for (MMElement *cell in header.children)
        cell.type = MMElementTypeTableHeaderCell;
    
    [scanner advanceToNextLine];
    
    NSMutableArray *rows = [NSMutableArray arrayWithObject:header];
    while (!scanner.atEndOfString)
    {
        [scanner beginTransaction];
        MMElement *row = [self _parseTableRowWithScanner:scanner columns:alignments];
        [scanner commitTransaction:row != nil];
        if (row == nil)
            break;
        [rows addObject:row];
    }
    
    if (rows.count < 2)
        return nil;
    
    MMElement *table = [MMElement new];
    table.type     = MMElementTypeTable;
    table.children = rows;
    table.range    = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    return table;
}

- (void)_updateLinksFromDefinitionsInDocument:(MMDocument *)document
{
    NSMutableArray      *references  = [NSMutableArray new];
    NSMutableDictionary *definitions = [NSMutableDictionary new];
    NSMutableArray      *queue       = [NSMutableArray new];
    
    [queue addObjectsFromArray:document.elements];
    
    // First, find the references and definitions
    while (queue.count > 0)
    {
        MMElement *element = [queue objectAtIndex:0];
        [queue removeObjectAtIndex:0];
        [queue addObjectsFromArray:element.children];
        
        switch (element.type)
        {
            case MMElementTypeDefinition:
                definitions[element.identifier.lowercaseString] = element;
                break;
            case MMElementTypeImage:
            case MMElementTypeLink:
                if (element.identifier && !element.href)
                {
                    [references addObject:element];
                }
                break;
            default:
                break;
        }
    }
    
    // Set the hrefs for all the references
    for (MMElement *link in references)
    {
        MMElement *definition = definitions[link.identifier.lowercaseString];
        
        // If there's no definition, change the link to a text element and remove its children
        if (!definition)
        {
            link.type = MMElementTypeNone;
            while (link.children.count > 0)
            {
                [link removeLastChild];
            }
        }
        // otherwise, set the href and title
        {
            link.href  = definition.href;
            link.title = definition.title;
        }
    }
}


@end
