//
//  SetupMockNetworkEnvironment.m
//  Freetime
//
//  Created by Ryan Nystrom on 1/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

#import "SetupMockNetworkEnvironment.h"

#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

#ifndef RECORDING_ENABLED
#define RECORDING_ENABLED 0
#endif

#ifndef PLAYBACK_ENABLED
#define PLAYBACK_ENABLED 0
#endif

static NSString *projectPath(void) {
    // set to $(PROJECT_DIR) in env vars
    NSString *path = [[NSProcessInfo processInfo] environment][@"NETWORK_RECORD_PATH"];
    NSCAssert(path.length > 0, @"Environment variable NETWORK_RECORD_PATH not set");
    return [path stringByAppendingPathComponent:@"records"];
}

static NSString *recordsPath(void) {
    NSString *path = projectPath();
    BOOL isDir = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] || !isDir) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

static NSString *requestKey(NSURLRequest *request) {
    // dont key using the access token
    NSURLComponents *components = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:NO];
    NSMutableArray *queryItems = [[components queryItems] mutableCopy];
    [[components queryItems] enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSURLQueryItem *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.name isEqualToString:@"access_token"]) {
            [queryItems removeObjectAtIndex:idx];
        }
    }];
    components.queryItems = queryItems;

    NSMutableString *raw = [NSMutableString new];
    [raw appendString:request.HTTPMethod ?: @""];
    [raw appendString:components.URL.absoluteString ?: @""];
    [raw appendString:[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] ?: @""];

    const char *cStr = [raw UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}

static NSString *requestPath(NSURLRequest *request) {
    NSString *key = requestKey(request);
    return [recordsPath() stringByAppendingPathComponent:key];
}

static void store(NSCachedURLResponse *cachedResponse, NSURLRequest *request) {
    if (!RECORDING_ENABLED) {
        return;
    }
    if (![cachedResponse.response isKindOfClass:[NSHTTPURLResponse class]]
        || ![cachedResponse.response.MIMEType containsString:@"application/json"]) {
        return;
    }
    NSString *path = requestPath(request);
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"WARNING: Overwriting file for request %@", request.URL.absoluteString);
    }
    [cachedResponse.data writeToFile:requestPath(request) atomically:YES];
}


@interface PlaybackURLProtocol: NSURLProtocol
@end

@interface RecordingURLCache : NSURLCache
@end

BOOL SetupMockNetworkEnvironment(NSURLSessionConfiguration *config) {
    if (!RECORDING_ENABLED && !PLAYBACK_ENABLED) {
        return NO;
    }

    if (RECORDING_ENABLED) {
        NSURLCache *cache = [[RecordingURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                                 diskCapacity:20 * 1024 * 1024
                                                                     diskPath:nil];
        [NSURLCache setSharedURLCache:cache];
        config.URLCache = cache;
    }

    if (PLAYBACK_ENABLED) {
        config.protocolClasses = @[[PlaybackURLProtocol class]];
    }

    return YES;
}

@implementation PlaybackURLProtocol {
    NSURLSessionTask *_task;
}

+ (BOOL)canInitWithTask:(NSURLSessionTask *)task {
    return PLAYBACK_ENABLED
    && [[NSFileManager defaultManager] fileExistsAtPath:requestPath(task.originalRequest)];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return PLAYBACK_ENABLED
    && [[NSFileManager defaultManager] fileExistsAtPath:requestPath(request)];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (instancetype)initWithTask:(NSURLSessionTask *)task cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient>)client {
    if (self = [super initWithTask:task cachedResponse:cachedResponse client:client]) {
        _task = task;
    }
    return self;
}

- (void)startLoading {
    NSURLRequest *request = _task.originalRequest ?: self.request;
    NSString *path = requestPath(request);
    NSLog(@"Loading request from disk: %@\n    path: %@", request.URL.absoluteString, path);
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSCAssert(data.length > 0, @"Loaded empty data for request %@ at path %@", request.URL.absoluteString, path);

    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:request.URL
                                                              statusCode:200
                                                             HTTPVersion:(NSString *)kCFHTTPVersion1_1
                                                            headerFields:nil];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {}

@end

@implementation RecordingURLCache {
    BOOL _isStoringRequest;
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request {
    if (!_isStoringRequest) {
        store(cachedResponse, request);
    }
    _isStoringRequest = YES;
    [super storeCachedResponse:cachedResponse forRequest:request];
    _isStoringRequest = NO;
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forDataTask:(NSURLSessionDataTask *)dataTask {
    if (!_isStoringRequest) {
        store(cachedResponse, dataTask.originalRequest);
    }
    _isStoringRequest = YES;
    [super storeCachedResponse:cachedResponse forDataTask:dataTask];
    _isStoringRequest = NO;
}

@end
