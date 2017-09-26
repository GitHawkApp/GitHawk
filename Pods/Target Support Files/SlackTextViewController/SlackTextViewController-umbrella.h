#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SLKInputAccessoryView.h"
#import "SLKTextInput.h"
#import "SLKTextInputbar.h"
#import "SLKTextView+SLKAdditions.h"
#import "SLKTextView.h"
#import "SLKTextViewController.h"
#import "SLKTypingIndicatorProtocol.h"
#import "SLKTypingIndicatorView.h"
#import "SLKUIConstants.h"
#import "UIResponder+SLKAdditions.h"
#import "UIScrollView+SLKAdditions.h"
#import "UIView+SLKAdditions.h"

FOUNDATION_EXPORT double SlackTextViewControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char SlackTextViewControllerVersionString[];

