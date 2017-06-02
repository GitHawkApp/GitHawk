//
//  CMHTMLUtilities.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/16/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMHTMLUtilities.h"

NSString * CMTagNameFromHTMLTag(NSString *tag)
{
    // Assumes a well-formed HTML tag.
    NSCharacterSet *alphanumeric = NSCharacterSet.alphanumericCharacterSet;
    NSUInteger start = [tag rangeOfCharacterFromSet:alphanumeric].location;
    if (start == NSNotFound) return nil;
    
    NSCharacterSet *inverseAlphanumeric = alphanumeric.invertedSet;
    NSUInteger end = [tag rangeOfCharacterFromSet:inverseAlphanumeric options:0 range:NSMakeRange(start, tag.length - start)].location;
    if (end == NSNotFound) return nil;
    
    return [tag substringWithRange:NSMakeRange(start, end - start)];
}

BOOL CMIsHTMLVoidTagName(NSString *name)
{
    static NSSet *voidNames = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        voidNames = [NSSet setWithObjects:
            @"area",
            @"base",
            @"br",
            @"col",
            @"command",
            @"embed",
            @"hr",
            @"img",
            @"input",
            @"keygen",
            @"link",
            @"meta",
            @"param",
            @"source",
            @"track",
            @"wbr",
            nil
        ];
    });
    return [voidNames containsObject:name];
}

BOOL CMIsHTMLTag(NSString *tag)
{
    return [tag hasPrefix:@"<"] && [tag hasSuffix:@">"];
}

BOOL CMIsHTMLClosingTag(NSString *tag)
{
    return [tag hasPrefix:@"</"] && [tag hasSuffix:@">"];
}
