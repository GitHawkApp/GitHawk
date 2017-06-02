//
//  CMCascadingAttributeStack.h
//  CocoaMarkdown
//
//  Created by Indragie on 1/15/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMAttributeRun;

@interface CMCascadingAttributeStack : NSObject
@property (nonatomic, readonly) NSDictionary *cascadedAttributes;

- (void)push:(CMAttributeRun *)run;
- (CMAttributeRun *)pop;
- (CMAttributeRun *)peek;

@end
