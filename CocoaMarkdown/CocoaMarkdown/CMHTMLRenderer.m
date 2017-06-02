//
//  CMHTMLRenderer.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/20/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMHTMLRenderer.h"
#import "CMDocument_Private.h"
#import "CMNode_Private.h"

@implementation CMHTMLRenderer {
    CMDocument *_document;
}

- (instancetype)initWithDocument:(CMDocument *)document
{
    if ((self = [super init])) {
        _document = document;
    }
    return self;
}

- (NSString *)render
{
    char *html = cmark_render_html(_document.rootNode.node, _document.options);
    return [NSString stringWithUTF8String:html];
}

@end
