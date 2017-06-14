//
//  MMTestCase.m
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


@implementation MMTestCase

#pragma mark - Public Methods

- (NSString *)stringWithContentsOfFile:(NSString *)aString inDirectory:(NSString *)aDirectory
{
    NSBundle *bundle  = [NSBundle bundleForClass:[self class]];
    NSURL    *fileURL = [bundle URLForResource:aString withExtension:nil subdirectory:aDirectory];
    NSData   *data    = [NSData dataWithContentsOfURL:fileURL];
    NSString *string  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (void)runTestWithName:(NSString *)aName inDirectory:(NSString *)aDirectory
{
    NSString *input  = [self stringWithContentsOfFile:[NSString stringWithFormat:@"%@.text", aName] inDirectory:aDirectory];
    NSString *html   = [self stringWithContentsOfFile:[NSString stringWithFormat:@"%@.html", aName] inDirectory:aDirectory];
    
    MMAssertMarkdownEqualsHTML(input, html);
}


@end
