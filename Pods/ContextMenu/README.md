<p align="center">
  <img src="/images/animation.gif" />
</p>

- Contextual menus with delightful animations and styles
- Total control over menu contents using your own `UIViewController`s
- Tons of feature and interaction customizations

## Installation

Just add `ContextMenu` to your Podfile and `pod install`. Done!

```ruby
pod 'ContextMenu'
```
For Carthage, just add `GitHawkApp/ContextMenu` to your Cartfile and `carthage bootstrap`.
```ogdl
github "GitHawkApp/ContextMenu"
```

## Usage

Show the menu from one of your `UIViewController`s:

```swift
ContextMenu.shared.show(
  sourceViewController: self,
  viewController: MyContentViewController()
)
```

You must provide a custom `UIViewController` to display in the menu. The only requirement is that you must set `preferredContentSize` to size your content.

```swift
class MyContentViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Demo"
    preferredContentSize = CGSize(width: 200, height: 200)
  }
}
```

<img src="/images/basic.png" />

## Customizations

### Display from a Source View

Animate the menu out from a button or view. `ContextMenu` will take care of layout so that your menu doesn't clip the screen.

```swift
@IBAction func onButton(_ sender: UIButton) {
  ContextMenu.shared.show(
    sourceViewController: self,
    viewController: MyContentViewController(),
    sourceView: sender
  )
}
```

### Container Style & Display

Use `ContextMenu.Options` to change the appearance of the containing view.

```swift
ContextMenu.shared.show(
  sourceViewController: self,
  viewController: MenuViewController(),
  options: ContextMenu.Options(containerStyle: ContextMenu.ContainerStyle(backgroundColor: .blue)),
  sourceView: button
)
```

<img src="/images/blue.png" />

There's plenty more you can customize with `ContextMenu.ContainerStyle`:

- `cornerRadius`: The corner radius of the menu
- `shadowRadius` and `shadowOpacity`: Appearance of the container shadow
- `xPadding`, `yPadding`, `edgePadding`: Padding from the source view and screen edge
- `overlayColor`: The color of the background
- `motionEffect`: Respond to device gyroscope changes, similar to app icons on Springboard.app.

If you want more customizations, we will gladly accept a Pull Request!

## Acknowledgements

- Inspiration from [Things 3](https://culturedcode.com/things/)
- Created with ❤️ by [Ryan Nystrom](https://twitter.com/_ryannystrom)