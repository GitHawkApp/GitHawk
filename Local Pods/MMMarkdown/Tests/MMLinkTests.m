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


@interface MMLinkTests : MMTestCase

@end 

@implementation MMLinkTests

#pragma mark - Automatic Link Tests

- (void)testBasicAutomaticLink
{
    NSString *markdown = @"<http://daringfireball.net>";
    NSString *html = @"<p><a href='http://daringfireball.net'>http://daringfireball.net</a></p>";
    
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testAutomaticLinkWithAmpersand
{
    MMAssertMarkdownEqualsHTML(@"<http://example.com/?a=1&b=1>",
                               @"<p><a href=\"http://example.com/?a=1&amp;b=1\">http://example.com/?a=1&amp;b=1</a></p>");
}

- (void)testNotAnActualAutomaticLink
{
    // Use a string comparison for this test because the output is not valid XML
    NSString *markdown  = @"A <i> test with no HTML.";
    NSString *generated = [MMMarkdown HTMLStringWithMarkdown:markdown error:nil];
    NSString *expected  = @"<p>A <i> test with no HTML.</p>\n";
    XCTAssertEqualObjects(generated, expected, @"HTML didn't match expected value");
}

- (void)testAutomaticEmailLink
{
    // The Markdown documentation says that automatic email links like this should have "randomized
    // decimal and hex entity-encoding to help obscure your address from address-harvesting
    // spambots". So test this the hard way: (1) unescape the output to test against the expected
    // value and (2) make sure that the output doesn't match the expected value if it hasn't been
    // unescaped.
    NSString *markdown  = @"<address@example.com>";
    NSString *generated = [MMMarkdown HTMLStringWithMarkdown:markdown error:nil];
    NSString *unescaped = (__bridge_transfer NSString *)CFXMLCreateStringByUnescapingEntities(NULL, (__bridge CFStringRef)generated, NULL);
    NSString *expected  = @"<p><a href=\"mailto:address@example.com\">address@example.com</a></p>\n";
    XCTAssertEqualObjects(unescaped, expected, @"Unescaped output doesn't match expected");
    XCTAssertFalse([expected isEqualToString:generated], @"Generated output should be escaped");
}

- (void)testAutomaticEmailLink_withAnInternationalDomain
{
    // The Markdown documentation says that automatic email links like this should have "randomized
    // decimal and hex entity-encoding to help obscure your address from address-harvesting
    // spambots". So test this the hard way: (1) unescape the output to test against the expected
    // value and (2) make sure that the output doesn't match the expected value if it hasn't been
    // unescaped.
    NSString *markdown  = @"<hélp@tūdaliņ.làv>";
    NSString *generated = [MMMarkdown HTMLStringWithMarkdown:markdown error:nil];
    NSString *unescaped = (__bridge_transfer NSString *)CFXMLCreateStringByUnescapingEntities(NULL, (__bridge CFStringRef)generated, NULL);
    NSString *expected  = @"<p><a href=\"mailto:hélp@tūdaliņ.làv\">hélp@tūdaliņ.làv</a></p>\n";
    XCTAssertEqualObjects(unescaped, expected, @"Unescaped output doesn't match expected");
    XCTAssertFalse([expected isEqualToString:generated], @"Generated output should be escaped");
}


#pragma mark - Inline Link Tests

- (void)testBasicInlineLink
{
    MMAssertMarkdownEqualsHTML(@"[URL](/url/)", @"<p><a href=\"/url/\">URL</a></p>");
}

- (void)testInlineLinkWithEmptyContent
{
    MMAssertMarkdownEqualsHTML(@"[](/url)", @"<p><a href=\"/url\"></a></p>");
}

- (void)testInlineLinkWithSpans
{
    MMAssertMarkdownEqualsHTML(@"[***A Title***](/the-url/)", @"<p><a href=\"/the-url/\"><strong><em>A Title</em></strong></a></p>");
}

- (void)testInlineLinkWithEscapedBracket
{
    MMAssertMarkdownEqualsHTML(@"[\\]](/)", @"<p><a href=\"/\">]</a></p>");
}

- (void)testInlineLinkWithNestedBrackets
{
    MMAssertMarkdownEqualsHTML(@"[ A [ title ] ](/foo)", @"<p><a href=\"/foo\"> A [ title ] </a></p>");
}

- (void)testInlineLinkWithNestedParentheses
{
    MMAssertMarkdownEqualsHTML(@"[Apple](http://en.wikipedia.org/wiki/Apple_(disambiguation))",
                               @"<p><a href=\"http://en.wikipedia.org/wiki/Apple_(disambiguation)\">Apple</a></p>");
}

- (void)testInlineLinkWithURLInAngleBrackets
{
    MMAssertMarkdownEqualsHTML(@"[Foo](<bar>)", @"<p><a href=\"bar\">Foo</a></p>");
}

- (void)testInlineLinkWithTitle
{
    MMAssertMarkdownEqualsHTML(@"[URL](/url \"title\")",
                               @"<p><a href=\"/url\" title=\"title\">URL</a></p>");
}

- (void)testInlineLinkWithQuoteInTitle
{
    MMAssertMarkdownEqualsHTML(@"[Foo](/bar \"a \" in the title\")",
                               @"<p><a href=\"/bar\" title=\"a &quot; in the title\">Foo</a></p>");
}

- (void)testInlineLinkWithAmpersandInTitle
{
    MMAssertMarkdownEqualsHTML(@"[Foo](bar \"&baz\")", @"<p><a href=\"bar\" title=\"&amp;baz\">Foo</a></p>");
}

- (void)testInlineLinkWithInlineLinkInside
{
    MMAssertMarkdownEqualsHTML(@"[ [URL](/blah) ](/url)",
                               @"<p><a href=\"/url\"> [URL](/blah) </a></p>");
}

- (void)testInlineLinkWithNoHref
{
    MMAssertMarkdownEqualsHTML(@"[foo]()", @"<p><a href=\"\">foo</a></p>");
}

- (void)testInlineLinkWithNewlineInText
{
    MMAssertMarkdownEqualsHTML(@"[A\nlink](/foo)", @"<p><a href=\"/foo\">A\nlink</a></p>");
}

- (void)testInlineLinkWithNewlineInText_carriageReturn
{
    MMAssertMarkdownEqualsHTML(@"[A\rlink](/foo)", @"<p><a href=\"/foo\">A\nlink</a></p>");
}

- (void)testInlineLinkWithNewlineInText_carriageReturnLineFeed
{
    MMAssertMarkdownEqualsHTML(@"[A\r\nlink](/foo)", @"<p><a href=\"/foo\">A\nlink</a></p>");
}

- (void)testNotAnInlineLink_loneBracket
{
    MMAssertMarkdownEqualsHTML(@"An empty [ by itself", @"<p>An empty [ by itself</p>");
}

- (void)testInlineLinkWithImage
{
    MMAssertMarkdownEqualsHTML(
        @"[![Image](http://example.com/image.jpg)](http://www.example.com)",
        @"<p><a href=\"http://www.example.com\"><img src=\"http://example.com/image.jpg\" alt=\"Image\" /></a></p>"
    );
}

- (void)testInlineLinkWithPadding
{
    MMAssertMarkdownEqualsHTML(@"[test]( http://www.test.com )", @"<p><a href=\"http://www.test.com\">test</a></p>");
}

- (void)testInlineLinkInsideBrackets
{
    MMAssertMarkdownEqualsHTML(@"[[test](http://www.test.com)]", @"<p>[<a href=\"http://www.test.com\">test</a>]</p>");
}


#pragma mark - Reference Link Tests

- (void)testBasicReferenceLink
{
    NSString *markdown = @"Foo [bar][1].\n"
                          "\n"
                          "[1]: /blah";
    NSString *html = @"<p>Foo <a href=\"/blah\">bar</a>.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithOneSpace
{
    NSString *markdown = @"Foo [bar] [1].\n"
                          "\n"
                          "[1]: /blah";
    NSString *html = @"<p>Foo <a href=\"/blah\">bar</a>.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithNewline
{
    NSString *markdown = @"[Foo]\n"
                          "[bar]\n"
                          "\n"
                          "[bar]: /blah";
    NSString *html = @"<p><a href=\"/blah\">Foo</a></p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithDifferentCapitalization
{
    NSString *markdown = @"[Foo][BaR]\n"
                          "\n"
                          "[bAr]: /blah";
    NSString *html = @"<p><a href=\"/blah\">Foo</a></p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithAngleBrackets
{
    NSString *markdown = @"[Apple][].\n"
                          "\n"
                          "[apple]: <http://apple.com> \"Apple Inc\"";
    NSString *html = @"<p><a href=\"http://apple.com\" title=\"Apple Inc\">Apple</a>.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithTitle
{
    NSString *markdown = @"Foo [bar][1].\n"
                          "\n"
                          "[1]: /blah \"blah\"";
    NSString *html = @"<p>Foo <a href=\"/blah\" title=\"blah\">bar</a>.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithTitleOnNextLine
{
    NSString *markdown = @"[Apple][].\n"
                          "\n"
                          "[apple]: <http://apple.com>\n"
                          "         \"Apple Inc\"";
    NSString *html = @"<p><a href=\"http://apple.com\" title=\"Apple Inc\">Apple</a>.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithQuoteInTitle
{
    NSString *markdown = @"[Foo][]\n"
                          "\n"
                          "[foo]: /bar \"a \" in the title\"";
    NSString *html = @"<p><a href=\"/bar\" title=\"a &quot; in the title\">Foo</a></p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithTitleInSingleQuotes
{
    NSString *markdown = @"[Apple][].\n"
                          "\n"
                          "[apple]: http://apple.com 'Apple Inc'";
    NSString *html = @"<p><a href=\"http://apple.com\" title=\"Apple Inc\">Apple</a>.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithTitleInParentheses
{
    NSString *markdown = @"[Apple][].\n"
                          "\n"
                          "[apple]: http://apple.com (Apple Inc)";
    NSString *html = @"<p><a href=\"http://apple.com\" title=\"Apple Inc\">Apple</a>.</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithNewlineInText
{
    NSString *markdown = @"[A\n"
                          "link][1]\n"
                          "\n"
                          "[1]: /foo";
    NSString *html = @"<p><a href=\"/foo\">A\n"
                      "link</a></p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithImplicitIDAndNewlineInText
{
    NSString *markdown = @"[A\n"
                          "link][]\n"
                          "\n"
                          "[a link]: /foo";
    NSString *html = @"<p><a href=\"/foo\">A\n"
                      "link</a></p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithNewlineInID
{
    NSString *markdown = @"[A link][foo\n"
                          "bar]\n"
                          "\n"
                          "[foo bar]: /foo";
    NSString *html = @"<p><a href=\"/foo\">A link</a></p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testReferenceLinkWithNoReference
{
    MMAssertMarkdownEqualsHTML(@"[Foo][bar]", @"<p>[Foo][bar]</p>");
}

- (void)testLinkRecognitionWithAtSymbol
{
    // Use a string comparison for this test because the output is not valid XML
    NSString *markdown  = @"Have you seen this medium link? https://medium.com/@philipla/the-two-types-of-product-virality-8ae744b1c4d7 It's Great";
    NSString *generated = [MMMarkdown HTMLStringWithMarkdown:markdown extensions:MMMarkdownExtensionsAutolinkedURLs error:nil];
    NSString *expected  =  @"<p>Have you seen this medium link? <a href=\"https://medium.com/@philipla/the-two-types-of-product-virality-8ae744b1c4d7\">https://medium.com/@philipla/the-two-types-of-product-virality-8ae744b1c4d7</a> It's Great</p>\n";
    XCTAssertEqualObjects(generated, expected, @"HTML didn't match expected value");
}


@end
