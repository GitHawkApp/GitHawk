# Appearance

There are extensive options available in Tabman to customise the component to your liking. These are divided into appropriate functional structures:

- **[Indicator](#indicator)**
- **[Interaction](#interaction)**
- **[Layout](#layout)**
- **[State](#state)**
- **[Style](#style)**
- **[Text](#text)**

## Indicator
Customise how the indicator looks and behaves.

```swift
bar.appearance.indicator
```

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `preferredStyle` | `TabmanIndicator.Style` | The preferred style to use for the indicator (optionally conformed to by the bar). | `nil` |
| `color` | `UIColor` | The color of the bar indicator. | `tintColor` |
| `lineWeight` | `TabmanIndicator.LineWeight` | The weight (thickness) of the bar indicator if using a line indicator. | `.normal` |
| `isProgressive` | `Bool` | Whether the indicator transiton is progressive. | `false` |
| `bounces` | `Bool` | Whether the indicator bounces at the end of page ranges. | `false` |
| `compresses` | `Bool` | Whether the indicator compresses at the end of page ranges (Unavailable if bounces enabled). | `false` |
| `useRoundedCorners` | `Bool` | Whether to use rounded corners on line indicators. | `false` |


## Interaction
Customise how the bar can be interacted with.

```swift
bar.appearance.interaction
```

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `isScrollEnabled` | `Bool` | Whether user scroll is enabled on a scrolling button bar. | `true` |


## Layout
Customise how the bar lays itself and its items out.

```swift
bar.appearance.layout
```

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `interItemSpacing` | `CGFloat` | The spacing between items in the bar. | `20.0` |
| `edgeInset` | `CGFloat` | The spacing at the edge of the items in the bar. | `16.0` |
| `height` | `TabmanBar.Height` | The height for the bar. | `.auto` |
| `itemVerticalPadding` | `CGFloat` | The vertical padding between the item and the bar bounds. | `12.0` |
| `itemDistribution` | `ItemDistribution` | How items in the bar should be distributed. | `.leftAligned` |
| `minimumItemWidth` | `CGFloat` | The minimum width for an item. | `44.0` |
| `extendBackgroundEdgeInsets` | `Bool` | Whether to extend the background edge insets in certain scenarios. | `true` |

## State
Customise how the bar should react to state changes.

```swift
bar.appearance.state
```

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `selectedColor` | `UIColor` | The color to use for selected items in the bar (text/images etc.). | `.black` |
| `color` | `UIColor` | The text color to use for unselected items in the bar (text/images etc.). | `.black.withAlphaComponent(0.5)` |


## Style
Customise any stylistic appearance properties of the bar.

```swift
bar.appearance.style
```

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `background` | `TabmanBarBackgroundView.BackgroundStyle` | The background style for the bar. | `.blur(style: .extraLight)` |
| `showEdgeFade` | `Bool` | Whether to show a fade on the items at the bounds edge of a scrolling button bar. | `false` |
| `bottomSeparatorColor` | `UIColor` | Color of the separator at the bottom of the bar. | `.clear` |


## Text
Customise any text displayed in a bar.

```swift
bar.appearance.text
```

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `font` | `UIFont` | The font to use for text labels in the bar. | `.systemFont(ofSize: 16.0)` |



