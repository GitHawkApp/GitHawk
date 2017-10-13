//
//  FlexController.m
//  GitHawk
//
//  Created by Ryan Nystrom on 6/23/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

#import "FlexController.h"

#if DEBUG || TESTFLIGHT
#import <FLEX/FLEX.h>
#endif

@implementation FlexController

- (void)configureWindow:(UIWindow *)window {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    tap.numberOfTouchesRequired = 3;
    [window addGestureRecognizer:tap];
}

- (void)onTap:(UITapGestureRecognizer *)recognizer {
#if DEBUG || TESTFLIGHT
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        [[FLEXManager sharedManager] showExplorer];
    }
#endif
}

@end
