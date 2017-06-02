//
//  CMParserTestObject.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/14/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMDocument;

@interface CMParserTestObject : NSObject
@property (nonatomic, readonly) NSInteger didStartDocument;
@property (nonatomic, readonly) NSInteger didEndDocument;
@property (nonatomic, readonly) NSInteger didAbort;
@property (nonatomic, readonly) NSArray/*<NSString>*/ *foundText;
@property (nonatomic, readonly) NSInteger foundHRule;
@property (nonatomic, readonly) NSArray/*<NSNumber>*/ *didStartHeader;
@property (nonatomic, readonly) NSArray/*<NSNumber>*/ *didEndHeader;
@property (nonatomic, readonly) NSInteger didStartParagraph;
@property (nonatomic, readonly) NSInteger didEndParagraph;
@property (nonatomic, readonly) NSInteger didStartEmphasis;
@property (nonatomic, readonly) NSInteger didEndEmphasis;
@property (nonatomic, readonly) NSInteger didStartStrong;
@property (nonatomic, readonly) NSInteger didEndStrong;
@property (nonatomic, readonly) NSArray/*<NSArray(NSURL, NSString)>*/ *didStartLink;
@property (nonatomic, readonly) NSArray/*<NSArray(NSURL, NSString)>*/ *didEndLink;
@property (nonatomic, readonly) NSArray/*<NSArray(NSURL, NSString)>*/ *didStartImage;
@property (nonatomic, readonly) NSArray/*<NSArray(NSURL, NSString)>*/ *didEndImage;
@property (nonatomic, readonly) NSArray/*<NSString>*/ *foundHTML;
@property (nonatomic, readonly) NSArray/*<NSString>*/ *foundInlineHTML;
@property (nonatomic, readonly) NSArray/*<NSArray(NSString, NSString)>*/ *foundCodeBlock;
@property (nonatomic, readonly) NSArray/*<NSString>*/ *foundInlineCode;
@property (nonatomic, readonly) NSInteger foundSoftBreak;
@property (nonatomic, readonly) NSInteger foundLineBreak;
@property (nonatomic, readonly) NSInteger didStartBlockQuote;
@property (nonatomic, readonly) NSInteger didEndBlockQuote;
@property (nonatomic, readonly) NSArray/*<NSNumber>*/ *didStartUnorderedList;
@property (nonatomic, readonly) NSArray/*<NSNumber>*/ *didEndUnorderedList;
@property (nonatomic, readonly) NSArray/*<NSArray(NSNumber, NSNumber)>*/ *didStartOrderedList;
@property (nonatomic, readonly) NSArray/*<NSArray(NSNumber, NSNumber)>*/ *didEndOrderedList;
@property (nonatomic, readonly) NSInteger didStartListItem;
@property (nonatomic, readonly) NSInteger didEndListItem;

@property (nonatomic) BOOL abortOnStart;

- (instancetype)initWithDocument:(CMDocument *)document;
- (void)parse;
@end
