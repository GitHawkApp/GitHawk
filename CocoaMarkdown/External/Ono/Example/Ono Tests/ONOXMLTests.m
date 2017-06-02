// ONOXMLTests.m
//
// Copyright (c) 2014 Mattt Thompson (http://mattt.me/)
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

@interface ONOXMLTests : XCTestCase
@property (nonatomic, strong) ONOXMLDocument *document;
@end

@implementation ONOXMLTests

- (void)setUp {
    [super setUp];

    NSError *error = nil;
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"xml" ofType:@"xml"];
    self.document = [ONOXMLDocument XMLDocumentWithData:[NSData dataWithContentsOfFile:filePath] error:&error];

    XCTAssertNotNil(self.document, @"Document should not be nil");
    XCTAssertNil(error, @"Error should not be generated");
}

#pragma mark -

- (void)testXMLVersion {
    XCTAssertEqualObjects(self.document.version, @"1.0", @"XML version should be 1.0");
}

- (void)testXMLEncoding {
    XCTAssertEqual(self.document.stringEncoding, NSUTF8StringEncoding, @"XML encoding should be UTF-8");
}

- (void)testRootElement {
    XCTAssertEqualObjects(self.document.rootElement.tag, @"spec", @"root element should be spec");
    XCTAssertEqualObjects(self.document.rootElement.attributes[@"w3c-doctype"], @"rec", @"w3c-doctype should be rec");
    XCTAssertEqualObjects(self.document.rootElement.attributes[@"lang"], @"en", @"xml:lang should be en");
}

- (void)testTitle {
    ONOXMLElement *titleElement = [[self.document.rootElement firstChildWithTag:@"header"] firstChildWithTag:@"title"];

    XCTAssertNotNil(titleElement, @"title element should not be nil");
    XCTAssertEqualObjects(titleElement.tag, @"title", @"tag should be `title`");
    XCTAssertEqualObjects([titleElement stringValue], @"Extensible Markup Language (XML)", @"title string value should be 'Extensible Markup Language (XML)'");
}

- (void)testXPath {
    NSString *path = @"/spec/header/title";
    id<NSFastEnumeration> elts = [self.document XPath:path];
    
    NSUInteger counter = 0;
    for (ONOXMLElement *elt in elts)
    {
        XCTAssertEqualObjects(@"title", elt.tag, @"tag should be `title`");
        ++counter;
    }
    XCTAssertEqual(1, counter, @"at least one element should have been found at element path '%@'", path);
}

- (void)testLineNumber {
    ONOXMLElement *headerElement = [self.document.rootElement firstChildWithTag:@"header"];

    XCTAssertNotNil(headerElement, @"header element should not be nil");
    XCTAssertEqual(headerElement.lineNumber, 123, @"header line number should be correct");
}

@end
