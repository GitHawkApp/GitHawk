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

@interface RecordedResponse: NSObject<NSCoding>

@property (nonatomic, strong) NSDictionary *headerFields;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NSInteger statusCode;

@end

@implementation RecordedResponse

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _data = [aDecoder decodeObjectForKey:@"data"];
        _statusCode = [aDecoder decodeIntegerForKey:@"statusCode"];
        _url = [aDecoder decodeObjectForKey:@"url"];
        _headerFields = [aDecoder decodeObjectForKey:@"headerFields"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.data forKey:@"data"];
    [aCoder encodeInteger:self.statusCode forKey:@"statusCode"];
    [aCoder encodeObject:self.headerFields forKey:@"headerFields"];
    [aCoder encodeObject:self.url forKey:@"url"];
}

@end

@interface NSString (EscapedFileName)

- (NSString *)gh_escapedFileName;

@end

@implementation NSString (EscapedFileName)

- (NSString *)gh_escapedFileName {
    NSCharacterSet* illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    return [[self componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
}

@end

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
    NSMutableString *raw = [NSMutableString new];
    [raw appendString:request.HTTPMethod ?: @"GET"];
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
    NSString *path = recordsPath();
    for (NSString *component in [request.URL.host componentsSeparatedByString:@"."]) {
        path = [path stringByAppendingPathComponent:component];
    }
    path = [path stringByAppendingPathComponent:request.URL.path];

    // dont key using the access token so that it can be faked in tests/playback
    NSURLComponents *components = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:NO];
    NSMutableArray *queryItems = [[components queryItems] mutableCopy];
    [[components queryItems] enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSURLQueryItem *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.name isEqualToString:@"access_token"]) {
            [queryItems removeObjectAtIndex:idx];
        }
    }];
    [queryItems sortUsingComparator:^NSComparisonResult(NSURLQueryItem *obj1, NSURLQueryItem *obj2) {
        return [obj1.name compare:obj2.name];
    }];
    components.queryItems = queryItems;
    path = [path stringByAppendingPathComponent:[components.query gh_escapedFileName]];

    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }

    return [path stringByAppendingPathComponent:requestKey(request)];
}

static void store(NSURLResponse *response, NSData *data, NSURLRequest *request) {
    if (!RECORDING_ENABLED) {
        return;
    }
    if (![response isKindOfClass:[NSHTTPURLResponse class]]
        || ![response.MIMEType containsString:@"application/json"]) {
        return;
    }
    NSString *path = requestPath(request);
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"WARNING: Overwriting file for request %@", request.URL.absoluteString);
    }

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

    RecordedResponse *record = [RecordedResponse new];
    record.data = data;
    record.statusCode = [httpResponse statusCode];
    record.url = response.URL;
    record.headerFields = [httpResponse allHeaderFields];
    [NSKeyedArchiver archiveRootObject:record toFile:requestPath(request)];
}


@interface PlaybackURLProtocol: NSURLProtocol
@end

@interface RecordingURLProtocol: NSURLProtocol
@end

static NSURLSession *recordingSession = nil;

BOOL SetupMockNetworkEnvironment(NSURLSessionConfiguration *config) {
    const BOOL playbackEnabled = [[[NSProcessInfo processInfo] arguments] containsObject:@"--network-playback"];

    if (!RECORDING_ENABLED && !playbackEnabled) {
        return NO;
    }

    if (RECORDING_ENABLED) {
        recordingSession = [NSURLSession sessionWithConfiguration:config];
        config.protocolClasses = @[[RecordingURLProtocol class]];
    }

    if (playbackEnabled) {
        config.protocolClasses = @[[PlaybackURLProtocol class]];
    }

    return YES;
}

@implementation PlaybackURLProtocol {
    NSURLSessionTask *_task;
}

+ (BOOL)canInitWithTask:(NSURLSessionTask *)task {
    return [[NSFileManager defaultManager] fileExistsAtPath:requestPath(task.originalRequest)];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [[NSFileManager defaultManager] fileExistsAtPath:requestPath(request)];
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

    RecordedResponse *record = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:record.url
                                                              statusCode:record.statusCode
                                                             HTTPVersion:(NSString *)kCFHTTPVersion1_1
                                                            headerFields:record.headerFields];
    [self.client URLProtocol:self didLoadData:record.data];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {}

@end

@implementation RecordingURLProtocol {
    NSURLSessionTask *_task;
}

+ (BOOL)canInitWithTask:(NSURLSessionTask *)task {
    return YES;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return YES;
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
    __weak typeof(self) weakSelf = self;
    id<NSURLProtocolClient> client = self.client;
    NSURLRequest *request = _task.originalRequest ?: self.request;
    NSURLSessionDataTask *task = [recordingSession
                                  dataTaskWithRequest:request
                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                      store(response, data, request);
                                      [client URLProtocol:weakSelf didLoadData:data];
                                      [client URLProtocol:weakSelf didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
                                      [client URLProtocolDidFinishLoading:weakSelf];
                                  }];
    [task resume];
}

- (void)stopLoading {}

@end
