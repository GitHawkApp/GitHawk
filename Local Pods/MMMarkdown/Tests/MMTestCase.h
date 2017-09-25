//
//  MMTestCase.h
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

#import <XCTest/XCTest.h>


#import "MMMarkdown.h"

#define RUN_KNOWN_FAILURES 0

#define MMAssertMarkdownEqualsHTML(markdown, html) \
    do { \
        id a1value = (markdown); \
        id a2value = (html); \
        \
        NSError *error; \
        NSString *output = [MMMarkdown HTMLStringWithMarkdown:a1value error:&error]; \
        NSString *html2  = a2value;\
        \
        /* Add root elements for parsing */ \
        output = [NSString stringWithFormat:@"<test>%@</test>", output]; \
        html2  = [NSString stringWithFormat:@"<test>%@</test>", html2]; \
        \
        NSError *actualError; \
        NSError *expectedError; \
        NSXMLDocument *actual   = [[NSXMLDocument alloc] initWithXMLString:output options:0 error:&actualError]; \
        NSXMLDocument *expected = [[NSXMLDocument alloc] initWithXMLString:html2  options:0 error:&expectedError]; \
        XCTAssertNotNil(actual, "%@", actualError); \
        XCTAssertNotNil(expected, "%@", expectedError); \
        XCTAssertEqualObjects(actual, expected); \
    } while(0)

#define MMAssertMarkdownEqualsString(markdown, string) \
    do { \
        id a1value = (markdown); \
        id a2value = (string); \
        \
        NSError *error; \
        NSString *actual   = [MMMarkdown HTMLStringWithMarkdown:a1value error:&error]; \
        NSString *expected = a2value; \
        XCTAssertNotNil(actual); \
        XCTAssertNotNil(expected); \
        XCTAssertEqualObjects(actual, expected); \
    } while(0)

@interface MMTestCase : XCTestCase

- (NSString *)stringWithContentsOfFile:(NSString *)aString inDirectory:(NSString *)aDirectory;
- (void)runTestWithName:(NSString *)aName inDirectory:(NSString *)aDirectory;

@end
