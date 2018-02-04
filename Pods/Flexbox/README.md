# Flexbox

Swift wrapper of [facebook/yoga](https://github.com/facebook/yoga), a cross-platform CSS Flexbox layout engine that is lightweight, runs asynchronously, and is far simpler than AutoLayout.

If you are new to CSS Flexbox, visit following links and have fun :)

- [CSS Flexible Box Layout Module Level 1](https://www.w3.org/TR/css-flexbox/)
- [CSS Flexible Box Layout - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout)
- [A Complete Guide to Flexbox | CSS-Tricks](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)


## Example

```swift
let node = Node(
    size: CGSize(width: 300, height: 100),
    children: [
        Node(size: CGSize(width: 20, height: 20)),
        Node(size: CGSize(width: 40, height: 80)),
        Node(size: CGSize(width: 60, height: 40)),
    ],
    flexDirection: .row,
    justifyContent: ... // .flexStart, .center, .flexEnd, .spaceBetween, .spaceAround
)

let view = ... // prepare view hierarchy

DispatchQueue.global.async {
    let layout = node.layout()

    DispatchQueue.main.async {
        layout.apply(view)
    }
}
```

This will result:

<img src="Assets/JustifyContent.png" width="300">

Please see [FlexboxPlayground](FlexboxPlayground.playground) for more examples.


## Acknowledgement

The original idea is from [joshaber/SwiftBox](https://github.com/joshaber/SwiftBox).


## License

[MIT](LICENSE)
