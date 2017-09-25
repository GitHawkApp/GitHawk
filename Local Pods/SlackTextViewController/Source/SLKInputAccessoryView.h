//
//  SlackTextViewController
//  https://github.com/slackhq/SlackTextViewController
//
//  Copyright 2014-2016 Slack Technologies, Inc.
//  Licence: MIT-Licence
//

#import <UIKit/UIKit.h>

@class SLKInputAccessoryView;

@protocol SLKInputAccessoryViewFrameDelegate <NSObject>

- (void)accessoryView:(SLKInputAccessoryView * _Nullable)accessoryView didChangeFrame:(CGRect)frame;

@end

@interface SLKInputAccessoryView : UIView

/* The system keyboard view used as reference. */
@property (nonatomic, weak, readonly) UIView *_Nullable keyboardViewProxy;

@property (nonatomic, weak, nullable) id<SLKInputAccessoryViewFrameDelegate> frameDelegate;

@end
