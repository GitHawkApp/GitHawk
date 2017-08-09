//
//  GitHub.m
//  Freetime
//
//  Created by Shahpour Benkau on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

#import "GithubAPI.h"

#define STRINGIFY(x) @#x

@implementation GithubAPI
    
+ (NSString * __nonnull)clientID {
    return STRINGIFY(CLIENT_ID);
}
    
+ (NSString * __nonnull)clientSecret {
    return STRINGIFY(CLIENT_SECRET);
}

@end
