<p align="center">
    <img src="Artwork/logo.png" width="890" alt="Pageboy"/>
</p>

[![Build Status](https://travis-ci.org/uias/Pageboy.svg?branch=master)](https://travis-ci.org/uias/Pageboy)
[![Swift 4](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![CocoaPods](https://img.shields.io/cocoapods/v/Pageboy.svg)]()
[![Platforms](https://img.shields.io/cocoapods/p/Pageboy.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/uias/Pageboy/branch/master/graph/badge.svg)](https://codecov.io/gh/uias/Pageboy)
[![GitHub release](https://img.shields.io/github/release/uias/Pageboy.svg)](https://github.com/uias/Pageboy/releases)

**TL;DR** *UIPageViewController done properly.*

**Pageboy** is a simple, highly informative page view controller.

## Features
- [x] Simplified data source management.
- [x] Enhanced delegation; featuring exact relative positional data and reliable updates.
- [x] Infinite scrolling support.
- [x] Automatic timer-based page transitioning.
- [x] Support for custom page transitions.

## Requirements
Pageboy requires iOS 8.0 / tvOS 10.0 and Swift 4.0 or above.

For Swift 3.x support, please use the latest [1.x release](https://github.com/uias/Pageboy/releases/tag/1.4.1) (For 1.x legacy API docs, see [here](https://github.com/uias/Pageboy/blob/1.4.0/README.md)).

## Installation
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

## Usage
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

`UIPageViewController` doesn't provide the most useful delegate methods for detecting where you are when paging; this is where Pageboy comes in. `PageboyViewControllerDelegate` provides a number of functions for being able to detect where the page view controller is, and where it's headed.

#### willScrollToPageAtIndex
Called when the page view controller is about to embark on a transition to a new page.

```swift
func pageboyViewController(_ pageboyViewController: PageboyViewController,
                           willScrollToPageAt index: Int,
                           direction: PageboyViewController.NavigationDirection,
                           animated: Bool)
```

#### didScrollToPosition
Called when the page view controller was scrolled to a relative position along the way transitioning to a new page. Also provided is the direction of the transition.

```swift
func pageboyViewController(_ pageboyViewController: PageboyViewController,
                           didScrollTo position: CGPoint,
                           direction: PageboyViewController.NavigationDirection,
                           animated: Bool)
```

#### didScrollToPage
Called when the page view controller did successfully complete a scroll transition to a page.

```swift
func pageboyViewController(_ pageboyViewController: PageboyViewController,
                           didScrollToPageAt index: Int,
                           direction: PageboyViewController.NavigationDirection,
                           animated: Bool)
```

#### didReload
Called when the page view controller reloads its child view controllers.

```swift
func pageboyViewController(_ pageboyViewController: PageboyViewController,
                           didReloadWith currentViewController: UIViewController,
                           currentPageIndex: PageboyViewController.PageIndex)
```

## Other useful stuff

- `reloadPages` - Reload the view controllers in the page view controller. (Refreshes the data source).

	```swift
	public func reloadPages()
	```
- `scrollToPage` - Scroll the page view controller to a new page programatically.

	```swift
	public func scrollToPage(_ pageIndex: PageIndex,
                               animated: Bool,
                               completion: PageTransitionCompletion? = nil)
	```
- `isScrollEnabled` - Whether or not scrolling is allowed on the page view controller.
- `isInfiniteScrollEnabled` - Whether the page view controlelr should infinitely scroll at the end of page ranges.
- `currentViewController` - The currently visible view controller if it exists.
- `currentPosition` - The exact current relative position of the page view controller.
- `currentIndex` - The index of the currently visible page.

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

### Auto Scrolling
`PageboyAutoScroller` is available to set up timer based automatic scrolling of the `PageboyViewController`:

```swift
pageboyViewController.autoScroller.enable()
```
Support for custom intermission duration and other scroll behaviors is also available.

## About
- Created by [Merrick Sapsford](https://github.com/msaps) ([@MerrickSapsford](https://twitter.com/MerrickSapsford))
- Contributed to by a growing [list of others](https://github.com/uias/Pageboy/graphs/contributors).

## Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/uias/Pageboy](https://github.com/uias/Pageboy).

## License
The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
