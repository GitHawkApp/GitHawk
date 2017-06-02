// ONOVMAPTests.m
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

@interface ONOVMAPTests : XCTestCase
@property (nonatomic, strong) ONOXMLDocument *document;
@end

@implementation ONOVMAPTests

- (void)setUp {
    [super setUp];

    NSError *error = nil;
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"vmap" ofType:@"xml"];
    self.document = [ONOXMLDocument XMLDocumentWithData:[NSData dataWithContentsOfFile:filePath] error:&error];

    XCTAssertNotNil(self.document, @"Document should not be nil");
    XCTAssertNil(error, @"Error should not be generated");
}

#pragma mark -

- (void)testAbsoluteXPathWithNamespace {
    NSString *XPath = @"/vmap:VMAP/vmap:Extensions/uo:unicornOnce";
    NSUInteger count = 0;
    for (ONOXMLElement *element in [self.document XPath:XPath]) {
        XCTAssertEqualObjects(@"unicornOnce", element.tag, @"tag should be `unicornOnce`");
        count++;
    }

    XCTAssertEqual(1, count, @"Element should be found at XPath '%@'", XPath);
}

- (void)testRelativeXPathWithNamespace {
    NSString *absoluteXPath = @"/vmap:VMAP/vmap:Extensions";
    NSString *relativeXPath = @"./uo:unicornOnce";
    NSUInteger count = 0;
    for (ONOXMLElement *absoluteElement in [self.document XPath:absoluteXPath]) {
        for (ONOXMLElement *relativeElement in [absoluteElement XPath:relativeXPath]) {
            XCTAssertEqualObjects(@"unicornOnce", relativeElement.tag, @"tag should be `unicornOnce`");
            count++;
        }
    }
    
    XCTAssertEqual(1, count, @"Element should be found at XPath '%@' relative to XPath '%@'", relativeXPath, absoluteXPath);
}

- (void)testUnicornOnceIsBlank {
    NSString *XPath = @"/vmap:VMAP/vmap:Extensions/uo:unicornOnce";
    ONOXMLElement *element = [self.document firstChildWithXPath:XPath];
    XCTAssertNotNil(element, @"Element should not be nil");
    XCTAssertTrue([element isBlank], @"Element should be blank");
}

@end
