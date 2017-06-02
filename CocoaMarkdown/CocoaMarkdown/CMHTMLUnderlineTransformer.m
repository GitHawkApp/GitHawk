//
//  CMHTMLUnderlineTransformer.m
//  CocoaMarkdown
//
//  Created by Damien Rambout on 21/01/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMHTMLUnderlineTransformer.h"
#import "Ono.h"

@implementation CMHTMLUnderlineTransformer {
    CMUnderlineStyle _style;
    CMColor *_color;
}

- (instancetype)init
{
    return [self initWithUnderlineStyle:NSUnderlineStyleSingle color:nil];
}

- (instancetype)initWithUnderlineStyle:(CMUnderlineStyle)style color:(CMColor *)color
{
    if ((self = [super init])) {
        _style = style;
        _color = color;
    }
    return self;
}

#pragma mark - CMHTMLElementTransformer

+ (NSString *)tagName { return @"u"; };

- (NSAttributedString *)attributedStringForElement:(ONOXMLElement *)element attributes:(NSDictionary *)attributes
{
    CMAssertCorrectTag(element);
    
    NSMutableDictionary *allAttributes = [attributes mutableCopy];
    allAttributes[NSUnderlineStyleAttributeName] = @(_style);
    
    CMColor *color = _color ?: allAttributes[NSForegroundColorAttributeName];
    if (color != nil) {
        allAttributes[NSUnderlineColorAttributeName] = color;
    }
    
    return [[NSAttributedString alloc] initWithString:element.stringValue attributes:allAttributes];
}

@end
