//
//  NYTPhotoViewerArrayDataSource.m
//  NYTPhotoViewer
//
//  Created by Brian Capps on 2/11/15.
//  Copyright (c) 2017 The New York Times Company. All rights reserved.
//

#import "NYTPhotoViewerArrayDataSource.h"

@implementation NYTPhotoViewerArrayDataSource

#pragma mark - NSObject

- (instancetype)init {
    return [self initWithPhotos:nil];
}

#pragma mark - NYTPhotosDataSource

- (instancetype)initWithPhotos:(nullable NSArray<id<NYTPhoto>> *)photos {
    self = [super init];
    
    if (self) {
        if (photos == nil) {
            _photos = @[];
        } else {
            _photos = [photos copy];
        }
    }
    
    return self;
}

+ (instancetype)dataSourceWithPhotos:(nullable NSArray<id<NYTPhoto>> *)photos {
    return [[self alloc] initWithPhotos:photos];
}

#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)length {
    return [self.photos countByEnumeratingWithState:state objects:buffer count:length];
}

#pragma mark - NYTPhotosViewControllerDataSource

- (NSNumber *)numberOfPhotos {
    return @(self.photos.count);
}

- (nullable id <NYTPhoto>)photoAtIndex:(NSInteger)photoIndex {
    if (photoIndex < self.photos.count) {
        return self.photos[photoIndex];
    }
    
    return nil;
}

- (NSInteger)indexOfPhoto:(id <NYTPhoto>)photo {
    return [self.photos indexOfObject:photo];
}

#pragma mark - Subscripting

- (id<NYTPhoto>)objectAtIndexedSubscript:(NSUInteger)idx {
    return self.photos[idx];
}

@end
