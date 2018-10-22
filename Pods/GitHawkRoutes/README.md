# GitHawkRoutes

Strongly-typed deep-links _into_ GitHawk.

## Installation

Just add `GitHawkRoutes` to your Podfile and pod install. Done!

```
pod 'GitHawkRoutes'
```

## Usage

Create one of the available routes:

```swift
import GitHawkRoutes

let repo = RepoRoute(
  owner: "GitHawkApp",
  repo: "GitHawk",
  branch: "master"
)
```

Then simply use our `UIApplication` extension to have your app open GitHawk:

```swift
UIApplication.shared.open(githawk: repo)
```

Really, that's it!

> Beware using the `master` branch of this repo as the App Store version of GitHawk may be behind. In that case, the route will just open GitHawk.

## Acknowledgements

- Created with ❤️ by [Ryan Nystrom](https://twitter.com/_ryannystrom)