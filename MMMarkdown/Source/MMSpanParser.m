//
//  MMSpanParser.m
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

#import "MMSpanParser.h"


#import "MMElement.h"
#import "MMHTMLParser.h"
#import "MMScanner.h"

static NSString * const ESCAPABLE_CHARS = @"\\`*_{}[]()#+-.!>";

@interface MMSpanParser ()
@property (assign, nonatomic, readonly) MMMarkdownExtensions extensions;
@property (strong, nonatomic, readonly) MMHTMLParser *htmlParser;

@property (strong, nonatomic) NSMutableArray *elements;
@property (strong, nonatomic) NSMutableArray *openElements;

@property (strong, nonatomic) MMElement *blockElement;
@property (assign, nonatomic) BOOL parseEm;
@property (assign, nonatomic) BOOL parseImages;
@property (assign, nonatomic) BOOL parseLinks;
@property (assign, nonatomic) BOOL parseStrong;
@end

@implementation MMSpanParser

#pragma mark - Public Methods

- (id)initWithExtensions:(MMMarkdownExtensions)extensions
{
    self = [super init];
    
    if (self)
    {
        _extensions = extensions;
        _htmlParser = [MMHTMLParser new];
        self.parseEm     = YES;
        self.parseImages = YES;
        self.parseLinks  = YES;
        self.parseStrong = YES;
    }
    
    return self;
}

- (NSArray *)parseSpansInBlockElement:(MMElement *)block withScanner:(MMScanner *)scanner
{
    self.blockElement = block;
    [scanner skipWhitespace];
    return [self _parseWithScanner:scanner untilTestPasses:^{ return scanner.atEndOfString; }];
}

- (NSArray *)parseSpansInTableColumns:(NSArray *)columns withScanner:(MMScanner *)scanner
{
    NSMutableArray *cells = [NSMutableArray new];
    
    for (NSNumber *alignment in columns)
    {
        [scanner skipWhitespace];
        
        NSUInteger startLocation = scanner.location;
        NSArray *spans = scanner.nextCharacter == '|' ? @[] : [self _parseWithScanner:scanner untilTestPasses:^ BOOL {
            [scanner skipWhitespace];
            return scanner.nextCharacter == '|' || scanner.atEndOfLine;
        }];
        
        if (!spans)
            return nil;
        
        MMElement *cell = [MMElement new];
        cell.type      = MMElementTypeTableRowCell;
        cell.children  = spans;
        cell.range     = NSMakeRange(startLocation, scanner.location-startLocation);
        cell.alignment = alignment.integerValue;
        [cells addObject:cell];
        
        if (scanner.nextCharacter == '|')
            [scanner advance];
    }
    
    return cells;
}


#pragma mark - Private Methods

- (NSArray *)_parseWithScanner:(MMScanner *)scanner untilTestPasses:(BOOL (^)())test
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSCharacterSet *specialChars = [NSCharacterSet characterSetWithCharactersInString:@"\\`*_<&[! ~w:@|"];
    NSCharacterSet *boringChars  = [specialChars invertedSet];
    
    [scanner beginTransaction];
    while (!scanner.atEndOfString)
    {
        MMElement *element = [self _parseNextElementWithScanner:scanner];
        if (element)
        {
            if (scanner.startLocation != element.range.location)
            {
                MMElement *text = [MMElement new];
                text.type  = MMElementTypeNone;
                text.range = NSMakeRange(scanner.startLocation, element.range.location-scanner.startLocation);
                [result addObject:text];
            }
            
            [result addObject:element];
            
            [scanner commitTransaction:YES];
            [scanner beginTransaction];
        }
        else if (scanner.atEndOfLine)
        {
            // This is done here (and not in _parseNextElementWithScanner:)
            // because it can result in 2 elements.
            
            if (scanner.startLocation != scanner.location)
            {
                MMElement *text = [MMElement new];
                text.type  = MMElementTypeNone;
                text.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
                [result addObject:text];
            }
            
            if (self.extensions & MMMarkdownExtensionsHardNewlines && self.blockElement.type == MMElementTypeParagraph)
            {
                MMElement *lineBreak = [MMElement new];
                lineBreak.range = NSMakeRange(scanner.location, 1);
                lineBreak.type  = MMElementTypeLineBreak;
                [result addObject:lineBreak];
            }
            
            // Add a newline
            MMElement *newline = [MMElement new];
            newline.range       = NSMakeRange(scanner.location, 1);
            newline.type        = MMElementTypeEntity;
            newline.stringValue = @"\n";
            [result addObject:newline];
            
            [scanner advanceToNextLine];
            [scanner commitTransaction:YES];
            [scanner beginTransaction];
        }
        else if ([scanner skipCharactersFromSet:boringChars])
        {
        }
        else
        {
            [scanner advance];
        }
        
        // Check for the end character
        [scanner beginTransaction];
        NSUInteger location = scanner.location;
        if (test())
        {
            [scanner commitTransaction:YES];
            
            if (scanner.startLocation != location)
            {
                MMElement *text = [MMElement new];
                text.type  = MMElementTypeNone;
                text.range = NSMakeRange(scanner.startLocation, location-scanner.startLocation);
                [result addObject:text];
            }
            
            [scanner commitTransaction:YES];
            
            return result;
        }
        [scanner commitTransaction:NO];
    }
    [scanner commitTransaction:NO];
    
    return nil;
}
       
- (MMElement *)_parseNextElementWithScanner:(MMScanner *)scanner
{
    MMElement *element;
    
    if (self.extensions & MMMarkdownExtensionsStrikethroughs)
    {
        [scanner beginTransaction];
        element = [self _parseStrikethroughWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
    }
    
    // URL Autolinking
    if (self.parseLinks && self.extensions & MMMarkdownExtensionsAutolinkedURLs)
    {
        [scanner beginTransaction];
        element = [self _parseAutolinkEmailAddressWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
        
        [scanner beginTransaction];
        element = [self _parseAutolinkURLWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
        
        [scanner beginTransaction];
        element = [self _parseAutolinkWWWURLWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
    }
    
    [scanner beginTransaction];
    element = [self _parseBackslashWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseEmAndStrongWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseCodeSpanWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseLineBreakWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    if (self.parseLinks)
    {
        [scanner beginTransaction];
        element = [self _parseAutomaticLinkWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
        
        [scanner beginTransaction];
        element = [self _parseAutomaticEmailLinkWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
        
        [scanner beginTransaction];
        element = [self _parseLinkWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
    }
    
    if (self.parseImages)
    {
        [scanner beginTransaction];
        element = [self _parseImageWithScanner:scanner];
        [scanner commitTransaction:element != nil];
        if (element)
            return element;
    }
    
    [scanner beginTransaction];
    element = [self.htmlParser parseInlineTagWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self.htmlParser parseCommentWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseAmpersandWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    [scanner beginTransaction];
    element = [self _parseLeftAngleBracketWithScanner:scanner];
    [scanner commitTransaction:element != nil];
    if (element)
        return element;
    
    return nil;
}

- (BOOL)_parseAutolinkDomainWithScanner:(MMScanner *)scanner
{
    NSCharacterSet        *alphanumerics = NSCharacterSet.alphanumericCharacterSet;
    NSMutableCharacterSet *domainChars   = [alphanumerics mutableCopy];
    [domainChars addCharactersInString:@"-:"];
    
    // Domain should be at least one alphanumeric
    if (![alphanumerics characterIsMember:scanner.nextCharacter])
        return NO;
    [scanner skipCharactersFromSet:domainChars];
    
    // Dot between domain and TLD
    if (scanner.nextCharacter != '.')
        return NO;
    [scanner advance];
    
    // TLD must be at least 1 character
    if ([scanner skipCharactersFromSet:domainChars] == 0)
        return NO;
    
    return YES;
}

- (void)_parseAutolinkPathWithScanner:(MMScanner *)scanner
{
    NSCharacterSet        *alphanumerics = NSCharacterSet.alphanumericCharacterSet;
    NSMutableCharacterSet *boringChars = [alphanumerics mutableCopy];
    [boringChars addCharactersInString:@",_-/:?&;%~!#+=@"];
    
    NSUInteger parenLevel = 0;
    while (1)
    {
        if ([scanner skipCharactersFromSet:boringChars] > 0)
        {
            continue;
        }
        else if (scanner.nextCharacter == '\\')
        {
            [scanner advance];
            if (scanner.nextCharacter == '(' || scanner.nextCharacter == ')')
                [scanner advance];
        }
        else if (scanner.nextCharacter == '(')
        {
            parenLevel++;
            [scanner advance];
        }
        else if (scanner.nextCharacter == ')' && parenLevel > 0)
        {
            parenLevel--;
            [scanner advance];
        }
        else if (scanner.nextCharacter == '.')
        {
            // Can't end on a '.'
            [scanner beginTransaction];
            [scanner advance];
            if ([boringChars characterIsMember:scanner.nextCharacter])
            {
                [scanner commitTransaction:YES];
            }
            else
            {
                [scanner commitTransaction:NO];
                break;
            }
        }
        else
        {
            break;
        }
    }
}

- (MMElement *)_parseAutolinkEmailAddressWithScanner:(MMScanner *)scanner
{
    if (scanner.nextCharacter != '@')
        return nil;
    
    NSCharacterSet *alphanumerics = NSCharacterSet.alphanumericCharacterSet;
    NSMutableCharacterSet *localChars  = [alphanumerics mutableCopy];
    [localChars addCharactersInString:@"._-+"];
    NSMutableCharacterSet *domainChars = [alphanumerics mutableCopy];
    [domainChars addCharactersInString:@"._-"];
    
    // Look for the previous word outside of the current transaction
    [scanner commitTransaction:NO];
    NSString *localPart = [scanner previousWordWithCharactersFromSet:localChars];
    [scanner beginTransaction];
    
    if (localPart.length == 0)
        return nil;
    
    // '@'
    [scanner advance];
    
    NSString *domainPart = [scanner nextWordWithCharactersFromSet:localChars];
    
    // Must end on a letter or number
    NSRange lastAlphanum = [domainPart rangeOfCharacterFromSet:alphanumerics options:NSBackwardsSearch];
    if (lastAlphanum.location == NSNotFound)
        return nil;
    domainPart = [domainPart substringToIndex:NSMaxRange(lastAlphanum)];
    
    // Must contain at least one .
    if ([domainPart rangeOfString:@"."].location == NSNotFound)
        return nil;
    
    scanner.location += domainPart.length;
    
    NSUInteger startLocation = scanner.startLocation - localPart.length;
    NSRange range = NSMakeRange(startLocation, scanner.location-startLocation);
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeMailTo;
    element.range = range;
    element.href  = [scanner.string substringWithRange:range];
    
    return element;
}

- (MMElement *)_parseAutolinkURLWithScanner:(MMScanner *)scanner
{
    if (scanner.nextCharacter != ':')
        return nil;
    
    NSArray  *protocols    = @[ @"https", @"http", @"ftp" ];
    
    // Look for the previous word outside of the current transaction
    [scanner commitTransaction:NO];
    NSString *previousWord = scanner.previousWord;
    [scanner beginTransaction];
    
    if (![protocols containsObject:previousWord.lowercaseString])
        return nil;
    
    if (![scanner matchString:@"://"])
        return nil;
    
    if (![self _parseAutolinkDomainWithScanner:scanner])
        return nil;
    [self _parseAutolinkPathWithScanner:scanner];
    
    NSUInteger startLocation = scanner.startLocation - previousWord.length;
    NSRange   range = NSMakeRange(startLocation, scanner.location-startLocation);
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeLink;
    element.range = range;
    element.href  = [scanner.string substringWithRange:range];
    
    MMElement *text = [MMElement new];
    text.type  = MMElementTypeNone;
    text.range = range;
    [element addChild:text];
    
    return element;
}

- (MMElement *)_parseAutolinkWWWURLWithScanner:(MMScanner *)scanner
{
    if (![scanner matchString:@"www."])
        return nil;
    
    if (![self _parseAutolinkDomainWithScanner:scanner])
        return nil;
    [self _parseAutolinkPathWithScanner:scanner];
    
    NSRange   range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    NSString *link  = [scanner.string substringWithRange:range];
    
    MMElement *element = [MMElement new];
    element.type     = MMElementTypeLink;
    element.range    = range;
    element.href     = [@"http://" stringByAppendingString:link];
    
    MMElement *text = [MMElement new];
    text.type  = MMElementTypeNone;
    text.range = range;
    [element addChild:text];
    
    return element;
}

- (MMElement *)_parseStrikethroughWithScanner:(MMScanner *)scanner
{
    if (![scanner matchString:@"~~"])
        return nil;
    
    NSCharacterSet  *whitespaceSet = NSCharacterSet.whitespaceCharacterSet;
    NSArray         *children      = [self _parseWithScanner:scanner untilTestPasses:^{
        // Can't be at the beginning of the line
        if (scanner.atBeginningOfLine)
            return NO;
        
        // Must follow the end of a word
        if ([whitespaceSet characterIsMember:scanner.previousCharacter])
            return NO;
        
        if (![scanner matchString:@"~~"])
            return NO;
        
        return YES;
    }];
    
    if (!children)
        return nil;
    
    MMElement *element = [MMElement new];
    element.type     = MMElementTypeStrikethrough;
    element.range    = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    element.children = children;
    
    return element;
}

- (MMElement *)_parseEmAndStrongWithScanner:(MMScanner *)scanner
{
    // Must have 1-3 *s or _s
    unichar character = scanner.nextCharacter;
    if (!(character == '*' || character == '_'))
        return nil;
    
    NSCharacterSet *alphanumericSet = NSCharacterSet.alphanumericCharacterSet;
    if (self.extensions & MMMarkdownExtensionsUnderscoresInWords && character == '_')
    {
        // GFM doesn't italicize parts of words
        
        [scanner commitTransaction:NO];
        // Look for the previous char outside of the current transaction
        unichar prevChar = scanner.previousCharacter;
        [scanner beginTransaction];
        
        BOOL isWordChar = [alphanumericSet characterIsMember:prevChar];
        if (isWordChar)
            return nil;
    }
    
    // Must not be preceded by one of the same
    if (scanner.previousCharacter == character)
        return nil;
    
    NSUInteger numberOfChars = 0;
    while (scanner.nextCharacter == character)
    {
        numberOfChars++;
        [scanner advance];
    }
    
    if (numberOfChars > 3)
        return nil;
    
    BOOL parseEm     = numberOfChars == 1 || numberOfChars == 3;
    BOOL parseStrong = numberOfChars == 2 || numberOfChars == 3;
    
    if ((parseEm && !self.parseEm) || (parseStrong && !self.parseStrong))
        return nil;
    
    NSCharacterSet *whitespaceSet = NSCharacterSet.whitespaceCharacterSet;
    __block NSUInteger remainingChars = numberOfChars;
    BOOL (^atEnd)(void) = ^{
        // Can't be at the beginning of the line
        if (scanner.atBeginningOfLine)
            return NO;
        
        // Must follow the end of a word
        if ([whitespaceSet characterIsMember:scanner.previousCharacter])
            return NO;
        
        // Must have 1-3 *s or _s
        NSUInteger numberOfEndChars = 0;
        while (scanner.nextCharacter == character && numberOfEndChars < remainingChars)
        {
            numberOfEndChars++;
            [scanner advance];
        }
        
        if (numberOfEndChars == 0 || (numberOfEndChars != remainingChars && remainingChars != 3))
            return NO;
        
        if (self.extensions & MMMarkdownExtensionsUnderscoresInWords && character == '_')
        {
            // GFM doesn't italicize parts of words
            unichar nextChar = scanner.nextCharacter;
            
            BOOL isWordChar = [alphanumericSet characterIsMember:nextChar];
            if (isWordChar)
                return NO;
        }
        
        remainingChars -= numberOfEndChars;
        
        return YES;
    };
    
    if (parseEm)
        self.parseEm = NO;
    if (parseStrong)
        self.parseStrong = NO;
    NSArray *children = [self _parseWithScanner:scanner untilTestPasses:atEnd];
    if (parseEm && (!children || remainingChars != 1))
        self.parseEm = YES;
    if (parseStrong && (!children || remainingChars != 2))
        self.parseStrong = YES;
    
    if (!children)
        return nil;
    
    BOOL isEm = (numberOfChars == 1) || (numberOfChars == 3 && remainingChars != 1);
    NSUInteger startLocation = scanner.startLocation + remainingChars;
    MMElement *element = [MMElement new];
    element.type     = isEm ? MMElementTypeEm : MMElementTypeStrong;
    element.range    = NSMakeRange(startLocation, scanner.location-startLocation);
    element.children = children;
    
    if (numberOfChars == 3 && remainingChars == 0)
    {
        NSArray *outerChildren = @[ element ];
        element = [MMElement new];
        element.type     = MMElementTypeStrong;
        element.range    = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
        element.children = outerChildren;
    }
    else if (remainingChars > 0)
    {
        NSMutableArray *outerChildren = [[self _parseWithScanner:scanner untilTestPasses:atEnd] mutableCopy];
        if (parseEm)
            self.parseEm = YES;
        if (parseStrong)
            self.parseStrong = YES;
        if (!outerChildren)
            return nil;
        
        [outerChildren insertObject:element atIndex:0];
        
        element = [MMElement new];
        element.type     = !isEm ? MMElementTypeEm : MMElementTypeStrong;
        element.range    = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
        element.children = outerChildren;
    }
    
    return element;
}

- (MMElement *)_parseCodeSpanWithScanner:(MMScanner *)scanner
{
    if (scanner.nextCharacter != '`')
        return nil;
    [scanner advance];
    
    MMElement *element = [MMElement new];
    element.type = MMElementTypeCodeSpan;
    
    // Check for more `s
    NSUInteger level = 1;
    while (scanner.nextCharacter == '`')
    {
        level++;
        [scanner advance];
    }
    
    // skip leading whitespace
    [scanner skipCharactersFromSet:NSCharacterSet.whitespaceCharacterSet];
    
    // Skip to the next '`'
    NSCharacterSet *boringChars  = [[NSCharacterSet characterSetWithCharactersInString:@"`&<>"] invertedSet];
    NSUInteger      textLocation = scanner.location;
    while (1)
    {
        if (scanner.atEndOfString)
            return nil;
        
        // Skip other characters
        [scanner skipCharactersFromSet:boringChars];
        
        // Add the code as text
        if (textLocation != scanner.location)
        {
            MMElement *text = [MMElement new];
            text.type  = MMElementTypeNone;
            text.range = NSMakeRange(textLocation, scanner.location-textLocation);
            [element addChild:text];
        }
        
        // Check for closing `s
        if (scanner.nextCharacter == '`')
        {
            // Set the text location to catch the ` in case it isn't the closing `s
            textLocation = scanner.location;
            
            NSUInteger idx;
            for (idx=0; idx<level; idx++)
            {
                if (scanner.nextCharacter != '`')
                    break;
                [scanner advance];
            }
            if (idx >= level)
                break;
            else
                continue;
        }
        
        unichar nextChar = scanner.nextCharacter;
        // Check for entities
        if (nextChar == '&')
        {
            MMElement *entity = [MMElement new];
            entity.type  = MMElementTypeEntity;
            entity.range = NSMakeRange(scanner.location, 1);
            entity.stringValue = @"&amp;";
            [element addChild:entity];
            [scanner advance];
        }
        else if (nextChar == '<')
        {
            MMElement *entity = [MMElement new];
            entity.type  = MMElementTypeEntity;
            entity.range = NSMakeRange(scanner.location, 1);
            entity.stringValue = @"&lt;";
            [element addChild:entity];
            [scanner advance];
        }
        else if (nextChar == '>')
        {
            MMElement *entity = [MMElement new];
            entity.type  = MMElementTypeEntity;
            entity.range = NSMakeRange(scanner.location, 1);
            entity.stringValue = @"&gt;";
            [element addChild:entity];
            [scanner advance];
        }
        // Or did we hit the end of the line?
        else if (scanner.atEndOfLine)
        {
            textLocation = scanner.location;
            [scanner advanceToNextLine];
            continue;
        }
        
        textLocation = scanner.location;
    }
    
    // remove trailing whitespace
    if (element.children.count > 0)
    {
        MMElement *lastText = element.children.lastObject;
        unichar lastCharacter = [scanner.string characterAtIndex:NSMaxRange(lastText.range)-1];
        while ([NSCharacterSet.whitespaceCharacterSet characterIsMember:lastCharacter])
        {
            NSRange range = lastText.range;
            range.length -= 1;
            lastText.range = range;
            
            lastCharacter = [scanner.string characterAtIndex:NSMaxRange(lastText.range)-1];
        }
    }
    
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    
    return element;
}

- (MMElement *)_parseLineBreakWithScanner:(MMScanner *)scanner
{
    NSCharacterSet *spaces = [NSCharacterSet characterSetWithCharactersInString:@" "];
    if ([scanner skipCharactersFromSet:spaces] < 2)
        return nil;
    
    if (!scanner.atEndOfLine)
        return nil;
    
    // Don't ever add a line break to the last line
    if (scanner.atEndOfString)
        return nil;
    
    NSUInteger startLocation = scanner.startLocation + 1;
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeLineBreak;
    element.range = NSMakeRange(startLocation, scanner.location-startLocation);
    
    return element;
}

- (MMElement *)_parseAutomaticLinkWithScanner:(MMScanner *)scanner
{
    // Leading <
    if (scanner.nextCharacter != '<')
        return nil;
    [scanner advance];
    
    NSUInteger textLocation = scanner.location;
    
    // Find the trailing >
    [scanner skipCharactersFromSet:[[NSCharacterSet characterSetWithCharactersInString:@">"] invertedSet]];
    if (scanner.atEndOfLine)
        return nil;
    [scanner advance];
    
    NSRange   linkRange = NSMakeRange(textLocation, (scanner.location-1)-textLocation);
    NSString *linkText  = [scanner.string substringWithRange:linkRange];
    
    // Make sure it looks like a link
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\w+)://" options:0 error:nil];
    });
    NSRange matchRange;
    matchRange = [regex rangeOfFirstMatchInString:linkText options:0 range:NSMakeRange(0, linkText.length)];
    if (matchRange.location == NSNotFound)
        return nil;
    NSURL *url = [NSURL URLWithString:linkText];
    if (!url)
        return nil;
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeLink;
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    element.href  = linkText;
    
    // Do the text the hard way to take care of ampersands
    NSRange textRange = NSMakeRange(textLocation, NSMaxRange(linkRange)-textLocation);
    NSCharacterSet *ampersands = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    while (textRange.length > 0)
    {
        NSRange result = [scanner.string rangeOfCharacterFromSet:ampersands
                                                         options:0
                                                           range:textRange];
        
        if (result.location != NSNotFound)
        {
            if (textRange.location != result.location)
            {
                MMElement *text = [MMElement new];
                text.type  = MMElementTypeNone;
                text.range = NSMakeRange(textRange.location, result.location-textRange.location);
                [element addChild:text];
            }
            
            MMElement *ampersand = [MMElement new];
            ampersand.type  = MMElementTypeEntity;
            ampersand.range = NSMakeRange(textRange.location, 1);
            ampersand.stringValue = @"&amp;";
            [element addChild:ampersand];
            
            textRange = NSMakeRange(result.location+1, NSMaxRange(textRange)-(result.location+1));
        }
        else
        {
            if (textRange.length > 0)
            {
                MMElement *text = [MMElement new];
                text.type  = MMElementTypeNone;
                text.range = textRange;
                [element addChild:text];
            }
            break;
        }
    }
    
    return element;
}

- (MMElement *)_parseAutomaticEmailLinkWithScanner:(MMScanner *)scanner
{
    // Leading <
    if (scanner.nextCharacter != '<')
        return nil;
    [scanner advance];
    
    NSUInteger textLocation = scanner.location;
    
    // Find the trailing >
    [scanner skipCharactersFromSet:[[NSCharacterSet characterSetWithCharactersInString:@">"] invertedSet]];
    if (scanner.atEndOfLine)
        return nil;
    [scanner advance];
    
    NSRange   linkRange = NSMakeRange(textLocation, (scanner.location-1)-textLocation);
    NSString *linkText  = [scanner.string substringWithRange:linkRange];
    
    // Make sure it looks like a link
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"^[-._0-9\\p{L}]+@[-\\p{L}0-9][-.\\p{L}0-9]*\\.\\p{L}+$"
                                                          options:NSRegularExpressionCaseInsensitive
                                                            error:nil];
    });
    NSRange matchRange;
    matchRange = [regex rangeOfFirstMatchInString:linkText options:0 range:NSMakeRange(0, linkText.length)];
    if (matchRange.location == NSNotFound)
        return nil;
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeMailTo;
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    element.href  = linkText;
    
    return element;
}

- (NSArray *)_parseLinkTextBodyWithScanner:(MMScanner *)scanner
{
    NSMutableArray *ranges  = [NSMutableArray new];
    NSCharacterSet *boringChars;
    NSUInteger      level;
    
    if (scanner.nextCharacter != '[')
        return nil;
    [scanner advance];
    
    boringChars = [[NSCharacterSet characterSetWithCharactersInString:@"[]\\"] invertedSet];
    level       = 1;
    NSRange textRange = scanner.currentRange;
    while (level > 0)
    {
        if (scanner.atEndOfString)
            return nil;
        
        if (scanner.atEndOfLine)
        {
            if (textRange.length > 0)
            {
                [ranges addObject:[NSValue valueWithRange:textRange]];
            }
            [scanner advanceToNextLine];
            textRange = scanner.currentRange;
        }
        
        [scanner skipCharactersFromSet:boringChars];
        
        unichar character = scanner.nextCharacter;
        if (character == '[')
        {
            level += 1;
        }
        else if (character == ']')
        {
            level -= 1;
        }
        else if (character == '\\')
        {
            [scanner advance];
        }
        
        textRange.length = scanner.location - textRange.location;
        [scanner advance];
    }
    
    if (textRange.length > 0)
    {
        [ranges addObject:[NSValue valueWithRange:textRange]];
    }
    
    return ranges;
}

- (MMElement *)_parseInlineLinkWithScanner:(MMScanner *)scanner
{
    NSCharacterSet *boringChars;
    NSUInteger      level;
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeLink;
    
    // Find the []
    element.innerRanges = [self _parseLinkTextBodyWithScanner:scanner];
    if (!element.innerRanges)
        return nil;
    
    // Find the ()
    if (scanner.nextCharacter != '(')
        return nil;
    [scanner advance];
    [scanner skipWhitespace];
    
    NSUInteger      urlLocation = scanner.location;
    NSUInteger      urlEnd      = urlLocation;
    boringChars = [[NSCharacterSet characterSetWithCharactersInString:@"()\\ \t"] invertedSet];
    level       = 1;
    while (level > 0)
    {
        [scanner skipCharactersFromSet:boringChars];
        if (scanner.atEndOfLine)
            return nil;
        urlEnd = scanner.location;
        
        unichar character = scanner.nextCharacter;
        if (character == '(')
        {
            level += 1;
        }
        else if (character == ')')
        {
            level -= 1;
        }
        else if (character == '\\')
        {
            [scanner advance]; // skip over the backslash
            // skip over the next character below
        }
        else if ([NSCharacterSet.whitespaceCharacterSet characterIsMember:character])
        {
            if (level != 1)
                return nil;
            
            [scanner skipWhitespace];
            if (scanner.nextCharacter == ')')
            {
                [scanner advance];
                level -= 1;
            }
            break;
        }
        urlEnd = scanner.location;
        [scanner advance];
    }
    
    NSUInteger titleLocation = NSNotFound;
    NSUInteger titleEnd      = NSNotFound;
    
    // If the level is still 1, then we hit a space.
    if (level == 1)
    {
        // make sure there's a "
        if (scanner.nextCharacter != '"')
            return nil;
        [scanner advance];
        
        titleLocation = scanner.location;
        boringChars   = [[NSCharacterSet characterSetWithCharactersInString:@"\""] invertedSet];
        while (1)
        {
            [scanner skipCharactersFromSet:boringChars];
            
            if (scanner.atEndOfLine)
                return nil;
            
            [scanner advance];
            if (scanner.nextCharacter == ')')
            {
                titleEnd = scanner.location - 1;
                [scanner advance];
                break;
            }
        }
    }
    
    NSRange   urlRange = NSMakeRange(urlLocation, urlEnd-urlLocation);
    NSString *href     = [scanner.string substringWithRange:urlRange];
    
    // If the URL is surrounded by angle brackets, ditch them
    if ([href hasPrefix:@"<"] && [href hasSuffix:@">"])
    {
        href = [href substringWithRange:NSMakeRange(1, href.length-2)];
    }
    
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    element.href  = [self _stringWithBackslashEscapesRemoved:href];
    
    if (titleLocation != NSNotFound)
    {
        NSRange titleRange = NSMakeRange(titleLocation, titleEnd-titleLocation);
        element.title = [scanner.string substringWithRange:titleRange];
    }
    
    return element;
}

- (MMElement *)_parseReferenceLinkWithScanner:(MMScanner *)scanner
{
    MMElement *element = [MMElement new];
    element.type = MMElementTypeLink;
    
    // Find the []
    element.innerRanges = [self _parseLinkTextBodyWithScanner:scanner];
    if (!element.innerRanges.count)
        return nil;
    
    // Skip optional whitespace
    if (scanner.nextCharacter == ' ')
        [scanner advance];
    // or possible newline
    else if (scanner.atEndOfLine)
        [scanner advanceToNextLine];
    
    // Look for the second []
    NSArray *idRanges = [self _parseLinkTextBodyWithScanner:scanner];
    if (!idRanges)
        return nil;
    if (!idRanges.count)
    {
        idRanges = element.innerRanges;
    }

    NSMutableString *idString = [NSMutableString new];
    for (NSValue *value in idRanges)
    {
        NSRange range = [value rangeValue];
        [idString appendString:[scanner.string substringWithRange:range]];
        [idString appendString:@" "]; // newlines are replaced by spaces for the id
    }
    // Delete the last space
    [idString deleteCharactersInRange:NSMakeRange(idString.length-1, 1)];
    
    element.range = NSMakeRange(scanner.startLocation, scanner.location-scanner.startLocation);
    element.identifier = idString;
    
    return element;
}

- (MMElement *)_parseLinkWithScanner:(MMScanner *)scanner
{
    MMElement *element;
    
    element = [self _parseInlineLinkWithScanner:scanner];
    
    if (element == nil)
    {
        // Assume that this method will already be wrapped in a transaction
        [scanner commitTransaction:NO];
        [scanner beginTransaction];
        element = [self _parseReferenceLinkWithScanner:scanner];
    }
    
    if (element != nil && element.innerRanges.count > 0)
    {
        self.parseLinks = NO;
        MMScanner *innerScanner = [MMScanner scannerWithString:scanner.string lineRanges:element.innerRanges];
        element.children = [self _parseWithScanner:innerScanner untilTestPasses:^{ return [innerScanner atEndOfString]; }];
        self.parseLinks = YES;
    }
    
    return element;
}

- (MMElement *)_parseImageWithScanner:(MMScanner *)scanner
{
    MMElement *element;
    
    // An image starts with a !, but then is a link
    if (scanner.nextCharacter != '!')
        return nil;
    [scanner advance];
    
    // Add a transaction to protect the ! that was scanned
    [scanner beginTransaction];
    
    self.parseImages = NO;
    element = [self _parseInlineLinkWithScanner:scanner];
    self.parseImages = YES;
    
    if (element == nil)
    {
        // Assume that this method will already be wrapped in a transaction
        [scanner commitTransaction:NO];
        [scanner beginTransaction];
        element = [self _parseReferenceLinkWithScanner:scanner];
    }
    
    [scanner commitTransaction:YES];
    
    if (element != nil)
    {
        element.type = MMElementTypeImage;
        
        // Adjust the range to include the !
        NSRange range = element.range;
        range.location -= 1;
        range.length += 1;
        element.range = range;
        
        NSMutableString *altText = [NSMutableString new];
        for (NSValue *value in element.innerRanges)
        {
            NSRange range = [value rangeValue];
            [altText appendString:[scanner.string substringWithRange:range]];
        }
        element.stringValue = altText;
    }
    
    return element;
}

- (MMElement *)_parseAmpersandWithScanner:(MMScanner *)scanner
{
    if (scanner.nextCharacter != '&')
        return nil;
    [scanner advance];
    
    // check if this is an html entity
    [scanner beginTransaction];
    
    if (scanner.nextCharacter == '#')
        [scanner advance];
    [scanner skipCharactersFromSet:NSCharacterSet.alphanumericCharacterSet];
    if (scanner.nextCharacter == ';')
    {
        [scanner commitTransaction:NO];
        return nil;
    }
    [scanner commitTransaction:NO];
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeEntity;
    element.range = NSMakeRange(scanner.location-1, 1);
    element.stringValue = @"&amp;";
    
    return element;
}

- (MMElement *)_parseBackslashWithScanner:(MMScanner *)scanner
{
    if (scanner.nextCharacter != '\\')
        return nil;
    [scanner advance];
    
    NSCharacterSet *escapable = [NSCharacterSet characterSetWithCharactersInString:ESCAPABLE_CHARS];
    if (![escapable characterIsMember:scanner.nextCharacter])
        return nil;
    
    // Return the character
    
    MMElement *character = [MMElement new];
    character.type  = MMElementTypeEntity;
    character.range = NSMakeRange(scanner.location-1, 2);
    character.stringValue = [scanner.string substringWithRange:NSMakeRange(scanner.location, 1)];
    
    [scanner advance];
    
    return character;
}

- (MMElement *)_parseLeftAngleBracketWithScanner:(MMScanner *)scanner
{
    if (scanner.nextCharacter != '<')
        return nil;
    [scanner advance];
    
    MMElement *element = [MMElement new];
    element.type  = MMElementTypeEntity;
    element.range = NSMakeRange(scanner.location-1, 1);
    element.stringValue = @"&lt;";
    
    return element;
}

- (NSString *)_stringWithBackslashEscapesRemoved:(NSString *)string
{
    NSMutableString *result = [string mutableCopy];
    
    NSCharacterSet *escapableChars = [NSCharacterSet characterSetWithCharactersInString:ESCAPABLE_CHARS];
    
    NSRange searchRange = NSMakeRange(0, result.length);
    while (searchRange.length > 0)
    {
        NSRange range = [result rangeOfString:@"\\" options:0 range:searchRange];
        
        if (range.location == NSNotFound || NSMaxRange(range) == NSMaxRange(searchRange))
            break;
        
        // If it is escapable, than remove the backslash
        unichar nextChar = [result characterAtIndex:range.location + 1];
        if ([escapableChars characterIsMember:nextChar])
        {
            [result replaceCharactersInRange:range withString:@""];
        }
        
        searchRange.location = range.location + 1;
        searchRange.length   = result.length - searchRange.location;
    }
    
    return result;
}


@end
