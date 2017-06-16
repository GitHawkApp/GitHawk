//
//  GithubMarkdownTests.m
//  MMMarkdownTests
//
//  Created by Ryan Nystrom on 6/10/17.
//

#import <XCTest/XCTest.h>

#import "MMParser.h"
#import "MMDocument.h"
#import "MMElement.h"

@interface GithubMarkdownTests : XCTestCase

@end

@implementation GithubMarkdownTests

- (void)test_ {
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Test" ofType:@"md"];
    XCTAssertNotNil(path);
    NSData *data = [NSData dataWithContentsOfFile:path];
    XCTAssertNotNil(data);
    NSString *contents = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    MMParser *parser = [[MMParser alloc] initWithExtensions:MMMarkdownExtensionsGitHubFlavored];
    NSError *error = nil;
    MMDocument *document = [parser parseMarkdown:contents error:&error];
    XCTAssertNil(error);

    for (MMElement *el in document.elements) {
        NSLog(@"PARENT - %@", el);
        for (MMElement *child in el.children) {
            NSLog(@"    %@", child);
        }
    }
}

@end
