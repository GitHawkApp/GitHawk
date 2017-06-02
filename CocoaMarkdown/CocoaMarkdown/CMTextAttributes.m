//
//  CMTextAttributes.m
//  CocoaMarkdown
//
//  Created by Indragie on 1/15/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import "CMTextAttributes.h"
#import "CMPlatformDefines.h"

static NSDictionary * CMDefaultTextAttributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:12.0]};
#endif
}

static NSDictionary * CMDefaultH1Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:24.0]};
#endif
}

static NSDictionary * CMDefaultH2Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:18.0]};
#endif
}

static NSDictionary * CMDefaultH3Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:14.0]};
#endif
}

static NSDictionary * CMDefaultH4Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:12.0]};
#endif
}

static NSDictionary * CMDefaultH5Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:10.0]};
#endif
}

static NSDictionary * CMDefaultH6Attributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]};
#else
    return @{NSFontAttributeName: [NSFont userFontOfSize:8.0]};
#endif
}

static NSDictionary * CMDefaultLinkAttributes()
{
    return @{
#if TARGET_OS_IPHONE
        NSForegroundColorAttributeName: UIColor.blueColor,
#else
        NSForegroundColorAttributeName: NSColor.blueColor,
#endif
        NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
    };
}

#if TARGET_OS_IPHONE
static UIFont * MonospaceFont()
{
    CGFloat size = [[UIFont preferredFontForTextStyle:UIFontTextStyleBody] pointSize];
    return [UIFont fontWithName:@"Menlo" size:size] ?: [UIFont fontWithName:@"Courier" size:size];
}
#endif

static NSParagraphStyle * DefaultIndentedParagraphStyle()
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = 30;
    style.headIndent = 30;
    return style;
}

static NSDictionary * CMDefaultCodeBlockAttributes()
{
    return @{
#if TARGET_OS_IPHONE
        NSFontAttributeName: MonospaceFont(),
#else
        NSFontAttributeName: [NSFont userFixedPitchFontOfSize:12.0],
#endif
        NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()
    };
}

static NSDictionary * CMDefaultInlineCodeAttributes()
{
#if TARGET_OS_IPHONE
    return @{NSFontAttributeName: MonospaceFont()};
#else
    return @{NSFontAttributeName: [NSFont userFixedPitchFontOfSize:12.0]};
#endif
}

static NSDictionary * CMDefaultBlockQuoteAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

static NSDictionary * CMDefaultOrderedListAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

static NSDictionary * CMDefaultUnorderedListAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

static NSDictionary * CMDefaultOrderedSublistAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

static NSDictionary * CMDefaultUnorderedSublistAttributes()
{
    return @{NSParagraphStyleAttributeName: DefaultIndentedParagraphStyle()};
}

@implementation CMTextAttributes

- (instancetype)init
{
    if ((self = [super init])) {
        _textAttributes = CMDefaultTextAttributes();
        _h1Attributes = CMDefaultH1Attributes();
        _h2Attributes = CMDefaultH2Attributes();
        _h3Attributes = CMDefaultH3Attributes();
        _h4Attributes = CMDefaultH4Attributes();
        _h5Attributes = CMDefaultH5Attributes();
        _h6Attributes = CMDefaultH6Attributes();
        _linkAttributes = CMDefaultLinkAttributes();
        _codeBlockAttributes = CMDefaultCodeBlockAttributes();
        _inlineCodeAttributes = CMDefaultInlineCodeAttributes();
        _blockQuoteAttributes = CMDefaultBlockQuoteAttributes();
        _orderedListAttributes = CMDefaultOrderedListAttributes();
        _unorderedListAttributes = CMDefaultUnorderedListAttributes();
        _orderedSublistAttributes = CMDefaultOrderedSublistAttributes();
        _unorderedSublistAttributes = CMDefaultUnorderedSublistAttributes();
    }
    return self;
}

- (NSDictionary *)attributesForHeaderLevel:(NSInteger)level
{
    switch (level) {
        case 1: return _h1Attributes;
        case 2: return _h2Attributes;
        case 3: return _h3Attributes;
        case 4: return _h4Attributes;
        case 5: return _h5Attributes;
        default: return _h6Attributes;
    }
}

@end
