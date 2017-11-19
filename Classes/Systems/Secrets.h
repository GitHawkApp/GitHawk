//
//  Secrets.h
//  Freetime
//
//  Created by Ryan Nystrom on 11/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Secrets : NSObject

+ (NSString *)githubClientID;
+ (NSString *)githubClientSecret;
+ (NSString *)imgurClientID;

@end

NS_ASSUME_NONNULL_END
