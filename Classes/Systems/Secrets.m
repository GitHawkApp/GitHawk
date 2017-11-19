//
//  Secrets.m
//  Freetime
//
//  Created by Ryan Nystrom on 11/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

#import "Secrets.h"

#define STRINGIFY(x) @#x

@implementation Secrets

+ (NSString *)githubClientID {
    return STRINGIFY(GITHUB_CLIENT_ID);
}

+ (NSString *)githubClientSecret {
    return STRINGIFY(GITHUB_CLIENT_SECRET);
}

+ (NSString *)imgurClientID {
    return STRINGIFY(IMGUR_CLIENT_ID);
}

@end
