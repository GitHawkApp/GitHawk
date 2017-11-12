# Change Log
All notable changes to this project will be documented in this file.
`Tabman` adheres to [Semantic Versioning](http://semver.org/).

#### 1.x Releases
- `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101) | [1.0.2](#102) | [1.0.3](#103) | [1.0.4](#104)

#### 0.x Releases
- `0.8.x` Releases - [0.8.0](#080) | [0.8.1](#081) | [0.8.2](#082) | [0.8.3](#083)
- `0.7.x` Releases - [0.7.0](#070) | [0.7.1](#071) | [0.7.2](#072) | [0.7.3](#073)
- `0.6.x` Releases - [0.6.0](#060) | [0.6.1](#061) | [0.6.2](#062)
- `0.5.x` Releases - [0.5.0](#050) | [0.5.1](#051) | [0.5.2](#052) | [0.5.3](#053)
- `0.4.x` Releases - [0.4.0](#040) | [0.4.1](#041) | [0.4.2](#042) | [0.4.3](#043) | [0.4.4](#044) | [0.4.5](#045) | [0.4.6](#046) | [0.4.7](#047) | [0.4.8](#048)

---

## [1.0.5](https://github.com/uias/Pageboy/releases/tag/1.0.5)
Released on 2017-10-23

#### Added
- Added support for `UICollectionViewController` and automatic insetting.
     - by [msaps](https://github.com/msaps).

#### Fixed
- [#109](https://github.com/uias/Tabman/issues/109) Fixed automatic insetting behavior when using a `UITableViewController`.
     - by [msaps](https://github.com/msaps).

## [1.0.4](https://github.com/uias/Pageboy/releases/tag/1.0.4)
Released on 2017-10-22

#### Added
- New `embedBar(in view: UIView)` function to `TabmanViewController`.
     - by [msaps](https://github.com/msaps).

#### Updated
- Deprecated `embedBar(inView view: UIView)` in `TabmanViewController`.
     - by [msaps](https://github.com/msaps).
- Add improved error handling to bar embedding and attachment operations.
     - by [msaps](https://github.com/msaps).

## [1.0.3](https://github.com/uias/Pageboy/releases/tag/1.0.3)
Released on 2017-10-11

#### Added
- [#154](https://github.com/uias/Tabman/issues/154) Support for extending bar background on iPhone X function areas.
     - by [msaps](https://github.com/msaps).
- [#148](https://github.com/uias/Tabman/pull/148) `imageRenderingMode` to `TabmanBar.Appearance.Style`.
     - by [thevest](https://github.com/thevest).

## [1.0.2](https://github.com/uias/Pageboy/releases/tag/1.0.2)
Released on 2017-09-28

#### Added
- `safeAreaInsets` to `TabmanBar.Insets`.
     - by [msaps](https://github.com/msaps).

#### Updated
- Deprecated `topLayoutGuide` in `TabmanBar.Insets`.
     - by [msaps](https://github.com/msaps).
- Deprecated `bottomLayoutGuide` in `TabmanBar.Insets`.
     - by [msaps](https://github.com/msaps).

#### Fixed
- [#146](https://github.com/uias/Tabman/issues/146) Incorrect layout with automatic insetting on iOS 11 and iPhone X.
     - by [msaps](https://github.com/msaps).

## [1.0.1](https://github.com/uias/Pageboy/releases/tag/1.0.1)
Released on 2017-09-18

#### Added
- `context` property to `TabmanBar.Item`.
     - by [Vortec4800](https://github.com/Vortec4800).

#### Updated
- Updated example project styling and improved iPhone X support.
     - by [msaps](https://github.com/msaps).

## [1.0.0](https://github.com/uias/Pageboy/releases/tag/1.0.0)
Released on 2017-09-14

#### Added
- Swift 4 support
    - by [msaps](https://github.com/msaps).
- Support for Xcode 9 and iOS 11.
    - by [msaps](https://github.com/msaps).
- Compatibility for [Pageboy 2](https://github.com/uias/Pageboy/releases/tag/2.0.0).
    - by [msaps](https://github.com/msaps).

---

## [0.8.3](https://github.com/uias/Pageboy/releases/tag/0.8.3)
Released on 2017-09-05

#### Added
- [#135](https://github.com/uias/Tabman/issues/135) Ability to extend background edge insets under system components.
     - Added by [msaps](https://github.com/msaps).
- [#138](https://github.com/uias/Tabman/pull/138) `extendBackgroundEdgeInsets` property to `TabmanBar.Appearance`.
     - Added by [msaps](https://github.com/msaps).

## [0.8.2](https://github.com/uias/Pageboy/releases/tag/0.8.2)
Released on 2017-08-25

#### Fixed
- [#132](https://github.com/uias/Tabman/issues/132) Crash when using `UITableViewController` with auto-insetting enabled.
     - Fixed by [Patrick-Remy](https://github.com/Patrick-Remy).
- Resolved deprecation warnings when using latest Xcode 9 beta.
     - Fixed by [msaps](https://github.com/msaps).

## [0.8.1](https://github.com/uias/Pageboy/releases/tag/0.8.1)
Released on 2017-08-04

#### Fixed
- [#121](https://github.com/uias/Tabman/issues/121) Aligment issues when using a single bar item with `.buttonBar`.
     - Fixed by [msaps](https://github.com/msaps).

## [0.8.0](https://github.com/uias/Pageboy/releases/tag/0.8.0)
Released on 2017-07-25

#### Updated
- Update Pageboy dependency to 1.4.x.
     - Updated by [msaps](https://github.com/msaps).

---

## [0.7.3](https://github.com/uias/Pageboy/releases/tag/0.7.3)
Released on 2017-07-13

#### Updated
- [#108](https://github.com/uias/Tabman/issues/108) Remove lazy variables to fix Carthage linker errors.
     - Fixed by [msaps](https://github.com/msaps).
- Rename `TabmanBarBackgroundView` to `TabmanBar.BackgroundView`.
- Rename `TabmanSeparator` to `Separator`.
- Rename `TabmanCircularView` to `CircularView`.
- Rename `TabmanChevronView` to `ChevronView`.

#### Fixed
- [#115](https://github.com/uias/Tabman/issues/115) Fix text font not being applied to block tab bar.
     - Fixed by [msaps](https://github.com/msaps).

## [0.7.2](https://github.com/uias/Pageboy/releases/tag/0.7.2)
Released on 2017-07-10

#### Fixed
- [#111](https://github.com/uias/Tabman/issues/111) Fix issue with `bottomLayoutGuide` inset when using `UITableViewController`.
     - Fixed by [msaps](https://github.com/msaps).
- [#80](https://github.com/uias/Tabman/issues/80) Fix issue where automatic insetting would incorrectly be re-applied when `hidesBarOnSwipe` was enabled on `UINavigationController`.
     - Fixed by [msaps](https://github.com/msaps).

## [0.7.1](https://github.com/uias/Pageboy/releases/tag/0.7.1)
Released on 2017-06-30

#### Added
- [#106](https://github.com/uias/Tabman/pull/106) Make `TabmanBar.Item` compatible with both an image and title.
     - Added by [thevest](https://github.com/thevest).

#### Fixed
- [#109](https://github.com/uias/Tabman/issues/109) Fix issue where UITableViewController would not automatically inset correctly.
     - Fixed by [msaps](https://github.com/msaps).

## [0.7.0](https://github.com/uias/Pageboy/releases/tag/0.7.0)
Released on 2017-06-24

#### Added
- [#96](https://github.com/uias/Tabman/issues/96) Added compatibility support for iOS 8.
     - Project deployment target is now `8.0`.
     - Added by [farshadmb](https://github.com/farshadmb) & [msaps](https://github.com/msaps).

---

## [0.6.2](https://github.com/uias/Pageboy/releases/tag/0.6.2)
Released on 2017-06-19.

#### Added
- [#77](https://github.com/uias/Tabman/issues/77) Support for Right-To-Left languages.
     - Tabman & Pageboy both now fully support localization for right-to-left language layout.

#### Updated
- Pageboy to `1.2`

#### Fixed
- [#91](https://github.com/uias/Tabman/issues/91) Issue where title labels in `TabmanBar` could appear to be using different font sizes due to incorrect layout compression.

## [0.6.1](https://github.com/uias/Pageboy/releases/tag/0.6.1)
Released on 2017-06-18.

#### Added
- `minimumItemWidth` to `Appearance.Layout`.
     - Allows for specification of the minimum width an item in a scrolling `TabmanBar` must be for display.
     - By AlexZd
- `Item` typealias for `TabmanBar.Item` to `TabmanViewController`.

#### Updated
- Pageboy to `1.1.2`.

## [0.6.0](https://github.com/uias/Pageboy/releases/tag/0.6.0)
Released on 2017-06-14.

#### Added
- `TabmanBarDelegate` delegate property to `TabmanBar.Config`.
- Ability to dictate whether a bar item should be selected.
     - Available via `bar(shouldSelectItemAt index: Int) -> Bool` in `TabmanBarDelegate`.
     - By Fábio Bernardo.
- Ability to hide `TabmanBar` if only one item is provided.
     - Available via `shouldHideWhenSingleItem` in `TabmanBar.Appearance.State`.
     - By Diogo Brito 

#### Updated
- Refactored `TabmanBarItem` to `TabmanBar.Item`.
- Refactored `TabmanBarConfig` to `TabmanBar.Config`.

#### Fixed
- Fixed issue where `useRoundedCorners` would not work on line indicators.
- Fixed issue where bar would incorrectly layout with superview layout changes. 

---

## [0.5.3](https://github.com/uias/Pageboy/releases/tag/0.5.3)
Released on 2017-06-09.

#### Added 
- Added `itemSelected(at index: Int)` function to `TabmanBar`.
     - Informs the `TabmanViewController` that an item in the bar has been selected.
- Added `construct(in contentView: UIView, for items: [TabmanBarItem])` function to `TabmanBarLifecycle`.
- Added `add(indicator: TabmanIndicator, to contentView: UIView)` function to `TabmanBarLifecycle`.

#### Removed
- Removed `constructTabBar(items: [TabmanBarItem])` from `TabmanBarLifecycle`.
- Removed `addIndicatorToBar(indicator: TabmanIndicator)` from `TabmanBarLifecycle`.

## [0.5.2](https://github.com/uias/Pageboy/releases/tag/0.5.2)
Released on 2017-06-07.

#### Updated
- Updated `Pageboy` to `v1.1.0`.

## [0.5.1](https://github.com/uias/Pageboy/releases/tag/0.5.1)
Released on 2017-05-24.

#### Added
- `itemDistribution` property to `TabmanBar.Appearance.Layout`.
     - Allows for centre aligning items within a bar. [#71](https://github.com/uias/Tabman/issues/71)

#### Updated
- Improvements to documentation. 
- Minor refactoring to `TabmanBar.Appearance`.

## [0.5.0](https://github.com/uias/Pageboy/releases/tag/0.5.0)
Released on 2017-05-14.

#### Added
- Added Carthage support [#30](https://github.com/uias/Tabman/issues/30).
- Added automatic child view controller insetting behaviour [#43](https://github.com/uias/Tabman/issues/43). 
     - This will automatically inset any `UIScrollView` content that is present in child view controllers to appear correctly with `TabmanBar`.
     - Enabled by default with the `automaticallyAdjustsChildScrollViewInsets` property on `TabmanViewController`.
- Added `requiredInsets` `TabmanBar.Insets` object to `TabmanBarConfig`.
     - Provides inset values for all components required to manually inset content correctly for a `TabmanBar`.
     - Replaces `requiredContentInset`.

#### Updated
- Added a fresh coat of paint.
- Deprecated `requiredContentInset` on `TabmanBarConfig`.
- Move initialisation logic to `viewDidLoad` from `loadView`.

---

## [0.4.8](https://github.com/uias/Pageboy/releases/tag/0.4.8)
Released on 2017-04-20.

#### Updated
- Pod releases are now locked to a specific version of `Pageboy`.

#### Fixed
- Fixed deprecation warning for `PageboyViewController.PageIndex` API update.
- [#58](https://github.com/uias/Tabman/issues/58) Fixed missing delegate function from `PageboyViewControllerDelegate` API update.

## [0.4.7](https://github.com/uias/Pageboy/releases/tag/0.4.7)
Released on 2017-04-11.

#### Updated
- Updated dependencies.

#### Fixed
- [#51](https://github.com/uias/Tabman/issues/51) Fixed issue with using custom font on bar styles other than `.scrollingButtonBar`. 

## [0.4.6](https://github.com/uias/Pageboy/releases/tag/0.4.6)
Released on 2017-04-06.

#### Updated
- Updated podspec to use latest versions of `Pageboy` which contain numerous fixes.

## [0.4.5](https://github.com/uias/Pageboy/releases/tag/0.4.5)
Released on 2017-04-05.

#### Fixed
- [#50](https://github.com/uias/Tabman/issues/50) Fixed memory retain issue with `TabmanBarConfig` `.delegate` property.

## [0.4.4](https://github.com/uias/Pageboy/releases/tag/0.4.4)
Released on 2017-04-04.

#### Updated
- New artwork and colours for the repo & example app.

#### Fixed
- Fix issue where `requiredContentInset` property on `TabmanViewController.bar` would consistently have incorrect values. 
   - Partial fix for [#42](https://github.com/uias/Tabman/issues/42) - automatic insetting for child view controllers still under development.

## [0.4.3](https://github.com/uias/Pageboy/releases/tag/0.4.3)
Released on 2017-03-30.

#### Added
- Additional tests to improve coverage.

#### Updated
- Updated `interaction.isScrollEnabled` to be `true` by default in `TabmanBar.Appearance`.

#### Fixed
- Fixed issue where internally managed `TabmanBar` could potentially be below other subviews.

## [0.4.2](https://github.com/uias/Pageboy/releases/tag/0.4.2)
Released on 2017-03-28.

#### Added
- New `.buttonBar` style, which features a static button bar with equally distributed spacing.

#### Updated
- Refactored old `.buttonBar` style to `.scrollingButtonBar`. This is the new default style. 
- A few of the previously `public` properties on various `TabmanBar` styles are now `internal`. These should always be updated via the `TabmanBar.Appearance` object.

#### Fixed
- Issues where certain appearance properties were not always adhered to correctly.
- Issues with `compresses` / `bounces` properties in `TabmanBar.Appearance`. New behaviour simply takes `bounces` as precedence and ignores `compresses`. 
- A few minor layout issues that would appear when setting custom layout appearance properties. 

## [0.4.1](https://github.com/uias/Pageboy/releases/tag/0.4.1)
Released on 2017-03-23.

#### Added
- Bottom separator view to `TabmanBar`.
  - This can be customised via `style.bottomSeparatorColor` in `TabmanBar.Appearance`.
- Compressing indicator transition style.
  - Indicator will compress when over scrolling at the end of page ranges rather than bouncing.
  - Enabled via `indicator.compresses` in `TabmanBar.Appearance`.
- Ability to embed internally managed `TabmanBar` in an external view to `TabmanViewController`.
  - Accessible via `embedBar(inView:)` and `disembedBar()`.

#### Updated
- Renamed `.none` to `.clear` in `TabmanBarBackgroundView.BackgroundStyle`.

## [0.4.0](https://github.com/uias/Pageboy/releases/tag/0.4.0)
Released on 2017-03-20.

Initial **Tabman** release - A powerful paging view controller with indicator bar for iOS