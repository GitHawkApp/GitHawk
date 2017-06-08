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

#import "NYTPhotoCaptionView.h"
#import "NYTPhotoDismissalInteractionController.h"
#import "NYTPhotosDataSource.h"
#import "NYTPhotosOverlayView.h"
#import "NYTPhotosViewController.h"
#import "NYTPhotoTransitionAnimator.h"
#import "NYTPhotoTransitionController.h"
#import "NYTPhotoViewController.h"
#import "NYTScalingImageView.h"
#import "NYTPhoto.h"
#import "NYTPhotoCaptionViewLayoutWidthHinting.h"
#import "NYTPhotoContainer.h"
#import "NYTPhotosViewControllerDataSource.h"
#import "NSBundle+NYTPhotoViewer.h"

FOUNDATION_EXPORT double NYTPhotoViewerVersionNumber;
FOUNDATION_EXPORT const unsigned char NYTPhotoViewerVersionString[];

