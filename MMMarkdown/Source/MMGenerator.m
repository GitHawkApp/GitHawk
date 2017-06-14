//
//  MMGenerator.m
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

#import "MMGenerator.h"


#import "MMDocument.h"
#import "MMElement.h"

// This value is used to estimate the length of the HTML output. The length of the markdown document
// is multplied by it to create an NSMutableString with an initial capacity.
static const Float64 kHTMLDocumentLengthMultiplier = 1.25;

static NSString * __HTMLEscapedString(NSString *aString)
{
    NSMutableString *result = [aString mutableCopy];
    
    [result replaceOccurrencesOfString:@"&"
                            withString:@"&amp;"
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, result.length)];
    [result replaceOccurrencesOfString:@"\""
                            withString:@"&quot;"
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, result.length)];
    
    return result;
}

static NSString *__obfuscatedEmailAddress(NSString *anAddress)
{
    NSMutableString *result = [NSMutableString new];
    
    NSString *(^decimal)(unichar c) = ^(unichar c){ return [NSString stringWithFormat:@"&#%d;", c];  };
    NSString *(^hex)(unichar c)     = ^(unichar c){ return [NSString stringWithFormat:@"&#x%x;", c]; };
    NSString *(^raw)(unichar c)     = ^(unichar c){ return [NSString stringWithCharacters:&c length:1]; };
    NSArray *encoders = @[ decimal, hex, raw ];
    
    for (NSUInteger idx=0; idx<anAddress.length; idx++)
    {
        unichar character = [anAddress characterAtIndex:idx];
        NSString *(^encoder)(unichar c);
        if (character == '@')
        {
            // Make sure that the @ gets encoded
            encoder = [encoders objectAtIndex:arc4random_uniform(2)];
        }
        else
        {
            int r = arc4random_uniform(100);
            encoder = encoders[(r >= 90) ? 2 : (r >= 45) ? 1 : 0];
        }
        [result appendString:encoder(character)];
    }
    
    return result;
}

static NSString * __HTMLStartTagForElement(MMElement *anElement)
{
    switch (anElement.type)
    {
        case MMElementTypeHeader:
            return [NSString stringWithFormat:@"<h%u>", (unsigned int)anElement.level];
        case MMElementTypeParagraph:
            return @"<p>";
        case MMElementTypeBulletedList:
            return @"<ul>\n";
        case MMElementTypeNumberedList:
            return @"<ol>\n";
        case MMElementTypeListItem:
            return @"<li>";
        case MMElementTypeBlockquote:
            return @"<blockquote>\n";
        case MMElementTypeCodeBlock:
          return anElement.language ? [NSString stringWithFormat:@"<pre><code class=\"%@\">", anElement.language] : @"<pre><code>";
        case MMElementTypeLineBreak:
            return @"<br />";
        case MMElementTypeHorizontalRule:
            return @"\n<hr />\n";
        case MMElementTypeStrikethrough:
            return @"<del>";
        case MMElementTypeStrong:
            return @"<strong>";
        case MMElementTypeEm:
            return @"<em>";
        case MMElementTypeCodeSpan:
            return @"<code>";
        case MMElementTypeImage:
            if (anElement.title != nil)
            {
                return [NSString stringWithFormat:@"<img src=\"%@\" alt=\"%@\" title=\"%@\" />",
                        __HTMLEscapedString(anElement.href),
                        __HTMLEscapedString(anElement.stringValue),
                        __HTMLEscapedString(anElement.title)];
            }
            return [NSString stringWithFormat:@"<img src=\"%@\" alt=\"%@\" />",
                    __HTMLEscapedString(anElement.href),
                    __HTMLEscapedString(anElement.stringValue)];
        case MMElementTypeLink:
            if (anElement.title != nil)
            {
                return [NSString stringWithFormat:@"<a title=\"%@\" href=\"%@\">",
                        __HTMLEscapedString(anElement.title), __HTMLEscapedString(anElement.href)];
            }
            return [NSString stringWithFormat:@"<a href=\"%@\">", __HTMLEscapedString(anElement.href)];
        case MMElementTypeMailTo:
            return [NSString stringWithFormat:@"<a href=\"%@\">%@</a>",
                    __obfuscatedEmailAddress([NSString stringWithFormat:@"mailto:%@", anElement.href]),
                    __obfuscatedEmailAddress(anElement.href)];
        case MMElementTypeEntity:
            return anElement.stringValue;
        case MMElementTypeTable:
            return @"<table>";
        case MMElementTypeTableHeader:
            return @"<thead><tr>";
        case MMElementTypeTableHeaderCell:
            return anElement.alignment == MMTableCellAlignmentCenter ? @"<th align='center'>"
                 : anElement.alignment == MMTableCellAlignmentLeft   ? @"<th align='left'>"
                 : anElement.alignment == MMTableCellAlignmentRight  ? @"<th align='right'>"
                 : @"<th>";
        case MMElementTypeTableRow:
            return @"<tr>";
        case MMElementTypeTableRowCell:
            return anElement.alignment == MMTableCellAlignmentCenter ? @"<td align='center'>"
                 : anElement.alignment == MMTableCellAlignmentLeft   ? @"<td align='left'>"
                 : anElement.alignment == MMTableCellAlignmentRight  ? @"<td align='right'>"
                 : @"<td>";
        default:
            return nil;
    }
}

static NSString * __HTMLEndTagForElement(MMElement *anElement)
{
    switch (anElement.type)
    {
        case MMElementTypeHeader:
            return [NSString stringWithFormat:@"</h%u>\n", (unsigned int)anElement.level];
        case MMElementTypeParagraph:
            return @"</p>\n";
        case MMElementTypeBulletedList:
            return @"</ul>\n";
        case MMElementTypeNumberedList:
            return @"</ol>\n";
        case MMElementTypeListItem:
            return @"</li>\n";
        case MMElementTypeBlockquote:
            return @"</blockquote>\n";
        case MMElementTypeCodeBlock:
            return @"</code></pre>\n";
        case MMElementTypeStrikethrough:
            return @"</del>";
        case MMElementTypeStrong:
            return @"</strong>";
        case MMElementTypeEm:
            return @"</em>";
        case MMElementTypeCodeSpan:
            return @"</code>";
        case MMElementTypeLink:
            return @"</a>";
        case MMElementTypeTable:
            return @"</tbody></table>";
        case MMElementTypeTableHeader:
            return @"</tr></thead><tbody>";
        case MMElementTypeTableHeaderCell:
            return @"</th>";
        case MMElementTypeTableRow:
            return @"</tr>";
        case MMElementTypeTableRowCell:
            return @"</td>";
        default:
            return nil;
    }
}

@interface MMGenerator ()
- (void) _generateHTMLForElement:(MMElement *)anElement
                      inDocument:(MMDocument *)aDocument
                            HTML:(NSMutableString *)theHTML
                        location:(NSUInteger *)aLocation;
@end

@implementation MMGenerator

#pragma mark - Public Methods

- (NSString *)generateHTML:(MMDocument *)aDocument
{
    NSString   *markdown = aDocument.markdown;
    NSUInteger  location = 0;
    NSUInteger  length   = markdown.length;
    
    NSMutableString *HTML = [NSMutableString stringWithCapacity:length * kHTMLDocumentLengthMultiplier];
    
    for (MMElement *element in aDocument.elements)
    {
        if (element.type == MMElementTypeHTML)
        {
            [HTML appendString:[aDocument.markdown substringWithRange:element.range]];
        }
        else
        {
            [self _generateHTMLForElement:element
                               inDocument:aDocument
                                 HTML:HTML
                             location:&location];
        }
    }
    
    return HTML;
}


#pragma mark - Private Methods

- (void)_generateHTMLForElement:(MMElement *)anElement
                     inDocument:(MMDocument *)aDocument
                           HTML:(NSMutableString *)theHTML
                       location:(NSUInteger *)aLocation
{
    NSString *startTag = __HTMLStartTagForElement(anElement);
    NSString *endTag   = __HTMLEndTagForElement(anElement);
    
    if (startTag)
        [theHTML appendString:startTag];
    
    for (MMElement *child in anElement.children)
    {
        if (child.type == MMElementTypeNone)
        {
            NSString *markdown = aDocument.markdown;
            if (child.range.length == 0)
            {
                [theHTML appendString:@"\n"];
            }
            else
            {
                [theHTML appendString:[markdown substringWithRange:child.range]];
            }
        }
        else if (child.type == MMElementTypeHTML)
        {
            [theHTML appendString:[aDocument.markdown substringWithRange:child.range]];
        }
        else
        {
            [self _generateHTMLForElement:child
                               inDocument:aDocument
                                     HTML:theHTML
                                 location:aLocation];
        }
    }
    
    if (endTag)
        [theHTML appendString:endTag];
}


@end
