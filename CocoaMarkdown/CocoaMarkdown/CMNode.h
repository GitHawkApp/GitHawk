//
//  CMNode.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/12/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMIterator;

typedef NS_ENUM(NSInteger, CMNodeType) {
    /* Error status */
    CMNodeTypeNone,
    
    /* Block */
    CMNodeTypeDocument,
    CMNodeTypeBlockQuote,
    CMNodeTypeList,
    CMNodeTypeItem,
    CMNodeTypeCodeBlock,
    CMNodeTypeHTML,
    CMNodeTypeParagraph,
    CMNodeTypeHeader,
    CMNodeTypeHRule,
    
    CMNodeTypeFirstBlock = CMNodeTypeDocument,
    CMNodeTypeLastBlock = CMNodeTypeHRule,
    
    /* Inline */
    CMNodeTypeText,
    CMNodeTypeSoftbreak,
    CMNodeTypeLinebreak,
    CMNodeTypeCode,
    CMNodeTypeInlineHTML,
    CMNodeTypeEmphasis,
    CMNodeTypeStrong,
    CMNodeTypeLink,
    CMNodeTypeImage,
    
    CMNodeTypeFirstInline = CMNodeTypeText,
    CMNodeTypeLastInline = CMNodeTypeImage
};

typedef NS_ENUM(NSInteger, CMListType) {
    CMListTypeNone,
    CMListTypeUnordered,
    CMListTypeOrdered
};

typedef NS_ENUM(NSInteger, CMDelimeterType) {
    CMDelimeterTypeNone,
    CMDelimeterTypePeriod,
    CMDelimeterTypeParen
};

/**
 *  Immutable interface to a CommonMark node.
 */
@interface CMNode : NSObject

/**
 *  Creates an iterator for the node tree that has the
 *  receiver as its root.
 *
 *  @return A new iterator.
 */
- (CMIterator *)iterator;

/**
 *  The next node in the sequence, or `nil` if there is none.
 */
@property (readonly) CMNode *next;

/**
 *  The previous node in the sequence, or `nil` if there is none.
 */
@property (readonly) CMNode *previous;

/**
 *  The receiver's parent node, or `nil` if there is none.
 */
@property (readonly) CMNode *parent;

/**
 *  The first child node of the receiver, or `nil` if there is none.
 */
@property (readonly) CMNode *firstChild;

/**
 *  The last child node of the receiver, or `nil` if there is none.
 */
@property (readonly) CMNode *lastChild;

/**
 *  The type of the node, or `CMNodeTypeNone` on error.
 */
@property (readonly) CMNodeType type;

/**
 *  String representation of `type`.
 */
@property (readonly) NSString *humanReadableType;

/**
 *  String contents of the receiver, or `nil` if there is none.
 */
@property (readonly) NSString *stringValue;

/**
 *  Header level of the receiver, or `0` if the receiver is not a header.
 */
@property (readonly) NSInteger headerLevel;

/**
 *  Info string from a fenced code block, or `nil` if there is none.
 */
@property (readonly) NSString *fencedCodeInfo;

/**
 *  The receiver's list type, or `CMListTypeNone` if the receiver
 *  is not a list.
 */
@property (readonly) CMListType listType;

/**
 *  The receiver's list delimeter type, or `CMDelimeterTypeNone` if the
 *  receiver is not a list.
 */
@property (readonly) CMDelimeterType listDelimeterType;

/**
 *  Starting number of the list, or `0` if the receiver is not
 *  an ordered list.
 */
@property (readonly) NSInteger listStartingNumber;

/**
 *  `YES` if the receiver is a tight list, `NO` otherwise.
 */
@property (readonly) BOOL listTight;

/**
 *  Link or image URL, or `nil` if there is none.
 */
@property (readonly) NSURL *URL;

/**
 *  Link or image title, or `nil` if there is none.
 */
@property (readonly) NSString *title;

/**
 *  The line on which the receiver begins.
 */
@property (readonly) NSInteger startLine;

/**
 *  The column on which the receiver begins.
 */
@property (readonly) NSInteger startColumn;

/**
 *  The line on which the receiver ends.
 */
@property (readonly) NSInteger endLine;

/**
 *  The column on which the receiver ends.
 */
@property (readonly) NSInteger endColumn;

@end
