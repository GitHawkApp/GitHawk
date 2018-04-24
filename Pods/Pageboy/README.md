<p align="center">
    <img src="Artwork/logo.png" width="890" alt="Pageboy"/>
</p>

<p align="center">
    <a href="https://travis-ci.org/uias/Pageboy">
        <img src="https://travis-ci.org/uias/Pageboy.svg?branch=master" />
    </a>
    <img src="https://img.shields.io/badge/Swift-4-orange.svg?style=flat" />
    <a href="https://cocoapods.org/pods/Pageboy">
        <img src="https://img.shields.io/cocoapods/v/Pageboy.svg" alt="CocoaPods" />
    </a>
	<a href="https://cocoapods.org/pods/Pageboy">
        <img src="https://img.shields.io/cocoapods/p/Pageboy.svg" alt="Platforms" />
    </a>
	<a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" />
    </a>
	<a href="https://codecov.io/gh/uias/Pageboy">
        <img src="https://codecov.io/gh/uias/Pageboy/branch/master/graph/badge.svg" />
    </a>
	<a href="https://github.com/uias/Pageboy/releases">
        <img src="https://img.shields.io/github/release/uias/Pageboy.svg" />
    </a>
</p>

**TL;DR** *UIPageViewController done properly.*

**Pageboy** is a simple, highly informative page view controller.

## ⭐️ Features
- [x] Simplified data source management.
- [x] Enhanced delegation; featuring exact relative positional data and reliable updates.
- [x] Infinite scrolling support.
- [x] Automatic timer-based page transitioning.
- [x] Support for custom page transitions.

## 📋 Requirements
Pageboy requires iOS 9 / tvOS 10 or above; and is written in Swift 4.

## 📲 Installation
### CocoaPods
Pageboy is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:
```ruby
pod 'Pageboy', '~> 2.0'
```
And run `pod install`.

### Carthage
Pageboy is available through [Carthage](https://github.com/Carthage/Carthage). Simply install carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

Add Pageboy to your `Cartfile`:

```ogdl
github "uias/Pageboy" ~> 2.0
```

## 🚀 Usage
### Getting Started

1) Create an instance of a `PageboyViewController` and provide it with a `PageboyViewControllerDataSource`.

```swift
class PageViewController: PageboyViewController, PageboyViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
	
	self.dataSource = self
    }
}
```

2) Implement the `PageboyViewControllerDataSource` functions.

```swift
func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
    return viewControllers.count
}
    
func viewController(for pageboyViewController: PageboyViewController,
                    at index: PageboyViewController.PageIndex) -> UIViewController? {
    return viewControllers[index]
}
    
func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
    return nil
}
```

3) Enjoy.

### Delegation

Unfortunately, `UIPageViewController` doesn't provide the most useful delegate methods for detecting positional data. `PageboyViewControllerDelegate` provides a number of functions for being able to detect where the page view controller is, and where it's headed.

#### willScrollToPageAtIndex
The page view controller is about to embark on a transition to a new page.

```swift
func pageboyViewController(_ pageboyViewController: PageboyViewController,
                           willScrollToPageAt index: Int,
                           direction: PageboyViewController.NavigationDirection,
                           animated: Bool)
```

#### didScrollToPosition
The page view controller was scrolled to a relative position along the way transitioning to a new page. Also provided is the direction of the transition.

```swift
func pageboyViewController(_ pageboyViewController: PageboyViewController,
                           didScrollTo position: CGPoint,
                           direction: PageboyViewController.NavigationDirection,
                           animated: Bool)
```

#### didScrollToPage
The page view controller has successfully completed a scroll transition to a page.

```swift
func pageboyViewController(_ pageboyViewController: PageboyViewController,
                           didScrollToPageAt index: Int,
                           direction: PageboyViewController.NavigationDirection,
                           animated: Bool)
```

#### didReload
The page view controller has reloaded its child view controllers.

```swift
func pageboyViewController(_ pageboyViewController: PageboyViewController,
                           didReloadWith currentViewController: UIViewController,
                           currentPageIndex: PageboyViewController.PageIndex)
```

## ⚡️ Extras

- `reloadPages()` - Reload the view controllers in the page view controller. (Refreshes the data source).
- `scrollToPage()` - Scroll the page view controller to a new page programatically.

	```swift
	public func scrollToPage(_ pageIndex: PageIndex,
                               animated: Bool,
                               completion: PageTransitionCompletion? = nil)
	```
- `.navigationOrientation` - Whether to orientate the pages horizontally or vertically.
- `.isScrollEnabled` - Whether or not scrolling is allowed on the page view controller.
- `.isInfiniteScrollEnabled` - Whether the page view controller should infinitely scroll at the end of page ranges.
- `.currentViewController` - The currently visible view controller if it exists.
- `.currentPosition` - The exact current relative position of the page view controller.
- `.currentIndex` - The index of the currently visible page.
- `.showsPageControl` - Whether to show the built-in page control.
- `.parentPageboy` - Access the parent `PageboyViewController` from any child `UIViewController`.
    ```swift
    class ChildViewController: UIViewController {

        func doSomething() {
            parentPageboy?.scrollToPage(.next, animated: true)
        }
    }
    ```

### Transitioning
Pageboy also provides custom animated transition support. This can be customised via the `.transition` property on `PageboyViewController`. 

```swift
pageboyViewController.transition = Transition(style: .push, duration: 1.0)
```

The following styles are available: 

- `.push`
- `.fade`
- `.moveIn`
- `.reveal`

*Note: By default this is set to `nil`, which uses the standard animation provided by `UIPageViewController`.*

### Auto Scrolling
`PageboyAutoScroller` is available to set up timer based automatic scrolling of the `PageboyViewController`:

```swift
pageboyViewController.autoScroller.enable()
```
Support for custom intermission duration and other scroll behaviors is also available.

## 👨🏻‍💻 About
- Created by [Merrick Sapsford](https://github.com/msaps) ([@MerrickSapsford](https://twitter.com/MerrickSapsford))
- Contributed to by a growing [list of others](https://github.com/uias/Pageboy/graphs/contributors).

## ❤️ Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/uias/Pageboy](https://github.com/uias/Pageboy).

## 👮🏻‍♂️ License
The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
