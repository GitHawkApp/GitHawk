## CocoaMarkdown
#### Markdown parsing and rendering for iOS and OS X

CocoaMarkdown is a cross-platform framework for parsing and rendering Markdown, built on top of the [C reference implementation](https://github.com/jgm/CommonMark) of [CommonMark](http://commonmark.org).

**This is currently beta-quality code.**

### Why?

CocoaMarkdown aims to solve two primary problems better than existing libraries:

1. **More flexibility**. CocoaMarkdown allows you to define custom parsing hooks or even traverse the Markdown AST using the low-level API.
2. **Efficient `NSAttributedString` creation for easy rendering on iOS and OS X**. Most existing libraries just generate HTML from the Markdown, which is not a convenient representation to work with in native apps.

### Installation

First you will want to add this project as a submodule to your project:

```
git submodule add https://github.com/indragiek/CocoaMarkdown.git
```

Then, you need to pull down all of its dependencies.

```
cd CocoaMarkdown
git submodule update --init --recursive
```

Next, drag the `.xcodeproj` file from within `CocoaMarkdown` into your project. After that, click on the General tab of your target. Select the plus button under "Embedded Binaries" and select the CocoaMarkdown.framework.

### API

#### Traversing the Markdown AST

[`CMNode`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMNode.h) and [`CMIterator`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMIterator.h) wrap CommonMark's C types with an object-oriented interface for traversal of the Markdown AST.

```swift
let document = CMDocument(contentsOfFile: path, options: nil)
document.rootNode.iterator().enumerateUsingBlock { (node, _, _) in
    print("String value: \(node.stringValue)")
}
```

#### Building Custom Renderers

The [`CMParser`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMParser.h) class isn't _really_ a parser (it just traverses the AST), but it defines an `NSXMLParser`-style delegate API that provides handy callbacks for building your own renderers:

```objective-c
@protocol CMParserDelegate <NSObject>
@optional
- (void)parserDidStartDocument:(CMParser *)parser;
- (void)parserDidEndDocument:(CMParser *)parser;
...
- (void)parser:(CMParser *)parser foundText:(NSString *)text;
- (void)parserFoundHRule:(CMParser *)parser;
...
@end
```

[`CMAttributedStringRenderer`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMAttributedStringRenderer.h) is an example of a custom renderer that is built using this API.

#### Rendering Attributed Strings

[`CMAttributedStringRenderer`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMAttributedStringRenderer.h) is the high level API that will be useful to most apps. It creates an `NSAttributedString` directly from Markdown, skipping the step of converting it to HTML altogether.

Going from a Markdown document to rendering it on screen is as easy as:

```swift
let document = CMDocument(contentsOfFile: path, options: nil)
let renderer = CMAttributedStringRenderer(document: document, attributes: CMTextAttributes())
textView.attributedText = renderer.render()
```

Or, using the convenience method on `CMDocument`:

```swift
textView.attributedText = CMDocument(contentsOfFile: path, options: nil).attributedStringWithAttributes(CMTextAttributes())
```

All attributes used to style the text are customizable using the [`CMTextAttributes`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMTextAttributes.h) class:

```swift
let attributes = CMTextAttributes()
attributes.linkAttributes = [
    NSForegroundColorAttributeName: UIColor.redColor()
]
attributes.emphasisAttributes = [
    NSBackgroundColorAttributeName: UIColor.yellowColor()
]
```

HTML elements can be supported by implementing [`CMHTMLElementTransformer`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMHTMLElementTransformer.h). The framework includes several transformers for commonly used tags:

* [`CMHTMLStrikethroughTransformer`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMHTMLStrikethroughTransformer.h)
* [`CMHTMLSuperscriptTransformer`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMHTMLSuperscriptTransformer.h)
* [`CMHTMLSubscriptTransformer`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMHTMLSubscriptTransformer.h)

Transformers can be registered with the renderer to use them:

```swift
let document = CMDocument(contentsOfFile: path, options: nil)
let renderer = CMAttributedStringRenderer(document: document, attributes: CMTextAttributes())
renderer.registerHTMLElementTransformer(CMHTMLStrikethroughTransformer())
renderer.registerHTMLElementTransformer(CMHTMLSuperscriptTransformer())
textView.attributedText = renderer.render()
```

### Rendering HTML

[`CMHTMLRenderer`](https://github.com/indragiek/CocoaMarkdown/blob/master/CocoaMarkdown/CMHTMLRenderer.h) provides the ability to render HTML from Markdown:

```swift
let document = CMDocument(contentsOfFile: path, options: nil)
let renderer = CMHTMLRenderer(document: document)
let HTML = renderer.render()
```

Or, using the convenience method on `CMDocument`:

```swift
let HTML = CMDocument(contentsOfFile: path).HTMLString()
```

### Example Apps

The project includes example apps for iOS and OS X to demonstrate rendering attributed strings.

### Contact

* Indragie Karunaratne
* [@indragie](http://twitter.com/indragie)
* [http://indragie.com](http://indragie.com)

### License

CocoaMarkdown is licensed under the MIT License. See `LICENSE` for more information.
