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

@interface ONOAtomTests : XCTestCase
@property (nonatomic, strong) ONOXMLDocument *document;
@end

@implementation ONOAtomTests

- (void)setUp {
    [super setUp];

    NSError *error = nil;
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"atom" ofType:@"xml"];
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
    XCTAssertEqualObjects(self.document.rootElement.tag, @"feed", @"root element should be feed");
//    XCTAssertEqualObjects(self.document.rootElement.namespace, @"http://www.w3.org/2005/Atom", @"XML namespace should be Atom");
}

- (void)testTitle {
    ONOXMLElement *titleElement = [self.document.rootElement firstChildWithTag:@"title"];

    XCTAssertNotNil(titleElement, @"title element should not be nil");
    XCTAssertEqualObjects(titleElement.tag, @"title", @"tag should be `title`");
    XCTAssertEqualObjects([titleElement stringValue], @"Example Feed", @"title string value should be 'Example Feed'");
}

- (void)testLinks {
    NSArray *linkElements = [self.document.rootElement childrenWithTag:@"link"];

    XCTAssertTrue([linkElements count] == 2, @"should have 2 link elements");
    XCTAssertEqualObjects([linkElements[0] stringValue], @"", @"stringValue should be nil");
    XCTAssertNotEqualObjects(linkElements[0][@"href"], linkElements[1][@"href"], @"href values should not be equal");
}

- (void)testUpdated {
    ONOXMLElement *updatedElement = [self.document.rootElement firstChildWithTag:@"updated"];

    XCTAssertNotNil([updatedElement dateValue], @"dateValue should not be nil");
    XCTAssertTrue([[updatedElement dateValue] isKindOfClass:[NSDate class]], @"dateValue should be kind of NSDate");

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    dateComponents.year = 2003;
    dateComponents.month = 12;
    dateComponents.day = 13;
    dateComponents.hour = 18;
    dateComponents.minute = 30;
    dateComponents.second = 2;

    XCTAssertEqualObjects([updatedElement dateValue], [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:dateComponents], @"dateValue should be equal to December 13, 2003 6:30:02 PM");
}

- (void)testEntries {
    NSArray *entryElements = [self.document.rootElement childrenWithTag:@"entry"];
    XCTAssertTrue([entryElements count] == 1, @"should be 1 entry element");
}

- (void)testNamespace {
    NSArray *entryElements = [self.document.rootElement childrenWithTag:@"entry"];
    XCTAssertTrue([entryElements count] == 1, @"should be 1 entry element");

    NSArray *namespacedElements = [[entryElements firstObject] childrenWithTag:@"language" inNamespace:@"dc"];
    XCTAssertTrue([namespacedElements count] == 1, @"should be 1 entry element");
    
    ONOXMLElement *namespacedElement = [namespacedElements firstObject];
    XCTAssertNotNil(namespacedElement.namespace, @"the namespace shouldn't be nil");
    XCTAssertTrue([namespacedElement.namespace isEqualToString:@"dc"], @"Namespaces should match");
}

-(void)testXPathWithNamespaces {

    __block NSUInteger count = 0;
    [self.document enumerateElementsWithXPath:@"//dc:language" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        XCTAssertNotNil(element.namespace, @"the namespace shouldn't be nil");
        XCTAssertTrue([element.namespace isEqualToString:@"dc"], @"Namespaces should match");
        count = idx + 1;
    }];
    XCTAssertEqual(count, 1, @"should be 1 entry element");
}

@end
