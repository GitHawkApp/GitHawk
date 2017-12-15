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


@interface MMListTests : MMTestCase

@end

@implementation MMListTests

#pragma mark - Tests

- (void)testBasicList_bulletedWithStars
{
    NSString *markdown = @"* One\n"
                          "* Two\n"
                          "* Three\n";
    NSString *html = @"<ul><li>One</li><li>Two</li><li>Three</li></ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testBasicList_bulletedWithDashes
{
    NSString *markdown = @"- One\n"
                          "- Two\n"
                          "- Three\n";
    NSString *html = @"<ul><li>One</li><li>Two</li><li>Three</li></ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testBasicList_numbered
{
    NSString *markdown = @"0. One\n"
                          "1. Two\n"
                          "0. Three\n";
    NSString *html = @"<ol><li>One</li><li>Two</li><li>Three</li></ol>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testList_bulletedWithParagraphs
{
    NSString *markdown = @"- One\n"
                          "\n"
                          "- Two\n"
                          "\n"
                          "- Three\n";
    NSString *html = @"<ul><li><p>One</p></li>"
                      "<li><p>Two</p></li>"
                      "<li><p>Three</p></li></ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testList_carriageReturn
{
    MMAssertMarkdownEqualsHTML(@"- One\r- Two\r", @"<ul><li>One</li>\n<li>Two</li></ul>");
}

- (void)testList_carriageReturnLineFeed
{
    MMAssertMarkdownEqualsHTML(@"- One\r\n- Two\r", @"<ul><li>One</li>\n<li>Two</li></ul>");
}

- (void)testList_multipleParagraphs
{
    NSString *markdown = @"- One\n"
                          "\n"
                          "    More\n"
                          "- Two\n"
                          "- Three\n";
    NSString *html = @"<ul><li><p>One</p><p>More</p></li>"
                      "<li>Two</li>"
                      "<li>Three</li></ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testList_multipleParagraphs_blockquote
{
    NSString *markdown = @"* Item\n"
                          "\n"
                          "    > Blockquote";
    NSString *html = @"<ul>\n"
                      "<li><p>Item</p>\n"
                      "\n"
                      "<blockquote>\n"
                      "<p>Blockquote</p>\n"
                      "</blockquote></li>\n"
                      "</ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testList_multipleParagraphs_codeBlock
{
    NSString *markdown = @"* Item\n"
                          "\n"
                          "        Code";
    NSString *html = @"<ul>\n"
                      "<li><p>Item</p>\n"
                      "\n"
                      "<pre><code>Code\n"
                      "</code></pre></li>\n"
                      "</ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testListParagraphs
{
    NSString *markdown = @"* A\n"
                          "* B\n"
                          "\n"
                          "* C\n"
                          "* D\n";
    NSString *html = @"<ul>\n"
                      "<li>A</li>\n"
                      "<li><p>B</p></li>\n"
                      "<li><p>C</p></li>\n"
                      "<li>D</li>\n"
                      "</ul>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testListParagraphsInNestedList
{
    NSString *markdown = @"* A\n"
                          "    - 1\n"
                          "\n"
                          "    - 2\n";
    NSString *html = @"<ul>\n"
                      "<li><p>A</p>\n"
                      "\n"
                      "<ul><li><p>1</p></li>\n"
                      "<li><p>2</p></li></ul></li>\n"
                      "</ul>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testListParagraphsWithNestedList
{
    NSString *markdown = @"* A\n"
                          "    - 1\n"
                          "    - 2\n"
                          "* B\n"
                          "    - 1\n"
                          "    - 2\n"
                          "\n"
                          "    B2\n"
                          "* C\n";
    NSString *html = @"<ul>\n"
                      "<li>A\n"
                      "<ul><li>1</li>\n"
                      "<li>2</li></ul></li>\n"
                      "<li><p>B</p>\n"
                      "\n"
                      "<ul><li>1</li>\n"
                      "<li>2</li></ul>\n"
                      "\n"
                      "<p>B2</p></li>\n"
                      "<li>C</li>\n"
                      "</ul>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testListImmediatelyAfterParagraph
{
    NSString *markdown = @"A\n"
                          " * 1\n"
                          " * 2\n";
    NSString *html = @"<p>A</p>\n"
                      "<ul><li>1</li>\n"
                      "<li>2</li></ul>\n";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testInlineListItems
{
    NSString *markdown = @"* # A\n"
                          "* B\n"
                          "* C\n";
    NSString *html = @"<ul>\n"
                      "<li># A</li>\n"
                      "<li>B</li>\n"
                      "<li>C</li>\n"
                      "</ul>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testList_hangingIndents
{
    NSString *markdown = @"*   Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\n"
                          "Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,\n"
                          "viverra nec, fringilla in, laoreet vitae, risus.\n"
                          "*   Donec sit amet nisl. Aliquam semper ipsum sit amet velit.\n"
                          "Suspendisse id sem consectetuer libero luctus adipiscing.\n";
    NSString *html = @"<ul>\n"
                      "<li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\n"
                      "Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,\n"
                      "viverra nec, fringilla in, laoreet vitae, risus.</li>\n"
                      "<li>Donec sit amet nisl. Aliquam semper ipsum sit amet velit.\n"
                      "Suspendisse id sem consectetuer libero luctus adipiscing.</li>\n"
                      "</ul>\n";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testEmptyList
{
    MMAssertMarkdownEqualsHTML(@"1. ", @"<ol><li></li></ol>");
}

- (void)testNestedLists
{
    NSString *markdown = @"- One\n"
                          "    * A\n"
                          "    * B\n"
                          "- Two\n"
                          "- Three\n";
    NSString *html = @"<ul><li>One\n<ul><li>A</li><li>B</li></ul></li>"
                      "<li>Two</li>"
                      "<li>Three</li></ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testNestedLists_multipleParagraphs
{
    NSString *markdown = @"- One\n"
                          "\n"
                          "- Two\n"
                          "    * A\n"
                          "    * B\n"
                          "\n"
                          "- Three\n";
    NSString *html = @"<ul><li><p>One</p></li>"
                      "<li><p>Two</p><ul><li>A</li><li>B</li></ul></li>"
                      "<li><p>Three</p></li></ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testNestedLists_multipleLevels
{
    NSString *markdown = @"- One\n"
                          "\n"
                          "- Two\n"
                          "    * A\n"
                          "        - I\n"
                          "    * B\n"
                          "\n"
                          "- Three\n";
    NSString *html = @"<ul><li><p>One</p></li>"
                      "<li><p>Two</p><ul><li>A\n<ul><li>I</li></ul></li><li>B</li></ul></li>"
                      "<li><p>Three</p></li></ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testNestedLists_trailingNested
{
    NSString *markdown = @"- One\n"
                          "- Two\n"
                          "    * A\n"
                          "    * B\n"
                          "\n"
                          "New Paragraph\n";
    NSString *html = @"<ul><li>One</li>"
                      "<li>Two\n<ul><li>A</li><li>B</li></ul></li></ul>"
                      "<p>New Paragraph</p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testNestedListWithMultipleEmptyLinesAndBacktracking
{
    // https://github.com/mdiep/MMMarkdown/issues/100
    NSString *markdown =
        @"* A\n"
         "    * B\n"
         "\n"
         "    * C\n"
         "\n"
         "    D\n";
    NSString *html =
        @"<ul>\n"
         "<li>\n"
         "<p>A</p>\n"
         "<ul>\n"
         "<li>\n"
         "<p>B</p>\n"
         "</li>\n"
         "<li>\n"
         "<p>C</p>\n"
         "</li>\n"
         "</ul>\n"
         "<p>D</p>\n"
         "</li>\n"
         "</ul>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testList_followedByHorizontalRule
{
    NSString *markdown = @"* One\n"
                          "* Two\n"
                          "* Three\n"
                          "\n"
                          " * * * ";
    NSString *html = @"<ul><li>One</li>"
                      "<li>Two</li>"
                      "<li>Three</li></ul>"
                      "<hr />";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testList_mustHaveWhitespaceAfterMarker
{
    // First element
    MMAssertMarkdownEqualsHTML(@"*One\n",  @"<p>*One</p>");
    MMAssertMarkdownEqualsHTML(@"-One\n",  @"<p>-One</p>");
    MMAssertMarkdownEqualsHTML(@"+One\n",  @"<p>+One</p>");
    MMAssertMarkdownEqualsHTML(@"1.One\n", @"<p>1.One</p>");
    
    // Second element
    MMAssertMarkdownEqualsHTML(@"* One\n*Two",   @"<ul><li>One\n*Two</li></ul>");
    MMAssertMarkdownEqualsHTML(@"- One\n-Two",   @"<ul><li>One\n-Two</li></ul>");
    MMAssertMarkdownEqualsHTML(@"+ One\n+Two",   @"<ul><li>One\n+Two</li></ul>");
    MMAssertMarkdownEqualsHTML(@"1. One\n1.Two", @"<ol><li>One\n1.Two</li></ol>");

    // Check with tabs
    MMAssertMarkdownEqualsHTML(@"*\tOne\n",  @"<ul><li>One</li></ul>");
    MMAssertMarkdownEqualsHTML(@"-\tOne\n",  @"<ul><li>One</li></ul>");
    MMAssertMarkdownEqualsHTML(@"+\tOne\n",  @"<ul><li>One</li></ul>");
    MMAssertMarkdownEqualsHTML(@"1.\tOne\n", @"<ol><li>One</li></ol>");
}

- (void)testList_withTabs
{
    // Tabs should be converted to spaces
    NSString *markdown = @"* A\tParagraph\n";
    NSString *html = @"<ul>\n"
                      "<li>A Paragraph</li>\n"
                      "</ul>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testList_withLeadingSpace
{
    MMAssertMarkdownEqualsHTML(@" - One\n - Two", @"<ul><li>One</li><li>Two</li></ul>");
}

- (void)testList_withBold
{
    MMAssertMarkdownEqualsHTML(@" - One **Bold**\n - Two", @"<ul><li>One <strong>Bold</strong></li><li>Two</li></ul>");
}

- (void)testList_withCode
{
    MMAssertMarkdownEqualsHTML(@" - One `Code`\n - Two", @"<ul><li>One <code>Code</code></li><li>Two</li></ul>");
}

- (void)testListFollowingAnotherList
{
    NSString *markdown =
        @"- A\n"
         "- B\n"
         "\n"
         "1. 1\n"
         "1. 2\n";
    NSString *HTML =
        @"<ul>\n"
        "<li>A</li>\n"
        "<li>B</li>\n"
        "</ul>\n"
        "<ol>\n"
        "<li>1</li>\n"
        "<li>2</li>\n"
        "</ol>\n";
    MMAssertMarkdownEqualsHTML(markdown, HTML);
}

- (void)testListWith2SpaceIndentation
{
    NSString *markdown =
        @"* 1\n"
         "  * 2\n"
         "* 3\n";
    NSString *HTML =
        @"<ul>\n"
         "<li>1\n"
         "<ul>\n"
         "<li>2</li>\n"
         "</ul>\n"
         "</li>\n"
         "<li>3</li>\n"
         "</ul>\n";
    MMAssertMarkdownEqualsHTML(markdown, HTML);
}

- (void)testAlternateListAndQuoteWithDoubleNewlines
{
    NSString *markdown =
    @"+ abc\n\n"
    @"> 123\n\n"
    @"+ def\n\n"
    @"> 456\n\n";
 
    NSString *HTML =
    @"<ul>\n"
    @"<li>abc</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>123</p>\n"
    @"</blockquote>\n"
    @"<ul>\n"
    @"<li>def</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>456</p>\n"
    @"</blockquote>\n";
    
    MMAssertMarkdownEqualsHTML(markdown, HTML);
}

- (void)testAlternateListAndQuote
{
    NSString *markdown =
    @"+ abc\n"
    @"> 123\n"
    @"+ def\n"
    @"> 456\n";
    
    NSString *HTML =
    @"<ul>\n"
    @"<li>abc</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>123</p>\n"
    @"</blockquote>\n"
    @"<ul>\n"
    @"<li>def</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>456</p>\n"
    @"</blockquote>\n";
    
    MMAssertMarkdownEqualsHTML(markdown, HTML);
}


- (void)testAlternateListAndQuoteWith3SpaceBeforeQuote
{
    NSString *markdown =
    @"+ abc\n"
    @"   > 123\n"
    @"+ def\n"
    @"> 456\n";
    
    NSString *HTML =
    @"<ul>\n"
    @"<li>abc</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>123</p>\n"
    @"</blockquote>\n"
    @"<ul>\n"
    @"<li>def</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>456</p>\n"
    @"</blockquote>\n";
    
    MMAssertMarkdownEqualsHTML(markdown, HTML);
}


- (void)testAlternateListAndQuoteWith4SpaceBeforeQuote
{
    NSString *markdown =
    @"+ abc\n"
    @"    > 123\n"
    @"+ def\n"
    @"> 456\n";
    
    NSString *HTML =
    @"<ul>\n"
    @"<li>abc</li>\n"
    @"</ul>\n"
    @"<pre><code>&gt; 123\n</code></pre>\n"
    @"<ul>\n"
    @"<li>def</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>456</p>\n"
    @"</blockquote>\n";
    
    MMAssertMarkdownEqualsHTML(markdown, HTML);
}


- (void)testAlternateListAndQuoteWith3SpaceBeforeListItem
{
    NSString *markdown =
    @"+ abc\n"
    @"> 123\n"
    @"   + def\n"
    @"> 456\n";
    
    NSString *HTML =
    @"<ul>\n"
    @"<li>abc</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>123</p>\n"
    @"</blockquote>\n"
    @"<ul>\n"
    @"<li>def</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>456</p>\n"
    @"</blockquote>\n";

    MMAssertMarkdownEqualsHTML(markdown, HTML);
}


- (void)testAlternateListAndQuoteWith4SpaceBeforeListItem
{
    NSString *markdown =
    @"+ abc\n"
    @"> 123\n"
    @"    + def\n"
    @"> 456\n";
    
    NSString *HTML =
    @"<ul>\n"
    @"<li>abc</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>123</p>\n"
    @"</blockquote>\n"
    @"<ul>\n"
    @"<li>def</li>\n"
    @"</ul>\n"
    @"<blockquote>\n"
    @"<p>456</p>\n"
    @"</blockquote>\n";
    
    MMAssertMarkdownEqualsHTML(markdown, HTML);
}



@end
