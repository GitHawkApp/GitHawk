//
//  MMListTests.m
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


@interface MMBlockTests : MMTestCase

@end

@implementation MMBlockTests

#pragma mark - Blockquote Tests

- (void)testBasicBlockquote
{
    MMAssertMarkdownEqualsHTML(@"> A quotation.",
                               @"<blockquote>\n  <p>A quotation.</p>\n</blockquote>");
}

- (void)testBlockquoteWithAngleOnOnlyTheFirstLine
{
    MMAssertMarkdownEqualsHTML(@"> A quotation\nthat spans 2 lines.",
                               @"<blockquote>\n  <p>A quotation\nthat spans 2 lines.</p>\n</blockquote>");
}

- (void)testBlockquoteWithMultipleParagraphs
{
    MMAssertMarkdownEqualsHTML(@"> A quotation.\n>\n> A long one.",
                               @"<blockquote>\n  <p>A quotation.</p>\n\n<p>A long one.</p>\n</blockquote>");
}

- (void)testBlockquoteWithOtherElements
{
    NSString *markdown = @"> # A Header\n"
                          "> \n"
                          "> 1. First\n"
                          "> 2. Second\n"
                          "> \n"
                          "> Some code:\n"
                          "> \n"
                          ">     return 1";
    NSString *html = @"<blockquote>\n"
                      "  <h1>A Header</h1>\n"
                      "\n"
                      "<ol>\n"
                      "<li>First</li>\n"
                      "<li>Second</li>\n"
                      "</ol>\n"
                      "\n"
                      "<p>Some code:</p>\n"
                      "\n"
                      "<pre><code>return 1\n"
                      "</code></pre>\n"
                      "</blockquote>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testNestedBlockquote
{
    NSString *markdown = @"> A quotation.\n"
                          "> \n"
                          "> > Inner\n"
                          "> \n"
                          "> A long one.\n";
    NSString *html = @"<blockquote>\n"
                      "<p>A quotation.</p>\n"
                      "\n"
                      "<blockquote>\n"
                      "<p>Inner</p>\n"
                      "</blockquote>\n"
                      "\n"
                      "<p>A long one.</p>\n"
                      "</blockquote>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}


#pragma mark - Code Block Tests

- (void)testCodeBlockWithNoCode
{
    MMAssertMarkdownEqualsHTML(@"    \nfoo\n", @"<p>foo</p>");
}

- (void)testCodeBlocks_blankLinesInBetween
{
    NSString *markdown = @"    Some Code\n"
                          "\n"
                          "    More Code\n";
    NSString *html = @"<pre><code>Some Code\n"
                      "\n"
                      "More Code\n"
                      "</code></pre>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testCodeBlocks_carriageReturn
{
    NSString *markdown = @"    Some Code\r"
                          "\r"
                          "    More Code\r";
    NSString *html = @"<pre><code>Some Code\n"
                      "\n"
                      "More Code\n"
                      "</code></pre>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testCodeBlocks_carriageReturnLineFeed
{
    NSString *markdown = @"    Some Code\r\n"
                          "\r\n"
                          "    More Code\r\n";
    NSString *html = @"<pre><code>Some Code\n"
                      "\n"
                      "More Code\n"
                      "</code></pre>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testCodeBlocks_blankLinesInBetween_betweenParagraphs
{
    NSString *markdown = @"Foo\n"
                          "\n"
                          "    Some\n"
                          "\n"
                          "    Code\n"
                          "\n"
                          "    Here\n"
                          "\n"
                          "Bar\n";
    NSString *html = @"<p>Foo</p>\n"
                      "\n"
                      "<pre><code>Some\n"
                      "\n"
                      "Code\n"
                      "\n"
                      "Here\n"
                      "</code></pre>\n"
                      "\n"
                      "<p>Bar</p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testCodeBlocks_withTabs
{
    // Tabs inside code blocks should be converted to spaces
    NSString *markdown = @"\t+\tSome Code\n";
    NSString *html = @"<pre><code>+   Some Code\n"
                      "</code></pre>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testCodeBlocks_withAmpersand
{
    MMAssertMarkdownEqualsHTML(@"    a&b", @"<pre><code>a&amp;b\n</code></pre>");
}

- (void)testCodeBlocks_withAngleBrackets
{
    MMAssertMarkdownEqualsHTML(@"    <html>", @"<pre><code>&lt;html&gt;\n</code></pre>");
}

- (void)testCodeBlocks_withTrailingSpaces
{
    // Trailing spaces should be removed from the last line in the code block
    MMAssertMarkdownEqualsHTML(@"    A  \n    B  ", @"<pre><code>A  \nB\n</code></pre>");
}

- (void)testCodeBlocks_doNotParseSpansBeforeAmpersand
{
    // Code blocks handle text segments on their own. But there was a bug where the text in a code
    // block would be parsed if the block extended to the end of the document.
    MMAssertMarkdownEqualsHTML(@"    [foo](bar)",
                               @"<pre><code>[foo](bar)\n</code></pre>");
}


#pragma mark - Prefixed Header Tests

- (void)testPrefixedHeaderWithTrailingHashes
{
    MMAssertMarkdownEqualsHTML(@"## A # Header! #####", @"<h2>A # Header!</h2>");
}

- (void)testPrefixedHeaderImmediatelyFollowingParagraph
{
    MMAssertMarkdownEqualsHTML(@"A\n# Example", @"<p>A</p>\n<h1>Example</h1>");
}

- (void)testPrefixedHeaderWithLeadingSpaces
{
    MMAssertMarkdownEqualsHTML(@" #H", @"<p>#H</p>");
}

- (void)testPrefixedHeaderRequiresASpace
{
    MMAssertMarkdownEqualsHTML(@"#H", @"<p>#H</p>");
}


#pragma mark - Underlined Header Tests

- (void)testUnderlinedHeaderWithEqualsSigns
{
    MMAssertMarkdownEqualsHTML(@"Foo\n=",   @"<h1>Foo</h1>");
    MMAssertMarkdownEqualsHTML(@"Foo\n===", @"<h1>Foo</h1>");
}

- (void)testUnderlinedHeaderWithDashes
{
    MMAssertMarkdownEqualsHTML(@"Foo\n-",   @"<h2>Foo</h2>");
    MMAssertMarkdownEqualsHTML(@"Foo\n---", @"<h2>Foo</h2>");
}

- (void)testUnderlinedHeaderInBlockquote
{
    MMAssertMarkdownEqualsHTML(@"> A\n> -", @"<blockquote><h2>A</h2></blockquote>");
}


#pragma mark - Paragraph Tests

- (void)testParagraphs_hangingIndent
{
    // Tabs should be converted to spaces
    NSString *markdown = @"A Paragraph\n    Here\n";
    NSString *html = @"<p>A Paragraph\n"
                      "Here</p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testParagraphs_withTabs
{
    // Tabs should be converted to spaces
    NSString *markdown = @"A\tParagraph\n\tHere\n";
    NSString *html = @"<p>A   Paragraph\n"
                      "Here</p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testParagraphs_blankLineHasSpaces
{
    MMAssertMarkdownEqualsHTML(@"A\n \nB", @"<p>A</p><p>B</p>");
}

- (void)testParapgraphImmediatelyFollowedByBlockquote
{
    NSString *html = @"<p>A</p>\n"
                      "\n"
                      "<blockquote>\n"
                      "<p>B</p>\n"
                      "</blockquote>";
    MMAssertMarkdownEqualsHTML(@"A\n> B", html);
}

- (void)testParagraphWithLeadingSpaces
{
    MMAssertMarkdownEqualsHTML(@"   A", @"<p>A</p>");
}


@end
