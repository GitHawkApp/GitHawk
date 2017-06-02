@import Quick;
@import Nimble;

#import <CocoaMarkdown/CocoaMarkdown.h>
#import "CMNode_Private.h"

QuickSpecBegin(CMIteratorSpec)

it(@"should initialize", ^{
    CMNode *node = [[CMNode alloc] initWithNode:cmark_node_new(CMARK_NODE_PARAGRAPH) freeWhenDone:YES];
    CMIterator *iter = [[CMIterator alloc] initWithRootNode:node];
    expect(iter).toNot(beNil());
});

it(@"should traverse a node tree", ^{
    CMNode *parent = [[CMNode alloc] initWithNode:cmark_node_new(CMARK_NODE_DOCUMENT) freeWhenDone:YES];
    
    cmark_node *paragraph1 = cmark_node_new(CMARK_NODE_PARAGRAPH);
    cmark_node *paragraph2 = cmark_node_new(CMARK_NODE_PARAGRAPH);
    cmark_node_append_child(parent.node, paragraph1);
    cmark_node_append_child(parent.node, paragraph2);
    
    CMIterator *iter = [[CMIterator alloc] initWithRootNode:parent];
    
    __block NSInteger nodeCount = 0;
    __block NSInteger eventBalance = 0;
    [iter enumerateUsingBlock:^(CMNode *node, CMEventType event, BOOL *stop) {
        switch (event) {
            case CMARK_EVENT_ENTER:
                eventBalance++;
                break;
            case CMARK_EVENT_EXIT:
                eventBalance--;
                nodeCount++;
                break;
            default: break;
        }
        if (nodeCount == 2) *stop = YES;
    }];
    
    expect(@(nodeCount)).to(equal(@2));
    expect(@(eventBalance)).to(equal(@1));
    
    [iter resetToNode:parent withEventType:CMEventTypeEnter];
    expect(iter.currentNode).to(equal(parent));
    expect(@(iter.currentEvent)).to(equal(@(CMARK_EVENT_ENTER)));
});

QuickSpecEnd
