#define verifyView(view) \
if (![view isKindOfClass: [UIView class]]) { \
@throw[NSException exceptionWithName: @"Invalid view" reason: [NSString stringWithFormat: @"View is invalid, you must provider a UIView subclass instead of %@", [view class]] userInfo: nil]; \
}\
[self verifyWithView:view function:NSStringFromSelector(_cmd) file:[NSString stringWithFormat:@"%s", __FILE__]];

#define verifyLayer(layer) \
if (![layer isKindOfClass: [CALayer class]]) { \
@throw[NSException exceptionWithName: @"Invalid layer" reason: [NSString stringWithFormat: @"Layer is invalid, you must provider a CALayer subclass instead of %@", [view class]] userInfo: nil]; \
}\
[self verifyWithLayer:layer function:NSStringFromSelector(_cmd) file:[NSString stringWithFormat:@"%s", __FILE__]];
