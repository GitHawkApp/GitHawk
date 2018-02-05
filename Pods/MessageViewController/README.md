<p align="center">
  <img src="/animation.gif" />
</p>

## Installation

Just add `MessageViewController` to your Podfile and install. Done!

```ruby
pod 'MessageViewController'
```

## Setup

You must subclass `MessageViewController`.

```swift
import MessageViewController

class ViewController: MessageViewController {
  // ...
}
```

Finish setup using a `UIScrollView`. Remember this can also be a `UITableView` or `UICollectionView`.

```swift
func viewDidLoad() {
  super.viewDidLoad()
  setup(scrollView: scrollView)
}
```

## Customizations

You can customize any part of the UI that you want!

```swift
// Border between the text view and the scroll view
borderColor = .lightGray

// Change the appearance of the text view and its content
messageView.inset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
messageView.textView.placeholderText = "New message..."
messageView.textView.placeholderTextColor = .lightGray
messageView.font = .systemFont(ofSize: 17)

// Setup the button using text or an icon
messageView.set(buttonTitle: "Send", for: .normal)
messageView.addButton(target: self, action: #selector(onButton))
messageView.buttonTint = .blue

// Set custom attributes for an autocompleted string
let tintColor = .blue
messageAutocompleteController.autocompleteTextAttributes = ["@": [.font: UIFont.preferredFont(forTextStyle: .body), .foregroundColor: tintColor, .backgroundColor: tintColor.withAlphaComponent(0.1)]]
```

## Autocomplete

The base view controller uses a `MessageAutocompleteController` control to handle text autocompletion.

This control uses a plain `UITableView` to display its autocomplete. Add a `dataSource` and `delegate` to display and handle interactions.

```swift
let tableView = messageAutocompleteController.tableView
tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
tableView.dataSource = self
tableView.delegate = self
```

Then register for autocomplete prefixes you want to respond to and set a `delegate` to handle when a prefix is found.

```swift
messageAutocompleteController.register(prefix: "@")
messageAutocompleteController.delegate = self
```

Your delegate needs to implement just one method.

```swift
func didFind(controller: MessageAutocompleteController, prefix: String, word: String) {
  // filter your data
  controller.show(true)
}
```

> **Note:** You can perform asyncronous autocomplete searches. Just be sure to call `messageAutocompleteController.show()` when finished.

## Acknowledgements

- Heavy inspiration from [SlackTextViewController](https://github.com/slackhq/SlackTextViewController)
- Created with ❤️ by [Ryan Nystrom](https://twitter.com/_ryannystrom)
