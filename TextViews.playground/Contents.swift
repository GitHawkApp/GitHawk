//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let text = NSAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur consectetur enim at justo ultrices dapibus. Nulla sit amet erat sed dui sollicitudin porttitor. Nulla blandit luctus dignissim. In sit amet iaculis orci. Nam sit amet est eu nisl rhoncus rhoncus non at mauris. Nulla sed lacinia sem, id pellentesque lectus. Phasellus imperdiet id arcu ac pretium. Morbi facilisis nibh in massa placerat, at dapibus orci fermentum. Cras id cursus odio. Fusce vulputate tellus sed urna pellentesque vulputate. Praesent rutrum massa leo, nec sagittis augue vestibulum in. Nunc aliquam eros tincidunt, commodo odio sit amet, ultricies ligula. Cras porta sed leo quis gravida. Maecenas vehicula felis purus, at ornare mi aliquet in. Etiam posuere felis id elit fringilla lobortis.\n\nSuspendisse vitae dolor purus. Praesent sit amet eros mi. Mauris nec mollis nulla. Donec commodo, diam sed cursus rhoncus, diam erat dapibus odio, sed laoreet enim risus et arcu. Donec fermentum congue felis, iaculis bibendum nulla tempus vel. Proin ut erat consequat, sollicitudin urna et, lobortis nunc. Nullam lacinia quam massa, condimentum rhoncus quam imperdiet vel.")

struct SizableAttributedString {
    let containerSize: CGSize
    let inset: UIEdgeInsets
    let attributedText: NSAttributedString
    let textViewSize: CGSize

    // NSTextContainer
    let exclusionPaths: [UIBezierPath]
    let maximumNumberOfLines: UInt
    let lineFragmentPadding: CGFloat

    // NSLayoutManager
    let allowsNonContiguousLayout: Bool
    let hyphenationFactor: CGFloat
    let showsInvisibleCharacters: Bool
    let showsControlCharacters: Bool
    let usesFontLeading: Bool

    init(
        containerSize: CGSize,
        attributedText: NSAttributedString,
        inset: UIEdgeInsets = .zero,
        exclusionPaths: [UIBezierPath] = [],
        maximumNumberOfLines: UInt = 0,
        lineFragmentPadding: CGFloat = 0.0,
        allowsNonContiguousLayout: Bool = false,
        hyphenationFactor: CGFloat = 0.0,
        showsInvisibleCharacters: Bool = false,
        showsControlCharacters: Bool = false,
        usesFontLeading: Bool = true
        ) {
        self.containerSize = containerSize
        self.attributedText = attributedText
        self.inset = inset
        self.exclusionPaths = exclusionPaths
        self.maximumNumberOfLines = maximumNumberOfLines
        self.lineFragmentPadding = lineFragmentPadding
        self.allowsNonContiguousLayout = allowsNonContiguousLayout
        self.hyphenationFactor = hyphenationFactor
        self.showsInvisibleCharacters = showsInvisibleCharacters
        self.showsControlCharacters = showsControlCharacters
        self.usesFontLeading = usesFontLeading

        let textContainer = NSTextContainer(size: containerSize)
        textContainer.exclusionPaths = exclusionPaths
        textContainer.maximumNumberOfLines = maximumNumberOfLines
        textContainer.lineFragmentPadding = lineFragmentPadding

        let layoutManager = NSLayoutManager()
        layoutManager.allowsNonContiguousLayout = allowsNonContiguousLayout
        layoutManager.hyphenationFactor = hyphenationFactor
        layoutManager.showsInvisibleCharacters = showsInvisibleCharacters
        layoutManager.showsControlCharacters = showsControlCharacters
        layoutManager.usesFontLeading = usesFontLeading
        layoutManager.addTextContainer(textContainer)

        // storage implicitly required to use NSLayoutManager + NSTextContainer and find a size
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addLayoutManager(layoutManager)

        // find the size of the text now that everything is configured
        let glyphRange = layoutManager.glyphRange(for: textContainer)
        let bounds = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

        // adjust for the text view inset (contentInset + textContainerInset)
        var viewSize = bounds.size
        viewSize.width += inset.left + inset.right
        viewSize.height += inset.top + inset.bottom

        // snap to pixel
        let scale = UIScreen.main.scale
        viewSize.width = ceil(viewSize.width * scale) / scale
        viewSize.height = ceil(viewSize.height * scale) / scale
        self.textViewSize = viewSize
    }

    func configure(textView: UITextView) {
        textView.attributedText = attributedText
        textView.contentInset = inset
        textView.textContainerInset = inset

        let textContainer = textView.textContainer
        textContainer.exclusionPaths = exclusionPaths
        textContainer.maximumNumberOfLines = maximumNumberOfLines
        textContainer.lineFragmentPadding = lineFragmentPadding

        let layoutManager = textView.layoutManager
        layoutManager.allowsNonContiguousLayout = allowsNonContiguousLayout
        layoutManager.hyphenationFactor = hyphenationFactor
        layoutManager.showsInvisibleCharacters = showsInvisibleCharacters
        layoutManager.showsControlCharacters = showsControlCharacters
        layoutManager.usesFontLeading = usesFontLeading
        layoutManager.addTextContainer(textContainer)
    }
}

let size = CGSize(width: 300, height: 500)
let gutter: CGFloat = 10

let containerSize = CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude)
let sizableString = SizableAttributedString(containerSize: containerSize, attributedText: text)

let container = UIView(frame: CGRect(x: 0, y: 0, width: size.width + 2*gutter, height: size.height + 2*gutter))
container.backgroundColor = .blue

let textView = UITextView(frame: CGRect(x: gutter, y: gutter, width: size.width, height: size.width))
container.addSubview(textView)

var frame = textView.frame
frame.size = sizableString.textViewSize
textView.frame = frame

sizableString.configure(textView: textView)

print(textView.frame.height)
print(sizableString.textViewSize.height)
print(textView.sizeThatFits(containerSize).height)

PlaygroundPage.current.liveView = container
