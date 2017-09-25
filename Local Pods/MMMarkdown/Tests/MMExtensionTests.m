//
//  MMExtensionTests.m
//  MMMarkdown
//
//  Copyright (c) 2013 Matt Diephouse.
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


#define MMAssertExtendedMarkdownEqualsHTML(_extensions, markdown, html) \
    do { \
        id a1value = (markdown); \
        id a2value = (html); \
        \
        NSError *error; \
        NSString *output = [MMMarkdown HTMLStringWithMarkdown:a1value extensions:(_extensions) error:&error]; \
        NSString *html2  = a2value;\
        \
        /* Add root elements for parsing */ \
        output = [NSString stringWithFormat:@"<test>%@</test>", output]; \
        html2  = [NSString stringWithFormat:@"<test>%@</test>", html2]; \
        \
        NSXMLDocument *actual   = [[NSXMLDocument alloc] initWithXMLString:output options:0 error:nil]; \
        NSXMLDocument *expected = [[NSXMLDocument alloc] initWithXMLString:html2  options:0 error:nil]; \
        XCTAssertEqualObjects(actual, expected); \
    } while(0)

@interface MMGitHubTests : MMTestCase

@end

@implementation MMGitHubTests

#pragma mark - MMMarkdownExtensionsUnderscoresInWords

- (void)testMultipleUnderscoresInWords
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"perform_complicated_task perform__complicated__task",
        @"<p>perform_complicated_task perform__complicated__task</p>"
    );
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"do_this_and_do_that_and_another_thing do__this__and__do__that__and__another__thing",
        @"<p>do_this_and_do_that_and_another_thing do__this__and__do__that__and__another__thing</p>"
    );
}

- (void)testUnderscoresAtBeginningOfString
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"_test_",
        @"<p><em>test</em></p>"
    );
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"__test__",
        @"<p><strong>test</strong></p>"
    );
}

- (void)testUnderscoresEndsInWord
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"_test_of",
        @"<p>_test_of</p>"
    );
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"__test__of",
        @"<p>__test__of</p>"
    );
}

- (void)testUnderscoresInTheWord
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"_a_test_",
        @"<p><em>a_test</em></p>"
    );
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"__a__test__",
        @"<p><strong>a__test</strong></p>"
    );
}

- (void)testEmNextToPunctuation
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"Well that's true--_except_ you're a liar!",
        @"<p>Well that's true--<em>except</em> you're a liar!</p>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"This is an interesting set (_i.e._ it's very expensive!).",
        @"<p>This is an interesting set (<em>i.e.</em> it's very expensive!).</p>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"(_How does it work?!_)",
        @"<p>(<em>How does it work?!</em>)</p>"
    );
}

- (void)testStrongNextToPunctuation
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"Well that's true--__except__ you're a liar!",
        @"<p>Well that's true--<strong>except</strong> you're a liar!</p>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"This is an interesting set (__i.e.__ it's very expensive!).",
        @"<p>This is an interesting set (<strong>i.e.</strong> it's very expensive!).</p>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"(__How does it work?!__)",
        @"<p>(<strong>How does it work?!</strong>)</p>"
    );
}

- (void)testStrongEm
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"___test___",
        @"<p><strong><em>test</em></strong></p>"
    );
}

- (void)testEmInsideStrong
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"___test_ test__",
        @"<p><strong><em>test</em> test</strong></p>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"__test _test___",
        @"<p><strong>test <em>test</em></strong></p>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"___test_ _test_ _test___",
        @"<p><strong><em>test</em> <em>test</em> <em>test</em></strong></p>"
    );
}

- (void)testStrongInsideEm
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"___test__ test_",
        @"<p><em><strong>test</strong> test</em></p>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"_test __test___",
        @"<p><em>test <strong>test</strong></em></p>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"___test__ __test__ __test___",
        @"<p><em><strong>test</strong> <strong>test</strong> <strong>test</strong></em></p>"
    );
}

- (void)testAsterisksInsideWord
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsUnderscoresInWords,
        @"t*es*t",
        @"<p>t<em>es</em>t</p>"
    );
}


#pragma mark - MMMarkdownExtensionsAutolinkedURLs

- (void)testURLAutolinkingWithStandardMarkdown
{
    MMAssertMarkdownEqualsHTML(@"https://github.com", @"<p>https://github.com</p>");
}

- (void)testURLAutolinkingInsideLink
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"[https://github.com](https://github.com)",
        @"<p><a href='https://github.com'>https://github.com</a></p>"
    );
}

- (void)testURLAutolinkingWithHTTPS
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"Check out https://github.com/mdiep.",
        @"<p>Check out <a href='https://github.com/mdiep'>https://github.com/mdiep</a>.</p>"
    );
}

- (void)testURLAutolinkingWithHTTP
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"Go to http://github.com and sign up!",
        @"<p>Go to <a href='http://github.com'>http://github.com</a> and sign up!</p>"
    );
}

- (void)testURLAutolinkingWithFTP
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"Download ftp://example.com/blah.txt.",
        @"<p>Download <a href='ftp://example.com/blah.txt'>ftp://example.com/blah.txt</a>.</p>"
    );
}

- (void)testURLAutolinkingWithEmailAddress
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"Email me at matt@diephouse.com.",
        @"<p>Email me at <a href='mailto:matt@diephouse.com'>matt@diephouse.com</a>.</p>"
    );
}

- (void)testURLAutolinkingWithEmailAddressStartingWithUnderscore
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs|MMMarkdownExtensionsUnderscoresInWords,
        @"_blah_blah@blah.com",
        @"<p><a href='mailto:_blah_blah@blah.com'>_blah_blah@blah.com</a></p>"
    );
}

- (void)testURLAutolinkingWithEmailAddressInItalics
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"_matt@diephouse.com_",
        @"<p><em><a href='mailto:matt@diephouse.com'>matt@diephouse.com</a></em></p>"
    );
}

- (void)testURLAutolinkingWithWWW
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"www.github.com",
        @"<p><a href='http://www.github.com'>www.github.com</a></p>"
    );
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"www.github.com/mdiep",
        @"<p><a href='http://www.github.com/mdiep'>www.github.com/mdiep</a></p>"
    );
}

- (void)testURLAutolinkingWithWWWButNoDomain
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"Put www. in front",
        @"<p>Put www. in front</p>"
    );
}

- (void)testURLAutolinkingWithParentheses
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"foo http://www.pokemon.com/Pikachu_(Electric) bar",
        @"<p>foo <a href='http://www.pokemon.com/Pikachu_(Electric)'>http://www.pokemon.com/Pikachu_(Electric)</a> bar</p>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"foo http://www.pokemon.com/Pikachu_(Electric)) bar",
        @"<p>foo <a href='http://www.pokemon.com/Pikachu_(Electric)'>http://www.pokemon.com/Pikachu_(Electric)</a>) bar</p>"
    );
}

- (void)testURLAutolinkingWithPlus
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"https://plus.google.com/+AlanCoxLinux/posts/a2jAP7Pz1gj",
        @"<p><a href=\"https://plus.google.com/+AlanCoxLinux/posts/a2jAP7Pz1gj\">https://plus.google.com/+AlanCoxLinux/posts/a2jAP7Pz1gj</a></p>"
    );
}

- (void)testURLAutolinkingWithEqualsSign
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsAutolinkedURLs,
        @"http://www.test.com/?a=b",
        @"<p><a href=\"http://www.test.com/?a=b\">http://www.test.com/?a=b</a></p>"
    );
}


#pragma mark - MMMarkdownExtensionsHardNewlines

- (void)testHardNewlinesWithStandardMarkdown
{
    MMAssertMarkdownEqualsHTML(
        @"A\nB\nC",
        @"<p>A\nB\nC</p>"
    );
}

- (void)testHardNewlines
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsHardNewlines,
        @"A\nB\nC",
        @"<p>A<br />\nB<br />\nC</p>"
    );
}

- (void)testHardNewlinesWithCarriageReturns
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsHardNewlines,
        @"A\rB\rC",
        @"<p>A<br />\nB<br />\nC</p>"
    );
}

- (void)testHardNewlinesWithCarriageReturnsAndNewlines
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsHardNewlines,
        @"A\r\nB\r\nC",
        @"<p>A<br />\nB<br />\nC</p>"
    );
}

- (void)testHardNewlinesWithTwoSpaces
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsHardNewlines,
        @"A  \nB",
        @"<p>A <br />\n<br />\nB</p>"
    );
}

- (void)testHardNewlinesInLists
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsHardNewlines,
        @"* A\nB\nC\n* D\nE\nF",
        @"<ul><li>A\nB\nC</li><li>D\nE\nF</li></ul>"
    );
    
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsHardNewlines,
        @"* A\nB\nC\n\n* D\nE\nF",
        @"<ul><li><p>A<br />\nB<br />\nC</p></li><li><p>D<br />\nE<br />\nF</p></li></ul>"
    );
}

- (void)testHardNewlinesInBlockquote
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsHardNewlines,
        @"> A\n> B\n> C",
        @"<blockquote><p>A<br />\nB<br />\nC</p></blockquote>"
    );
}


#pragma mark - MMMarkdownExtensionsStrikethroughs

- (void)testStrikethroughWithStandardMarkdown
{
    MMAssertMarkdownEqualsHTML(
        @"~~Mistaken text.~~",
        @"<p>~~Mistaken text.~~</p>"
    );
}

- (void)testStrikethroughBasic
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsStrikethroughs,
        @"~~Mistaken text.~~",
        @"<p><del>Mistaken text.</del></p>"
    );
}

- (void)testStrikethroughWithStrong
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsStrikethroughs,
        @"~~**Mistaken text.**~~",
        @"<p><del><strong>Mistaken text.</strong></del></p>"
    );
}


#pragma mark - MMMarkdownExtensionsFencedCodeBlocks

- (void)testFencedCodeBlockWithStandardMarkdown
{
    MMAssertMarkdownEqualsHTML(@"```\nblah\n```", @"<p><code>\nblah\n</code></p>");
}

- (void)testBasicFencedCodeBlock
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"```\nblah\n```",
        @"<pre><code>blah\n</code></pre>"
    );
}

- (void)testFencedCodeBlockWithEntity
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"```\na&b\n```",
        @"<pre><code>a&amp;b\n</code></pre>"
    );
}

- (void)testFencedCodeBlockAfterBlankLine
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"Test\n\n```\nblah\n```",
        @"<p>Test</p><pre><code>blah\n</code></pre>"
    );
}

- (void)testFencedCodeBlockWithoutBlankLine
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"Test\n```\nblah\n```",
        @"<p>Test</p><pre><code>blah\n</code></pre>"
    );
}

- (void)testFencedCodeBlockWithLanguage
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"```objective-c\nhello\nworld\n```",
        @"<pre><code class=\"objective-c\">hello\nworld\n"
        "</code></pre>\n"
    );
}

- (void)testFencedCodeBlockWithSpaceBeforeLanguage
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"``` objc\nhello\nworld\n```",
        @"<pre><code class=\"objc\">hello\nworld\n"
        "</code></pre>\n"
    );
}

- (void)testFencedCodeBlockWithSpaceAfterLanguage
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"```objc \nhello\nworld\n```",
        @"<pre><code class=\"objc\">hello\nworld\n"
        "</code></pre>\n"
    );
}

- (void)testFencedCodeBlockWithSpaceInLanguageName
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"```a b\nhello\nworld\n```",
        @"<p>```a b\nhello\nworld</p>\n<pre><code></code></pre>\n"
    );
    
}

- (void)testFencedCodeBlockInsideBlockquote
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"> ```\n> test\n> ```",
        @"<blockquote><pre><code>test\n</code></pre></blockquote>"
    );
}

- (void)testFencedCodeBlockFollowedByNonWhitespace
{
    MMAssertExtendedMarkdownEqualsHTML(
        MMMarkdownExtensionsFencedCodeBlocks,
        @"```\n\n```xxx\n\n```\n",
        @"<pre><code>\n```xxx\n</code></pre>"
    );
}

#pragma mark - MMMarkdownExtensionsTables

- (void)testTableWithStandardMarkdown
{
    NSString *markdown = @"1|2|3\n"
                          "---|---|---\n"
                          "A || B|\n"
                          "a | b | c\n";
    NSString *html = @"<p>1|2|3\n"
                      "---|---|---\n"
                      "A || B|\n"
                      "a | b | c</p>";
    MMAssertMarkdownEqualsHTML(markdown, html);
}

- (void)testBasicTable
{
    NSString *markdown = @"1|2|3\n"
                          "---|---|---\n"
                          "A || B|\n"
                          "a | b | c\n";
    NSString *html = @"<table>\n"
                      "<thead>\n"
                      "<tr>\n"
                      "<th>1</th>\n"
                      "<th>2</th>\n"
                      "<th>3</th>\n"
                      "</tr>\n"
                      "</thead>\n"
                      "<tbody>\n"
                      "<tr>\n"
                      "<td>A</td>\n"
                      "<td></td>\n"
                      "<td>B</td>\n"
                      "</tr>\n"
                      "<tr>\n"
                      "<td>a</td>\n"
                      "<td>b</td>\n"
                      "<td>c</td>\n"
                      "</tr>\n"
                      "</tbody>\n"
                      "</table>";
    MMAssertExtendedMarkdownEqualsHTML(MMMarkdownExtensionsTables, markdown, html);
}

- (void)testTableWithSpans
{
    NSString *markdown = @"1|2\n"
                          "---|---\n"
                          "_A_ | `B` |";
    NSString *html = @"<table>\n"
                      "<thead>\n"
                      "<tr>\n"
                      "<th>1</th>\n"
                      "<th>2</th>\n"
                      "</tr>\n"
                      "</thead>\n"
                      "<tbody>\n"
                      "<tr>\n"
                      "<td><em>A</em></td>\n"
                      "<td><code>B</code></td>\n"
                      "</tr>\n"
                      "</tbody>\n"
                      "</table>";
    MMAssertExtendedMarkdownEqualsHTML(MMMarkdownExtensionsTables, markdown, html);
}

- (void)testTableWithAlignment
{
    NSString *markdown = @"| Left  | Center  | Right |\n"
                          "| :----- |:----------:| -----:|\n"
                          "| 1 | 2 | 3 |";
    NSString *html = @"<table>\n"
                      "<thead>\n"
                      "<tr>\n"
                      "<th align='left'>Left</th>\n"
                      "<th align='center'>Center</th>\n"
                      "<th align='right'>Right</th>\n"
                      "</tr>\n"
                      "</thead>\n"
                      "<tbody>\n"
                      "<tr>\n"
                      "<td align='left'>1</td>\n"
                      "<td align='center'>2</td>\n"
                      "<td align='right'>3</td>\n"
                      "</tr>\n"
                      "</tbody>\n"
                      "</table>";
    MMAssertExtendedMarkdownEqualsHTML(MMMarkdownExtensionsTables, markdown, html);
}

- (void)testTableWithPipesOnEnds
{
    NSString *markdown = @"| 1 | 2 |\n"
                          "| --- | --- |\n"
                          "| A | B |";
    NSString *html = @"<table>\n"
                      "<thead>\n"
                      "<tr>\n"
                      "<th>1</th>\n"
                      "<th>2</th>\n"
                      "</tr>\n"
                      "</thead>\n"
                      "<tbody>\n"
                      "<tr>\n"
                      "<td>A</td>\n"
                      "<td>B</td>\n"
                      "</tr>\n"
                      "</tbody>\n"
                      "</table>";
    MMAssertExtendedMarkdownEqualsHTML(MMMarkdownExtensionsTables, markdown, html);
}

@end
