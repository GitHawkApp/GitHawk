//
//  NYTPhotoViewerSinglePhotoDataSource.m
//  NYTPhotoViewer
//
//  Created by Chris Dzombak on 1/27/17.
//  Copyright © 2017 The New York Times Company. All rights reserved.
//

#import "NYTPhotoViewerSinglePhotoDataSource.h"

@implementation NYTPhotoViewerSinglePhotoDataSource

- (instancetype)initWithPhoto:(id<NYTPhoto>)photo {
    if ((self = [super init])) {
        _photo = photo;
    }
    return self;
}

+ (instancetype)dataSourceWithPhoto:(id<NYTPhoto>)photo {
    return [[self alloc] initWithPhoto:photo];
}

#pragma mark NYTPhotoViewerDataSource

- (NSNumber *)numberOfPhotos {
    return @(1);
}

- (id<NYTPhoto>)photoAtIndex:(NSInteger)photoIndex {
    return self.photo;
}

- (NSInteger)indexOfPhoto:(id<NYTPhoto>)photo {
    return 0;
}

@end
