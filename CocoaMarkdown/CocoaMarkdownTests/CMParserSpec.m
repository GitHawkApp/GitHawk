@import Quick;
@import Nimble;

#import <CocoaMarkdown/CocoaMarkdown.h>
#import "CMParserTestObject.h"

QuickSpecBegin(CMParserSpec)

__block CMParserTestObject *results = nil;
__block CMDocument *document = nil;

beforeSuite(^{
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"test" ofType:@"md"];
    document = [[CMDocument alloc] initWithContentsOfFile:path options:0];
});

beforeEach(^{
    results = [[CMParserTestObject alloc] initWithDocument:document];
});

it(@"should parse a document", ^{
    [results parse];

    expect(@(results.didEndDocument)).to(equal(@1));
    expect(@(results.didStartDocument)).to(equal(@1));
    expect(@(results.didAbort)).to(equal(@0));
    
    expect(@(results.foundText.count)).to(equal(@23));
    expect(@(results.foundHRule)).to(equal(@1));
    
    expect(results.didStartHeader).to(equal(@[@1, @3]));
    expect(results.didEndHeader).to(equal(@[@1, @3]));
    
    expect(@(results.didStartParagraph)).to(equal(@11));
    expect(@(results.didEndParagraph)).to(equal(@11));
    
    expect(@(results.didStartEmphasis)).to(equal(@2));
    expect(@(results.didEndEmphasis)).to(equal(@2));
    
    expect(@(results.didStartStrong)).to(equal(@2));
    expect(@(results.didEndStrong)).to(equal(@2));
    
    NSArray *links = @[@[[NSURL URLWithString:@"http://indragie.com"], @"Indragie"]];
    expect(results.didStartLink).to(equal(links));
    expect(results.didEndLink).to(equal(links));
    
    NSArray *images = @[@[[NSURL URLWithString:@"https://raw.githubusercontent.com/sonoramac/Sonora/master/screenshot.png"], @"screenshot"]];
    expect(results.didStartImage).to(equal(images));
    expect(results.didEndImage).to(equal(images));
    
    expect(@(results.foundHTML.count)).to(equal(@1));
    expect(@([results.foundHTML[0] hasPrefix:@"<table>"])).to(beTruthy());
    expect(@([results.foundHTML[0] hasSuffix:@"</table>"])).to(beTruthy());
    expect(results.foundInlineHTML).to(equal(@[@"<s>", @"</s>", @"<sup>", @"</sup>", @"<u>", @"</u>"]));
    
    expect(@(results.foundCodeBlock.count)).to(equal(@1));
    expect(results.foundCodeBlock[0][0]).toNot(beNil());
    expect(results.foundCodeBlock[0][1]).to(equal(@"c"));
    expect(results.foundInlineCode).to(equal(@[@"inline code"]));
    
    expect(@(results.foundSoftBreak)).to(equal(@1));
    expect(@(results.foundLineBreak)).to(equal(@1));
    
    expect(@(results.didStartBlockQuote)).to(equal(@1));
    expect(@(results.didEndBlockQuote)).to(equal(@1));
    
    expect(results.didStartUnorderedList).to(equal(@[@YES]));
    expect(results.didEndUnorderedList).to(equal(@[@YES]));
    
    expect(results.didStartOrderedList).to(equal(@[@[@2, @YES]]));
    expect(results.didEndOrderedList).to(equal(@[@[@2, @YES]]));
    
    expect(@(results.didStartListItem)).to(equal(@5));
    expect(@(results.didEndListItem)).to(equal(@5));
});

it(@"should abort parsing", ^{
    results.abortOnStart = YES;
    [results parse];
    
    expect(@(results.didAbort)).to(equal(@1));
    expect(@(results.didEndDocument)).to(equal(@0));
});

QuickSpecEnd
