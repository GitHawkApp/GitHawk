//
//  FlexController.m
//  Freetime
//
//  Created by Ryan Nystrom on 6/23/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

#import "FlexController.h"

#if DEBUG
#import <FLEX/FLEX.h>
#endif

@implementation FlexController

- (void)configureWindow:(UIWindow *)window {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    tap.numberOfTouchesRequired = 3;
    [window addGestureRecognizer:tap];
}

- (void)onTap:(UITapGestureRecognizer *)recognizer {
#if DEBUG
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        [[FLEXManager sharedManager] showExplorer];
    }
#endif
}

@end
