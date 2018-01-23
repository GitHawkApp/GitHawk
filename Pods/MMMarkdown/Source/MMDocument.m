//
//  MMDocument.m
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

#import "MMDocument.h"
#import "MMDocument_Private.h"


@interface MMDocument ()
@property (copy, nonatomic) NSArray *elements;
@end

@implementation MMDocument
{
    NSMutableArray *_elements;
}

#pragma mark - Public Methods

+ (id)documentWithMarkdown:(NSString *)markdown
{
    return [[self.class alloc] initWithMarkdown:markdown];
}

- (id)initWithMarkdown:(NSString *)markdown
{
    self = [super init];
    
    if (self)
    {
        _markdown = markdown;
        _elements = [NSMutableArray new];
    }
    
    return self;
}


#pragma mark - Private Methods

- (void)addElement:(MMElement *)anElement
{
    [self willChangeValueForKey:@"elements"];
    [_elements addObject:anElement];
    [self didChangeValueForKey:@"elements"];
}


@end
