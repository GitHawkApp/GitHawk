Toaster
=======

[![Build Status](https://travis-ci.org/devxoul/Toaster.svg?branch=master)](https://travis-ci.org/devxoul/Toaster)
![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/Toaster.svg?style=flat)](http://cocoapods.org/?q=name%3AToaster%20author%3Adevxoul)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Android-like toast with very simple interface. (formerly JLToast)

Toaster is written in Swift 3.0. If you're looking for Swift 2 compatible version, see the [JLToast 1.4.2](https://github.com/devxoul/JLToast/tree/1.4.2).


Features
--------

- **Queueing**: Centralized toast center manages the toast queue.
- **Customizable**: See the [Appearance](#appearance) section.


At a Glance
-----------

```swift
import Toaster

Toast(text: "Hello, world!").show()
```


Installation
------------

- **For iOS 8+ projects with [CocoaPods](https://cocoapods.org):**

    ```ruby
    pod 'Toaster'
    ```

- **For iOS 8+ projects with [Carthage](https://github.com/Carthage/Carthage):**

    ```
    github "devxoul/Toaster"
    ```


Getting Started
---------------

### Setting Duration and Delay

```swift
Toast(text: "Hello, world!", duration: Delay.long)
Toast(text: "Hello, world!", delay: Delay.short, duration: Delay.long)
```

### Removing Toasts

- **Removing toast with reference**:

    ```swift
    let toast = Toast(text: "Hello")
    toast.show()
    toast.cancel() // remove toast immediately
    ```
    
- **Removing current toast**:

    ```swift
    if let currentToast = ToastCenter.default.currentToast {
        currentToast.cancel()
    }
    ```
    
- **Removing all toasts**:

    ```swift
    ToastCenter.default.cancelAll()
    ```

### Appearance

Since Toaster 2.0.0, you can use `UIAppearance` to set default appearance. This is an short example to set default background color to red.

```swift
ToastView.appearance().backgroundColor = .red
```


Supported appearance properties are:

| Property | Type | Description |
|---|---|---|
| `backgroundColor` | `UIColor` | Background color |
| `cornerRadius` | `CGFloat` | Corner radius |
| `textInsets` | `UIEdgeInsets` | Text inset |
| `textColor` | `UIColor` | Text color |
| `font` | `UIFont` | Font |
| `bottomOffsetPortrait` | `CGFloat` | Vertical offfset from bottom in portrait mode |
|` bottomOffsetLandscape` | `CGFloat` | Vertical offfset from bottom in landscape mode |


Screenshots
-----------

![Toaster Screenshot](https://raw.github.com/devxoul/Toaster/master/Screenshots/Toaster.png)


License
-------

Toaster is under [WTFPL](http://www.wtfpl.net/). You can do what the fuck you want with Toast. See [LICENSE](LICENSE) file for more info.
