// main.m
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

#import <Foundation/Foundation.h>

#import "Ono.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error = nil;
        NSString *XMLFilePath = [[@(__FILE__) stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"nutrition.xml"];
        ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:[NSData dataWithContentsOfFile:XMLFilePath] error:&error];
        if (error) {
            NSLog(@"[Error] %@", error);
            return 0;
        }

        NSLog(@"Root Element: %@", document.rootElement.tag);

        NSLog(@"\n");
        NSLog(@"Daily Values:");
        for (ONOXMLElement *dailyValueElement in [[document.rootElement firstChildWithTag:@"daily-values"] children]) {
            NSString *nutrient = dailyValueElement.tag;
            NSNumber *amount = [dailyValueElement numberValue];
            NSString *unit = dailyValueElement[@"units"];
            NSLog(@"- %@%@ %@ ", amount, unit, nutrient);
        }

        NSLog(@"\n");
        NSString *XPath = @"//food/name";
        NSLog(@"XPath Search: %@", XPath);
        [document enumerateElementsWithXPath:XPath usingBlock:^(ONOXMLElement *element, __unused NSUInteger idx, __unused BOOL *stop) {
            NSLog(@"%@", element);
        }];

        NSLog(@"\n");
        NSString *CSS = @"food > serving[units]";
        NSLog(@"CSS Search: %@", CSS);
        [document enumerateElementsWithCSS:CSS usingBlock:^(ONOXMLElement *element, __unused NSUInteger idx, __unused BOOL *stop) {
            NSLog(@"%@", element);
        }];
        
        NSLog(@"\n");
        XPath = @"//food/name";
        NSLog(@"XPath Search: %@", XPath);
        __block ONOXMLElement *blockElement = nil;
        [document enumerateElementsWithXPath:XPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
            *stop = idx == 1;
            if (*stop) {
                blockElement = element;
            }
        }];
        NSLog(@"Second element: %@", blockElement);
        
        NSLog(@"\n");
        XPath = @"//food/name";
        NSLog(@"XPath Search: %@", XPath);
        ONOXMLElement *firstElement = [document firstChildWithXPath:XPath];
        NSLog(@"First element: %@", firstElement);
    }

    return 0;
}
