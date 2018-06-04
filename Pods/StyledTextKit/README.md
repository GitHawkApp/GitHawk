<p align="center">
  <img src="/images/banner.png" />
</p>

`StyledTextKit` is a declarative building and fast rendering attributed string library. It serves as a replacement to `NSAttributedString` and `UILabel` for background-thread size and bitmap caching.

## Features

- Declarative attributed string building API
- Find text sizes on a background thread without sanitizer warnings
- Cache rendered text bitmaps for improved performance
- Custom attribute interaction handling (link taps, etc)

## Installation

Just add `StyledTextKit` to your Podfile and install. Done!

```ruby
pod 'StyledTextKit'
```

## Usage

### Building `NSAttributedString`s

`StyledTextKit` lets you build complex `NSAttributedString`s by combining:

- Add `NSAttributedString`s or `String`s and continue using the previous attributes, saving you from repetitive `.font` and `.foregroundColor` styling
- Intermix complex font traits like **bold** and _italics_ to get _**bold italics**_.
- Handle dynamic text size at string render time. Let's you build the string once and re-render it on device text-size changes.
- Call `save()` and `restore()` to push/pop style settings, letting you build complex test styles without complex code.

```swift
let attributedString = StyledTextBuilder(text: "Foo ")
  .save()
  .add(text: "bar", traits: [.traitBold])
  .restore()
  .add(text: " baz!")
  .build()
  .render(contentSizeCategory: .large)
```

> Foo **bar** baz!

The basic steps are:

- Create a `StyledTextBuilder`
- Add `StyledText` objects
- Call `build()` when finished to generate a `StyledTextString` object
- Call `render(contentSizeCategory:)` to create an `NSAttributedString`

### Rendering Text Bitmaps

Create a `StyledTextRenderer` for sizing and rendering text by initialize it with a `StyledTextString` and a `UIContentSizeCategory`.

```swift
let renderer = StyledTextRenderer(
    string: string,
    contentSizeCategory: .large
  )
```

Once created, you can easily get the size of the text constrained to a width:

```swift
let size = renderer.size(in: 320)
```

You can also get a bitmap of the text:

```swift
let result = renderer.render(for: 320)
view.layer.contents = result.image
```

### StyledTextView

To make rendering and layout of text in a `UIView` simpler, use `StyledTextView` to manage display as well as interactions. All you need is a `StyledTextRenderer` and a width and you're set!

```swift
let view = StyledTextView()
view.configure(with: renderer, width: 320)
```

Set a delegate on the view to handle tap and long presses:

```swift
view.delegate = self

// StyledTextViewDelegate
func didTap(view: StyledTextView, attributes: [NSAttributedStringKey: Any], point: CGPoint) {
  guard let link = attributes[.link] else { return }
  show(SFSafariViewController(url: link))
}
```

## Background Rendering

`StyledTextKit` exists to do background sizing and rendering of text content so that scrolling large amounts of text is buttery smooth. The typical pipeline to do this is:

1. Get the current width and `UIContentSizeCategory`
2. Go to a background queue
3. Build text
4. Warm caches
5. Return to the main queue
6. Configure your views

```swift
// ViewController.swift

let width = view.bounds.width
let contentSizeCategory = UIApplication.shared.preferredContentSizeCategory

DispatchQueue.global().async {
  let builder = StyledTextBuilder(...)
  let renderer = StyledTextRenderer(text: builder.build(), contentSizeCategory: contentSizeCategory)
    .warm() // warms the size cache

  DispatchQueue.main.async {
    self.textView.configure(with: renderer, width: width)
  }
}
```

## FAQ

> Why not use `UITextView`?

Prior to iOS 7, `UITextView` just used WebKit under the hood and was terribly slow. Now that it uses TextKit, it's significantly faster but still requires all sizing and rendering be done on the main thread.

For apps with lots of text embedded in `UITableViewCell`s or `UICollectionViewCell`s, `UITextView` bring scrolling to a grinding halt.

## Acknowledgements

- [@ocrickard](https://github.com/ocrickard) who built [ComponentTextKit](https://github.com/facebook/componentkit/tree/master/ComponentTextKit) and taught me the basics.
- Created with ❤️ by [Ryan Nystrom](https://twitter.com/_ryannystrom)
