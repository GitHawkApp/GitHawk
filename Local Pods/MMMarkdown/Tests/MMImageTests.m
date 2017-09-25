//
//  MMImageTests.m
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


@interface MMImageTests : MMTestCase

@end 

@implementation MMImageTests

#pragma mark - Inline Image Tests

- (void)testBasicInlineImage
{
    MMAssertMarkdownEqualsHTML(@"![Alt text](/image.jpg)", @"<p><img src=\"/image.jpg\" alt=\"Alt text\" /></p>");
}

- (void)testInlineImageWithTitle
{
    MMAssertMarkdownEqualsHTML(@"![Alt text](/image.jpg \"Title Here\")",
                               @"<p><img src=\"/image.jpg\" alt=\"Alt text\" title=\"Title Here\" /></p>");
}

- (void)testInlineImageWithNoAltText
{
    MMAssertMarkdownEqualsHTML(
        @"![](http://cl.ly/image/3I340R25053q/content)",
        @"<p><img src='http://cl.ly/image/3I340R25053q/content' alt='' /></p>"
    );
}


#pragma mark - Reference Image Tests

- (void)testBasicReferenceImage
{
    MMAssertMarkdownEqualsHTML(@"![Description][1]\n\n[1]: /image.jpg",
                               @"<p><img src=\"/image.jpg\" alt=\"Description\" /></p>");
}

- (void)testReferenceImageWithImplicitName
{
    MMAssertMarkdownEqualsHTML(@"![Description][]\n\n[description]: /image.jpg",
                               @"<p><img src=\"/image.jpg\" alt=\"Description\" /></p>");
}

- (void)testReferenceImageWithTitle
{
    MMAssertMarkdownEqualsHTML(@"![Description][1]\n\n[1]: /image.jpg \"A Title\"",
                               @"<p><img src=\"/image.jpg\" alt=\"Description\" title=\"A Title\" /></p>");
}

- (void)testReferenceImageWithNoBlankLine
{
    MMAssertMarkdownEqualsHTML(
        @"![Logo][logo]\n[logo]: http://cl.ly/image/3Y013H0A2z3z/gundam-ruby.png",
        @"<p><img src=\"http://cl.ly/image/3Y013H0A2z3z/gundam-ruby.png\" alt=\"Logo\" /></p>"
    );
}


@end
