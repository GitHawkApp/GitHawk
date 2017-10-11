# GitHawk

[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=59d904ff8588d60001729c4e&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/59d904ff8588d60001729c4e/build/latest?branch=master)

The simplest way to **read** and **respond** to your GitHub notifications on iOS.

<a href=https://itunes.apple.com/app/githawk-for-github/id1252320249><img src=Design/app-store-badge.png width=250></a>

## What

GitHawk is a small iOS app that makes managing GitHub accounts and projects a little easier. It exists because GitHub's mobile interface is missing features and is slow.

It is also proof that you can build rather complicated Swift apps with [IGListKit](https://github.com/Instagram/IGListKit).

## Why

- Push `IGListKit` + Swift to its limits
- Enable project management on mobile
- Explore [GitHub's GraphQL API](https://developer.github.com/v4/)
- Scratch my Swift-itch
- Create a real, complex app in the open

## How

GitHawk will be released with (at least) a three-phased rollout:

1. Basic, "read only" version.
    - Read notifications for PRs and Issues
    - React to comments
    - Mark notifications as read
2. Add replies to PRs and Issues
    - Close, lock, and re-open PRs and Issues
    - Label PRs and Issues
3. Repo management
    - Browse & create Issues
    - Browse PRs
    - Create & delete labels
4. Northstar
    - Browse PR content
    - Accept, reject, and merge PRs
    - :rocket:

## Installation

If you want to build GitHawk locally, run `npm install`. It will install [apollo-codegen](https://github.com/apollographql/apollo-codegen) that is required to generate the
GraphQL models.

## Open Source & Copying

I ship GitHawk on the App Store for free and provide its entire source code for free as well. In the spirit of openness, I have licensed my work under MIT so that you can use my code in your app, if you choose.

However, I ask that you **please do not ship this app** under your own account. Paid or free.

## Contributing

:warning: This repo is moving _fast_! :warning:

If you would like to test the latest changes, you can join the TestFlight by sending your e-mail address to [@_ryannystrom](https://twitter.com/_ryannystrom) in a DM on Twitter.

I'm happy to take PRs, but I'm working off of `master` at the moment, and your PR might go stale quick. Be warned!

You'll also need a [Client ID and Client Secret](Setup.md).

Once this is released and development slows down I might get more formal about our work. Until then, its the wild, wild west.
