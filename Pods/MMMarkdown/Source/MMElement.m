//
//  MMElement.m
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

#import "MMElement.h"


static NSString * __MMStringFromElementType(MMElementType type)
{
    switch (type)
    {
        case MMElementTypeNone:
            return @"none";
        case MMElementTypeHeader:
            return @"header";
        case MMElementTypeParagraph:
            return @"paragraph";
        case MMElementTypeBlockquote:
            return @"blockquote";
        case MMElementTypeNumberedList:
            return @"ol";
        case MMElementTypeBulletedList:
            return @"ul";
        case MMElementTypeListItem:
            return @"li";
        case MMElementTypeCodeBlock:
            return @"code";
        case MMElementTypeHorizontalRule:
            return @"hr";
        case MMElementTypeHTML:
            return @"html";
        case MMElementTypeLineBreak:
            return @"br";
        case MMElementTypeStrikethrough:
            return @"del";
        case MMElementTypeStrong:
            return @"strong";
        case MMElementTypeEm:
            return @"em";
        case MMElementTypeCodeSpan:
            return @"code";
        case MMElementTypeImage:
            return @"image";
        case MMElementTypeLink:
            return @"link";
        case MMElementTypeMailTo:
            return @"mailto";
        case MMElementTypeEntity:
            return @"entity";
        case MMElementTypeDefinition:
            return @"definition";
        case MMElementTypeTable:
            return @"table";
        case MMElementTypeTableRow:
            return @"table-row";
        case MMElementTypeTableHeader:
            return @"table-header";
        case MMElementTypeTableRowCell:
            return @"table-row-cell";
        case MMElementTypeTableHeaderCell:
            return @"table-header-cell";
        case MMElementTypeUsername:
            return @"username";
        case MMElementTypeCheckbox:
            return @"checkbox";
        case MMElementTypeShorthandIssues:
            return @"shorthand";
        case MMElementTypeShortenedLink:
            return @"shortenedlink";
    }
}

@implementation MMElement
{
    NSMutableArray *_innerRanges;
    NSMutableArray *_children;
}

#pragma mark - NSObject

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _innerRanges = [NSMutableArray new];
        _children    = [NSMutableArray new];
    }
    
    return self;
}

- (void)dealloc
{
    [self.children makeObjectsPerformSelector:@selector(setParent:) withObject:nil];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; type=%@; range=%@>",
            NSStringFromClass(self.class), self, __MMStringFromElementType(self.type), NSStringFromRange(self.range)];
            
}


#pragma mark - Public Methods

- (void)addInnerRange:(NSRange)aRange
{
    [self willChangeValueForKey:@"innerRanges"];
    [_innerRanges addObject:[NSValue valueWithRange:aRange]];
    [self didChangeValueForKey:@"innerRanges"];
}

- (void)removeLastInnerRange
{
    [self willChangeValueForKey:@"innerRanges"];
    [_innerRanges removeLastObject];
    [self didChangeValueForKey:@"innerRanges"];
}

- (void)addChild:(MMElement *)aChild
{
    [self willChangeValueForKey:@"children"];
    [_children addObject:aChild];
    aChild.parent = self;
    [self didChangeValueForKey:@"children"];
}

- (void)removeChild:(MMElement *)aChild
{
    [self willChangeValueForKey:@"children"];
    [_children removeObjectIdenticalTo:aChild];
    aChild.parent = nil;
    [self didChangeValueForKey:@"children"];
}

- (MMElement *)removeLastChild
{
    MMElement *child = [self.children lastObject];
    [_children removeLastObject];
    return child;
}


#pragma mark - Public Properties

- (void)setInnerRanges:(NSArray *)innerRanges
{
    _innerRanges = [innerRanges mutableCopy];
}

- (void)setChildren:(NSArray *)children
{
    for (MMElement *child in _children) {
        child.parent = nil;
    }
    _children = [children mutableCopy];
    for (MMElement *child in _children) {
        child.parent = self;
    }
}


@end
