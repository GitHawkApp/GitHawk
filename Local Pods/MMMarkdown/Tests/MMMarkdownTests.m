//
//  MMMarkdownTests.m
//  MMMarkdownTests
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

#import "MMMarkdownTests.h"


#import "MMMarkdown.h"

@implementation MMMarkdownTests

#pragma mark - Helpers

- (void)runTestWithName:(NSString *)aName
{
    [self runTestWithName:aName inDirectory:@"MarkdownTest_1.0"];
}


#pragma mark - Test Cases

- (void)testAmpsAndAngleEncoding
{
    [self runTestWithName:@"Amps and angle encoding"];
}

- (void)testAutoLinks
{
    [self runTestWithName:@"Auto links"];
}

- (void)testBackslashEscapes
{
    [self runTestWithName:@"Backslash escapes"];
}

- (void)testBlockquotesWithCodeBlocks
{
    [self runTestWithName:@"Blockquotes with code blocks"];
}

#if 0
/*
 This tests that a * won't start a list item on the line after a paragraph. But
 GitHub and CommonMark both treat this as a list item.
 */
- (void)testHardWrappedParagraphsWithListLikeLines
{
    [self runTestWithName:@"Hard-wrapped paragraphs with list-like lines"];
}
#endif

- (void)testHorizontalRules
{
    [self runTestWithName:@"Horizontal rules"];
}

- (void)testInlineHTMLAdvanced
{
    [self runTestWithName:@"Inline HTML (Advanced)"];
}

#if 0
/*
 * This isn't valid XML, so we can't compare it.
 */
- (void)testInlineHTMLSimple
{
    [self runTestWithName:@"Inline HTML (Simple)"];
}
#endif

#if 0
/*
 * XML comments can't contain `--`, so there's not a good way to do this comparison.
 */
- (void)testInlineHTMLComments
{
    [self runTestWithName:@"Inline HTML comments"];
}
#endif

- (void)testLinksInlineStyle
{
    [self runTestWithName:@"Links, inline style"];
}

- (void)testLinksReferenceStyle
{
    [self runTestWithName:@"Links, reference style"];
}

- (void)testLiteralQuotesInTitles
{
    [self runTestWithName:@"Literal quotes in titles"];
}

- (void)testMarkdownDocumentationBasics
{
    [self runTestWithName:@"Markdown Documentation - Basics"];
}

// This test has superficial differences, even though (a) it should render the same and (b) we're
// very close to CommonMark's output.
#if 0
- (void)testMarkdownDocumentationSyntax
{
    [self runTestWithName:@"Markdown Documentation - Syntax"];
}
#endif

- (void)testNestedBlockquotes
{
    [self runTestWithName:@"Nested blockquotes"];
}

- (void)testOrderedAndUnorderedLists
{
    [self runTestWithName:@"Ordered and unordered lists"];
}

- (void)testStrongAndEmTogether
{
    [self runTestWithName:@"Strong and em together"];
}

- (void)testTabs
{
    [self runTestWithName:@"Tabs"];
}

- (void)testTidyness
{
    [self runTestWithName:@"Tidyness"];
}


@end
