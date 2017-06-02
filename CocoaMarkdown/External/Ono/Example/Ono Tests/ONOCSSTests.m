// ONOCSSTests.m
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

extern NSString * ONOXPathFromCSS(NSString *CSS);

@interface ONOCSSTests : XCTestCase
@end

@implementation ONOCSSTests

#pragma mark -

- (void)testCSSWildcardSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"*"), @".//*");
}

- (void)testCSSElementSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"div"), @".//div");
}

- (void)testCSSClassSelector {
	XCTAssertEqualObjects(ONOXPathFromCSS(@".highlighted"), @".//*[contains(concat(' ',normalize-space(@class),' '),' highlighted ')]");
}

- (void)testCSSElementAndClassSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"span.highlighted"), @".//span[contains(concat(' ',normalize-space(@class),' '),' highlighted ')]");
}

- (void)testCSSElementAndIDSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"h1#logo"), @".//h1[@id = 'logo']");
}

- (void)testCSSIDSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"#logo"), @".//*[@id = 'logo']");
}

- (void)testCSSWildcardChildSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"html *"), @".//html//*");
}

- (void)testCSSDescendantCombinatorSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"body p"), @".//body/descendant::p");
}

- (void)testCSSChildCombinatorSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"ul > li"), @".//ul/li");
}

- (void)testCSSAdjacentSiblingCombinatorSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"h1 + p"), @".//h1/following-sibling::*[1]/self::p");
}

- (void)testCSSGeneralSiblingCombinatorSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"p ~ p"), @".//p/following-sibling::p");
}

- (void)testCSSMultipleExpressionSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"ul, ol"), @".//ul | .//ol");
}

- (void)testCSSAttributeSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"img[alt]"), @".//img[@alt]");
}

/*
- (void)testCSSAttributeContainsValueSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"i[href~=\"icon\"]"), @"//i[contains(concat(' ', @class, ' '),concat(' ', 'icon', ' '))]");
}

- (void)testCSSAttributeBeginsWithValueSelector {
    XCTAssertEqualObjects(ONOXPathFromCSS(@"a[href|=\"https://\"]"), @"//a[@href = 'https://' or starts-with(@href, concat('https://', '-'))]");
}
 */

@end
