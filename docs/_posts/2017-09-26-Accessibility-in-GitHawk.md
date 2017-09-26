---
layout: post
title: Accessibility in GitHawk
---

Supporting accessibility is often overlooked in apps. Either it's not thought about, a client doesn't know about (or cannot quantify) its benefits, or the developers haven't had enough experience using those features to be able to see the huge impact it can have.

All in all, most of the time there is an "excuse" for not taking the time to get accessibility right. 

## The Importance of Accessibility 

Everyone is different. People use apps - or devices, even - the way they feel works best for them. That includes people that might have difficulty using an app like you are used to. Some use dynamic type to make text across the whole OS bigger - or smaller. Others want to reduce motion or increase contrast. 

If you haven't yet, go and try these features at some point, and see how the system apps (and Springboard) apply these changes. Then try some 3rd party apps and see if you can tell the difference (spoiler: you can).

For example, a blind users can browse Photos.app and get a description of a picture or video. In Camera.app, you can get audio feedback of your viewport: how many people are detected, if they’re smiling etc.

## Accessibility in GitHawk 

GitHawk still has a way to go to make it a truly accessible app, but it already makes an impact by caring - and starting somewhere.

For example, we are supporting VoiceOver features throughout the app, so you can browse the app and get feedback via audio. Things like `UILabel`, `UIButton` and friends support this automatically, but `UICollectionViewCell` for example, does not. This is where you might want to put in effort to create better cells. 

In GitHawk, a NotificationCell has a number of labels: the repository title, the issue title, a “time ago” label, and an image (indicating either a Pull Request or an Issue).

These would all be separately accessible. We've changed this so the cell is one accessible element [(and has a button trait)](https://github.com/rnystrom/GitHawk/blob/master/Classes/Notifications/NotificationCell.swift), and in turn converting all these labels [into one string](https://github.com/rnystrom/GitHawk/blob/master/Classes/Notifications/NotificationCell.swift#L104-L107).

Also - and I feel this is a simple thing to add and all users benefit from - is a selected and non selected state for the tab bar icons. This allows you - and especially colorblind people - to more easily get a feel of where in the app they are.

![normal](https://user-images.githubusercontent.com/4190298/30873103-6acb2ba8-a2ec-11e7-85e7-7d9ec68c048c.jpeg)
![black-and-white](https://user-images.githubusercontent.com/4190298/30873105-6bf75164-a2ec-11e7-98a4-112786abc7bc.jpeg)

### Implementation

If you want to have some examples of how the accessibility features in GitHawk were implemented, check out [#32](https://github.com/rnystrom/GitHawk/pull/32), [#119](https://github.com/rnystrom/GitHawk/pull/119) and [#178](https://github.com/rnystrom/GitHawk/pull/178). If you want to help and improve the accessibility features in GitHawk, there's an issue tracking progress: [#118](https://github.com/rnystrom/GitHawk/issues/118). 

If you feel like an accessibility feature is missing and has not yet been added to the issue, please feel free to leave a comment there.

## Closing Thoughts

Even though not everyone will need or make use of all accessibility features, but most users will benefit from at least some of them. And for others it fill even be the difference of being able to use your app in a meaningful way — or not at all.

So, please consider looking into the possibilities the accessibility features can offer for your app or product, and keep in mind that there are people greatly benefiting from your effort. From my experience, when you start using those features yourself - to test them, for example - you might even get to love them and start using them.

Making (and keeping!) an app fully accessible takes a lot of time and effort, but it’s super easy to start *somewhere* and go from there.

If you have any other questions about accessibility or want to get started with accessibility in your app, I'd love to help. You can reach out to me on Twitter: [@basthomas](https://twitter.com/basthomas). 

If your app already supports some accessibility features, I’d love to hear about that too!

*You can download GitHawk on [the App Store](https://itunes.apple.com/nl/app/githawk-for-github/id1252320249?l=en&mt=8
).*
