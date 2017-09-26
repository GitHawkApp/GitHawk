//
//  MMHTMLTests.m
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


@interface MMHTMLTests : MMTestCase

@end

@implementation MMHTMLTests

#pragma mark - Inline HTML Tests

- (void)testInlineHTML
{
    MMAssertMarkdownEqualsHTML(@"A <i>test</i> with HTML.", @"<p>A <i>test</i> with HTML.</p>");
}

- (void)testInlineHTMLWithUnterminatedQuote
{
    MMAssertMarkdownEqualsString(@"<p style=\"", @"<p>&lt;p style=\"</p>\n");
}

- (void)testInlineHTMLWithSpansInAttribute
{
    MMAssertMarkdownEqualsHTML(@"<a href=\"#\" title=\"*blah*\">foo</a>",
                               @"<p><a href=\"#\" title=\"*blah*\">foo</a></p>");
}

- (void)testInlineHTMLWithSpansInUnquotedAttribute
{
    MMAssertMarkdownEqualsString(@"<a href=\"#\" title=*blah*>foo</a>",
                                 @"<p><a href=\"#\" title=*blah*>foo</a></p>\n");
}

- (void)testInlineHTMLWithEmptyAttribute
{
    MMAssertMarkdownEqualsString(@"<input type=\"checkbox\" name=\"*foo*\" checked />",
                                 @"<p><input type=\"checkbox\" name=\"*foo*\" checked /></p>\n");
    MMAssertMarkdownEqualsString(@"<input type=\"checkbox\" checked name=\"*foo*\"/>",
                                 @"<p><input type=\"checkbox\" checked name=\"*foo*\"/></p>\n");
}

- (void)testInlineHTMLWithSpacesInAttribute
{
    MMAssertMarkdownEqualsHTML(@"<a href  =  \"#\" title = '*blah*'>foo</a>",
                               @"<p><a href  =  \"#\" title = '*blah*'>foo</a></p>");
}

- (void)testInlineHTMLWithNewlineBetweenAttributes
{
    MMAssertMarkdownEqualsHTML(@"<a href=\"#\"\n   title=\"*blah*\">foo</a>",
                               @"<p><a href=\"#\"\n   title=\"*blah*\">foo</a></p>");
}

- (void)testInlineHTMLWithAngleInAttribute
{
    MMAssertMarkdownEqualsHTML(@"<a href=\"#\" title=\">\">foo</a>",
                               @"<p><a href=\"#\" title=\">\">foo</a></p>");
}

- (void)testUnclosedAngleBracket
{
    MMAssertMarkdownEqualsHTML(@"<1", @"<p>&lt;1</p>");
}

- (void)testInlineHTMLWithDataAttributes
{
    NSString* html = @"<a href=\"https://example.com/foo.js\" data-card-width=\"100%\">foo</a>";
    NSString* htmlWithParagraph = [NSString stringWithFormat:@"<p>%@</p>", html];
    MMAssertMarkdownEqualsHTML(html, htmlWithParagraph);
}


#pragma mark - HTML Comment Tests

- (void)testHTMLComment
{
    MMAssertMarkdownEqualsString(@"<!-- **Test** -->", @"<!-- **Test** -->");
    MMAssertMarkdownEqualsString(@"<!-- **Test**\n\n -->", @"<!-- **Test**\n\n -->");
}

- (void)testHTMLCommentAtEndOfParagraph
{
    MMAssertMarkdownEqualsString(@"1 <!-- **A Test**\n\n-->",
                                 @"<p>1 <!-- **A Test**\n\n--></p>\n");
}

- (void)testHTMLCommentInParagraph
{
    MMAssertMarkdownEqualsString(@"A <!-- **A Test** --> B",
                                 @"<p>A <!-- **A Test** --> B</p>\n");
}

- (void)testHTMLCommentAtEndOfListItem
{
    MMAssertMarkdownEqualsString(@"1. <!-- **A Test**\n\n-->",
                                 @"<ol>\n<li><!-- **A Test**\n\n--></li>\n</ol>\n");
}

- (void)testHTMLCommentInListItem
{
    MMAssertMarkdownEqualsString(@"1. A <!-- **A Test** --> B",
                                 @"<ol>\n<li>A <!-- **A Test** --> B</li>\n</ol>\n");
}


#pragma mark - Block HTML Tests

- (void)testBlockHTML_basic
{
    NSString *markdown = @"A paragraph.\n"
                          "\n"
                          "<div>\n"
                          "HTML!\n"
                          "</div>\n"
                          "\n"
                          "Another paragraph.\n";
    NSString *html = @"<p>A paragraph.</p>\n"
                      "\n"
                      "<div>\n"
                      "HTML!\n"
                      "</div>\n"
                      "\n"
                      "<p>Another paragraph.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testBlockHTML_withSingleQuotedAttribute
{
    NSString *markdown = @"A paragraph.\n"
                          "\n"
                          "<div class='foo'>\n"
                          "HTML!\n"
                          "</div>\n"
                          "\n"
                          "Another paragraph.\n";
    NSString *html = @"<p>A paragraph.</p>\n"
                      "\n"
                      "<div class='foo'>\n"
                      "HTML!\n"
                      "</div>\n"
                      "\n"
                      "<p>Another paragraph.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testBlockHTML_withDoubleQuotedAttribute
{
    NSString *markdown = @"A paragraph.\n"
                          "\n"
                          "<div class=\"foo\">\n"
                          "HTML!\n"
                          "</div>\n"
                          "\n"
                          "Another paragraph.\n";
    NSString *html = @"<p>A paragraph.</p>\n"
                      "\n"
                      "<div class=\"foo\">\n"
                      "HTML!\n"
                      "</div>\n"
                      "\n"
                      "<p>Another paragraph.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testBlockHTMLWithInsTag
{
    MMAssertMarkdownEqualsHTML(@"<ins>\nSome text.\n</ins>", @"<ins>\nSome text.\n</ins>");
}

- (void)testBlockHTMLWithDelTag
{
    MMAssertMarkdownEqualsHTML(@"<del>\nSome text.\n</del>", @"<del>\nSome text.\n</del>");
}

- (void)testBlockHTMLOnASingleLine
{
    MMAssertMarkdownEqualsHTML(@"<div>A test.</div>", @"<div>A test.</div>");
}

- (void)testBlockHTMLBlankLineBetweenCloseTags
{
    // Primitive HTML handling might end the HTML block after the first div, since it's a close tag
    // followed by a blank line. But the block should extend to the end of the opening div.
    NSString *html = @"<div>\n"
                      "<div>\n"
                      "A\n"
                      "</div>\n"
                      "\n"
                      "</div>\n";
    MMAssertMarkdownEqualsHTML(html, html);
}

- (void)testBlockHTMLWithUnclosedTag
{
    NSString *markdown = @"<div>\n"
                          "<div>\n"
                          "A\n"
                          "</div>\n"
                          "\n"
                          "div\n";
    NSString *string = @"<div>\n"
                        "<div>\n"
                        "A\n"
                        "</div>\n"
                        "<p>div</p>\n";
    MMAssertMarkdownEqualsString(markdown, string);
}

- (void)testBlockHTMLCommentWithSpans
{
    MMAssertMarkdownEqualsString(@"<!------> *hello*-->", @"<!------><p><em>hello</em>--></p>\n");
}


@end
