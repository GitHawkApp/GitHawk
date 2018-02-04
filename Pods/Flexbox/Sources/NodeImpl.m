#import "NodeImpl.h"

static YGSize measureNode(YGNodeRef node, float width, YGMeasureMode widthMode, float height, YGMeasureMode heightMode)
{
    NodeImpl *self = (__bridge NodeImpl *)YGNodeGetContext(node);
    CGSize size = self.measure(CGSizeMake(width, height));
    return (YGSize){ size.width, size.height };
}

static void YGRemoveAllChildren(const YGNodeRef node)
{
    if (node == NULL) {
        return;
    }

    while (YGNodeGetChildCount(node) > 0) {
        YGNodeRemoveChild(node, YGNodeGetChild(node, YGNodeGetChildCount(node) - 1));
    }
}

@implementation NodeImpl

- (void)dealloc
{
    YGNodeFree(_node);
}

- (id)init
{
    self = [super init];
    if (self == nil) return nil;

    _node = YGNodeNew();
    YGNodeSetContext(_node, (__bridge void *)self);

    return self;
}

- (void)setChildren:(NSArray *)children
{
    _children = [children copy];

    YGRemoveAllChildren(_node);

    for (int i = 0; i < children.count; i++) {
        YGNodeInsertChild(_node, [children[i] node], i);
    }
}

- (void)layout
{
    [self layoutWithMaxSize:CGSizeMake(NAN, NAN)];
}

- (void)layoutWithMaxSize:(CGSize)maxSize
{
    YGNodeCalculateLayout(_node,
                          maxSize.width,
                          maxSize.height,
                          YGNodeStyleGetDirection(_node));
}

- (CGRect)frame
{
    CGRect frame = (CGRect) {
        .origin = {
            .x = YGNodeLayoutGetLeft(_node),
            .y = YGNodeLayoutGetTop(_node),
        },
        .size = {
            .width = YGNodeLayoutGetWidth(_node),
            .height = YGNodeLayoutGetHeight(_node),
        },
    };
    return frame;
}

- (void)setMeasure:(CGSize (^)(CGSize))measure
{
    _measure = [measure copy];

    YGNodeSetMeasureFunc(_node, (_measure != nil ? measureNode : NULL));
}

@end
