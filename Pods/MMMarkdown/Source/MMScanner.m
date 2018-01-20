//
//  MMScanner.m
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

#import "MMScanner.h"


static NSString *__delimitersForCharacter(unichar character)
{
    switch (character)
    {
        case '[':
        case ']':
            return @"[]";
        case '(':
        case ')':
            return @"()";
        case '<':
        case '>':
            return @"<>";
        case '{':
        case '}':
            return @"{}";
        default:
            [NSException raise:@"Invalid delimiter character"
                        format:@"Character '%C' is not a valid delimiter", character];
            return '\0';
    }
}

@interface MMScanner ()
@property (assign, nonatomic) NSUInteger startLocation;
@property (assign, nonatomic) NSRange    currentRange;

@property (assign, nonatomic, readonly) NSRange currentLineRange;
@property (assign, nonatomic) NSUInteger rangeIndex;
@property (strong, nonatomic, readonly) NSMutableArray *transactions;
@end

@implementation MMScanner

#pragma mark - Public Methods

+ (id)scannerWithString:(NSString *)aString
{
    return [[self.class alloc] initWithString:aString];
}

- (id)initWithString:(NSString *)aString
{
    NSArray *lineRanges = [self _lineRangesForString:aString];
    return [self initWithString:aString lineRanges:lineRanges];
}

+ (id)scannerWithString:(NSString *)aString lineRanges:(NSArray *)theLineRanges
{
    return [[self.class alloc] initWithString:aString lineRanges:theLineRanges];
}

- (id)initWithString:(NSString *)aString lineRanges:(NSArray *)theLineRanges
{
    NSParameterAssert(theLineRanges.count > 0);
    
    self = [super init];
    
    if (self)
    {
        _string     = aString;
        _lineRanges = theLineRanges;
        
        _rangeIndex   = 0;
        _transactions = [NSMutableArray new];
        
        self.startLocation = 0;
        self.currentRange  = self.currentLineRange;
    }
    
    return self;
}

- (void)beginTransaction
{
    NSDictionary *transaction = @{
        @"rangeIndex":      @(self.rangeIndex),
        @"location":        @(self.location),
        @"startLocation":   @(self.startLocation),
    };
    [self.transactions addObject:transaction];
    self.startLocation = self.location;
}

- (void)commitTransaction:(BOOL)shouldSave
{
    if (!self.transactions.count)
        [NSException raise:@"Transaction underflow" format:@"Could not commit transaction because the stack is empty"];
    
    NSDictionary *transaction = [self.transactions lastObject];
    [self.transactions removeLastObject];
    
    self.startLocation = [[transaction objectForKey:@"startLocation"] unsignedIntegerValue];
    if (!shouldSave)
    {
        self.rangeIndex    = [[transaction objectForKey:@"rangeIndex"]    unsignedIntegerValue];
        self.location      = [[transaction objectForKey:@"location"]      unsignedIntegerValue];
    }
}

- (BOOL)atBeginningOfLine
{
    return self.location == self.currentLineRange.location;
}

- (BOOL)atEndOfLine
{
    return self.location == NSMaxRange(self.currentLineRange);
}

- (BOOL)atEndOfString
{
    return self.atEndOfLine && self.rangeIndex == self.lineRanges.count - 1;
}

- (unichar)previousCharacter
{
    if (self.atBeginningOfLine)
        return '\0';
    
    return [self.string characterAtIndex:self.location - 1];
}

- (unichar)nextCharacter
{
    if (self.atEndOfLine)
        return '\n';
    return [self.string characterAtIndex:self.location];
}

- (NSString *)previousWord
{
    return [self previousWordWithCharactersFromSet:NSCharacterSet.alphanumericCharacterSet];
}

- (NSString *)nextWord
{
    return [self nextWordWithCharactersFromSet:NSCharacterSet.alphanumericCharacterSet];
}

- (NSString *)previousWordWithCharactersFromSet:(NSCharacterSet *)set
{
    NSUInteger start = MAX(self.currentLineRange.location, self.startLocation);
    NSUInteger end   = self.currentRange.location;
    NSRange range = NSMakeRange(start, end-start);
    
    NSRange result = [self.string rangeOfCharacterFromSet:set.invertedSet
                                                  options:NSBackwardsSearch
                                                    range:range];
    
    if (result.location == NSNotFound)
        return [self.string substringWithRange:range];
    
    NSUInteger wordLocation = NSMaxRange(result);
    NSRange wordRange = NSMakeRange(wordLocation, end-wordLocation);
    return [self.string substringWithRange:wordRange];
}

- (NSString *)nextWordWithCharactersFromSet:(NSCharacterSet *)set
{
    NSRange result = [self.string rangeOfCharacterFromSet:set.invertedSet
                                                  options:0
                                                    range:self.currentRange];
    
    if (result.location == NSNotFound)
        return [self.string substringWithRange:self.currentRange];
    
    NSRange wordRange = self.currentRange;
    wordRange.length = result.location - wordRange.location;
    
    return [self.string substringWithRange:wordRange];
}

- (void)advance
{
    if (self.atEndOfLine)
        return;
    self.location += 1;
}

- (void)advanceToNextLine
{
    // If at the last line, just go to the end of the line
    if (self.rangeIndex == self.lineRanges.count - 1)
    {
        self.location = NSMaxRange(self.currentLineRange);
    }
    // Otherwise actually go to the next line
    else
    {
        self.rangeIndex += 1;
        self.currentRange = self.currentLineRange;
    }
}

- (BOOL)matchString:(NSString *)string
{
    if (self.currentRange.length < string.length)
        return NO;
    
    NSUInteger location = self.location;
    for (NSUInteger idx=0; idx<string.length; idx++)
    {
        if ([string characterAtIndex:idx] != [self.string characterAtIndex:location+idx])
            return NO;
    }
    
    self.location += string.length;
    return YES;
}

- (NSUInteger)skipCharactersFromSet:(NSCharacterSet *)aSet
{
    NSRange searchRange = self.currentRange;
    NSRange range = [self.string rangeOfCharacterFromSet:[aSet invertedSet]
                                                 options:0
                                                   range:searchRange];
    
    NSUInteger current = self.location;
    
    if (range.location == NSNotFound)
    {
        self.currentRange = NSMakeRange(NSMaxRange(self.currentRange), 0);
    }
    else
    {
        self.currentRange = NSMakeRange(range.location, NSMaxRange(self.currentRange)-range.location);
    }
    
    return self.location - current;
}

- (NSUInteger)skipCharactersFromSet:(NSCharacterSet *)aSet max:(NSUInteger)maxToSkip
{
    NSUInteger idx=0;
    for (; idx<maxToSkip; idx++)
    {
        unichar character = [self nextCharacter];
        if ([aSet characterIsMember:character])
            [self advance];
        else
            break;
    }
    return idx;
}

- (NSUInteger)skipEmptyLines
{
    NSUInteger skipped = 0;
    
    while (![self atEndOfString])
    {
        [self beginTransaction];
        [self skipWhitespace];
        if (!self.atEndOfLine)
        {
            [self commitTransaction:NO];
            break;
        }
        [self commitTransaction:YES];
        [self advanceToNextLine];
        skipped++;
    }
    
    return skipped;
}

- (NSUInteger)skipIndentationUpTo:(NSUInteger)maxSpacesToSkip
{
    NSUInteger skipped = 0;
    [self beginTransaction];
    
    while (!self.atEndOfLine && skipped < maxSpacesToSkip)
    {
        unichar character = self.nextCharacter;
        
        if (character == ' ')
            skipped += 1;
        else if (character == '\t')
        {
            skipped -= skipped % 4;
            skipped += 4;
        }
        else
            break;
        
        [self advance];
    }
    
    [self commitTransaction:skipped <= maxSpacesToSkip];
    return skipped;
}

- (NSUInteger)skipNestedBracketsWithDelimiter:(unichar)delimiter
{
    NSString *delimiters     = __delimitersForCharacter(delimiter);
    unichar   openDelimiter  = [delimiters characterAtIndex:0];
    unichar   closeDelimeter = [delimiters characterAtIndex:1];
    
    if ([self nextCharacter] != openDelimiter)
        return 0;
    
    [self beginTransaction];
    NSUInteger location = self.location;
    [self advance];
    
    NSString       *specialChars = [NSString stringWithFormat:@"%@\\", delimiters];
    NSCharacterSet *boringChars  = [[NSCharacterSet characterSetWithCharactersInString:specialChars] invertedSet];
    NSUInteger      nestingLevel = 1;
    
    while (nestingLevel > 0)
    {
        if (self.atEndOfLine)
        {
            [self commitTransaction:NO];
            return 0;
        }
        
        [self skipCharactersFromSet:boringChars];
        
        unichar nextChar = self.nextCharacter;
        [self advance];
        
        if (nextChar == openDelimiter)
        {
            nestingLevel++;
        }
        else if (nextChar == closeDelimeter)
        {
            nestingLevel--;
        }
        else if (nextChar == '\\')
        {
            // skip a second character after a backslash
            [self advance];
        }
    }
    
    [self commitTransaction:YES];
    return self.location - location;
}

- (NSUInteger)skipToEndOfLine
{
    NSUInteger length = self.currentRange.length;
    self.location = NSMaxRange(self.currentRange);
    return length;
}

- (NSUInteger)skipToLastCharacterOfLine
{
    NSUInteger length = self.currentRange.length - 1;
    self.location = NSMaxRange(self.currentRange) - 1;
    return length;
}

- (NSUInteger)skipWhitespace
{
    return [self skipCharactersFromSet:NSCharacterSet.whitespaceCharacterSet];
}

- (NSUInteger)skipWhitespaceAndNewlines
{
    NSCharacterSet *whitespaceSet = NSCharacterSet.whitespaceCharacterSet;
    NSUInteger      length = 0;
    
    while (!self.atEndOfString)
    {
        if (self.atEndOfLine)
        {
            [self advanceToNextLine];
            length++;
        }
        else
        {
            NSUInteger spaces = [self skipCharactersFromSet:whitespaceSet];
            if (spaces == 0)
                break;
            
            length += spaces;
        }
    }
    
    return length;
}


#pragma mark - Public Properties

- (NSUInteger)location
{
    return self.currentRange.location;
}

- (void)setLocation:(NSUInteger)location
{
    // If the new location isn't a part of the current range, then find the range it belongs to.
    if (!NSLocationInRange(location, self.currentLineRange))
    {
        __block NSUInteger index = 0;
        [self.lineRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            NSRange range = [obj rangeValue];
            *stop = NSLocationInRange(location, range) || location == NSMaxRange(range);
            index = idx;
        }];
        self.rangeIndex = index;
    }
    
    self.currentRange = NSMakeRange(location, NSMaxRange(self.currentLineRange)-location);
}


#pragma mark - Private Methods

- (NSArray *)_lineRangesForString:(NSString *)aString
{
    NSMutableArray *result = [NSMutableArray array];
    
    NSUInteger location = 0;
    NSUInteger idx;
    for (idx=0; idx<aString.length; idx++)
    {
        unichar character = [aString characterAtIndex:idx];
        if (character == '\r' || character == '\n')
        {
            NSRange range = NSMakeRange(location, idx-location);
            [result addObject:[NSValue valueWithRange:range]];
            
            // If it's a carriage return, check for a line feed too
            if (character == '\r')
            {
                if (idx + 1 < aString.length && [aString characterAtIndex:idx + 1] == '\n')
                {
                    idx += 1;
                }
            }
            
            location = idx + 1;
        }
    }
    
    // Add the final line if the string doesn't end with a newline
    if (location < aString.length)
    {
        NSRange range = NSMakeRange(location, aString.length-location);
        [result addObject:[NSValue valueWithRange:range]];
    }
    
    return result;
}

- (NSUInteger)_locationOfCharacter:(unichar)character inRange:(NSRange)range
{
    NSString       *characterString = [NSString stringWithCharacters:&character length:1];
    NSCharacterSet *characterSet    = [NSCharacterSet characterSetWithCharactersInString:characterString];
    NSRange result = [self.string rangeOfCharacterFromSet:characterSet options:0 range:range];
    return result.location;
}

#pragma mark - Private Properties

- (NSRange)currentLineRange
{
    return [self.lineRanges[self.rangeIndex] rangeValue];
}

@end
