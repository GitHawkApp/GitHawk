//
//  MMEscapingTests.m
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

#import "MMTestCase.h"


@interface MMEscapingTests : MMTestCase

@end

@implementation MMEscapingTests

#pragma mark - Backslash Escape Tests

- (void)testBackslashEscapes
{
    // double-escape everything
    NSString *markdown = @"\\\\ \\` \\* \\_ \\{ \\} \\[ \\] \\( \\) \\> \\# \\. \\! \\+ \\-";
    NSString *html = @"<p>\\ ` * _ { } [ ] ( ) > # . ! + -</p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testNotBackslashEscapes
{
    // These may look like backslash escapes, but markdown doesn't recognize them. Treat them as
    // normal sequences of characters.
    NSString *markdown = @"\\\" \\e \\g";
    NSString *html     = @"<p>\\\" \\e \\g</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testEscapedParensInInlineLink
{
    MMAssertMarkdownEqualsHTML(@"[link](/url\\))",  @"<p><a href=\"/url)\">link</a></p>");
    MMAssertMarkdownEqualsHTML(@"[link](/url\\())", @"<p><a href=\"/url(\">link</a>)</p>");
}


#pragma mark - Encoded Entity Tests

- (void)testEncodeAmpersand
{
    MMAssertMarkdownEqualsHTML(@"A & B", @"<p>A &amp; B</p>");
}

- (void)testEncodeLeftAngleBracket
{
    MMAssertMarkdownEqualsHTML(@"2 << 0 < 2 << 1", @"<p>2 &lt;&lt; 0 &lt; 2 &lt;&lt; 1</p>");
}

- (void)testHTMLEntityReferences
{
    MMAssertMarkdownEqualsHTML(@"A &amp; B", @"<p>A &amp; B</p>");
    MMAssertMarkdownEqualsHTML(@"A &#38; B", @"<p>A &#38; B</p>");
}


@end
