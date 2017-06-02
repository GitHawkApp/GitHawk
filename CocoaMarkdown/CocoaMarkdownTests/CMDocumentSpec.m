@import Quick;
@import Nimble;

#import <CocoaMarkdown/CocoaMarkdown.h>

QuickSpecBegin(CMDocumentSpec)

describe(@"initialization", ^{
    
    __block NSString *path = nil;
    
    beforeSuite(^{
        path = [[NSBundle bundleForClass:self.class] pathForResource:@"test" ofType:@"md"];
    });
    
    it(@"should initialize from data", ^{
        NSData *data = [NSData dataWithContentsOfFile:path];
        CMDocument *document = [[CMDocument alloc] initWithData:data options:0];
        expect(document.rootNode).toNot(beNil());
    });
    
    it(@"should initialize from a file", ^{
        CMDocument *document = [[CMDocument alloc] initWithContentsOfFile:path options:0];
        expect(document.rootNode).toNot(beNil());
    });
    
    it(@"should not initialize for an invalid file path", ^{
        CMDocument *document = [[CMDocument alloc] initWithContentsOfFile:@"/nonexistent/path" options:0];
        expect(document).to(beNil());
    });
});

QuickSpecEnd
