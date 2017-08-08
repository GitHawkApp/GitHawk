//
//  SlackTextViewController
//  https://github.com/slackhq/SlackTextViewController
//
//  Copyright 2014-2016 Slack Technologies, Inc.
//  Licence: MIT-Licence
//

#import "SLKInputAccessoryView.h"

#import "SLKUIConstants.h"

@implementation SLKInputAccessoryView {
    __weak id _kb;
}

#pragma mark - Super Overrides

- (void)dealloc
{
    [_kb removeObserver:self forKeyPath:@"center"];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];

    if (_kb != newSuperview) {
        [_kb removeObserver:self forKeyPath:@"center"];
    }

    _kb = newSuperview;
    [newSuperview addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
}

- (UIView *)keyboardViewProxy
{
    return self.superview;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"center"]) {
        [self.frameDelegate accessoryView:self didChangeFrame:self.superview.frame];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
