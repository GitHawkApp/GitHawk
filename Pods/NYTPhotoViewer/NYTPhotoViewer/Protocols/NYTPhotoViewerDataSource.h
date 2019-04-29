//
//  NYTPhotosViewControllerDataSource.h
//  NYTPhotoViewer
//
//  Created by Brian Capps on 2/10/15.
//  Copyright (c) 2015 NYTimes. All rights reserved.
//

@import UIKit;

@protocol NYTPhoto;

NS_ASSUME_NONNULL_BEGIN

/**
 *  The data source for an `NYTPhotosViewController` instance.
 *
 *  A view controller, view model, or model in your application could conform to this protocol, depending on what makes sense in your architecture.
 *
 *  Alternatively, `NYTPhotoViewerArrayDataSource` and `NYTPhotoViewerSinglePhotoDataSource` are concrete classes which conveniently handle the most common use cases for NYTPhotoViewer.
 */
@protocol NYTPhotoViewerDataSource

/**
 *  The total number of photos in the data source, or `nil` if the number is not known.
 *
 *  The number returned should package an `NSInteger` value.
 */
@property (nonatomic, readonly, nullable) NSNumber *numberOfPhotos;

/**
 *  Returns the index of a given photo, or `NSNotFound` if the photo is not in the data source.
 *
 *  @param photo The photo against which to look for the index.
 *
 *  @return The index of a given photo, or `NSNotFound` if the photo is not in the data source.
 */
- (NSInteger)indexOfPhoto:(id <NYTPhoto>)photo;

/**
 *  Returns the photo object at a specified index, or `nil` if one does not exist at that index.
 *
 *  @param photoIndex The index of the desired photo.
 *
 *  @return The photo object at a specified index, or `nil` if one does not exist at that index.
 */
- (nullable id <NYTPhoto>)photoAtIndex:(NSInteger)photoIndex;

@end

NS_ASSUME_NONNULL_END
