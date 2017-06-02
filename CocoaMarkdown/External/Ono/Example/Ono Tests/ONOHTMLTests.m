// ONOHTMLTests.m
// 
// Copyright (c) 2014 Mattt Thompson
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

#import <XCTest/XCTest.h>

#import "Ono.h"

@interface ONOHTMLTests : XCTestCase
@property (nonatomic, strong) ONOXMLDocument *document;
@end

@implementation ONOHTMLTests

- (void)setUp {
    [super setUp];

    NSError *error = nil;
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"web" ofType:@"html"];
    self.document = [ONOXMLDocument HTMLDocumentWithData:[NSData dataWithContentsOfFile:filePath] error:&error];

    XCTAssertNotNil(self.document, @"Document should not be nil");
    XCTAssertNil(error, @"Error should not be generated");
}

#pragma mark -

- (void)testRootElement {
    XCTAssertEqualObjects(self.document.rootElement.tag, @"html", @"html not root element");
}

- (void)testRootElementChildren {
    NSArray *children = [self.document.rootElement children];
    XCTAssertNotNil(children, @"children should not be nil");
    XCTAssertTrue([children count] == 2, @"root element has more than two children");
    XCTAssertEqualObjects([[children firstObject] tag], @"head", @"head not first child of html");
    XCTAssertEqualObjects([[children lastObject] tag], @"body", @"body not last child of html");
}

- (void)testTitleXPath {
    NSUInteger idx = 0;
    for (ONOXMLElement *element in [self.document XPath:@"//head/title"]) {
        XCTAssertTrue(idx == 0, @"more than one element found");
        XCTAssertEqualObjects([element stringValue], @"mattt/Ono", @"title mismatch");
        idx++;
    }
    XCTAssertTrue(idx == 1, @"fewer than one element found");
}

- (void)testTitleCSS {
    NSUInteger idx = 0;
    for (ONOXMLElement *element in [self.document CSS:@"head title"]) {
        XCTAssertTrue(idx == 0, @"more than one element found");
        XCTAssertEqualObjects([element stringValue], @"mattt/Ono", @"title mismatch");
        idx++;
    }
    XCTAssertTrue(idx == 1, @"fewer than one element found");
}

- (void)testIDCSS {
    NSUInteger idx = 0;
    for (ONOXMLElement *element in [self.document CSS:@"#account_settings"]) {
        XCTAssertTrue(idx == 0, @"more than one element found");
        XCTAssertEqualObjects(element[@"href"], @"/settings/profile", @"href mismatch");
        idx++;
    }
    XCTAssertTrue(idx == 1, @"fewer than one element found");
}

@end
