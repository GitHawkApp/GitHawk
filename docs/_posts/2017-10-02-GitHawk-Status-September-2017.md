---
layout: post
title: GitHawk Stats - September 2017
---

I want to get into the habit of sharing more about how GitHawk is doing in the App Store.

## Current Goals

Here are the goals we are currently working toward with GitHawk:

- 100 _legitimate_ downloads/day
- 4.5+ star ratings at 20/month
- Top 3 rank when searching for "github"

I am making these up on the spot, but these seem pretty achievable in the coming months.

## Overview

Here's a quick look at how GitHawk did in September using the iTunes Connect App Analytics overview:

![overview](https://user-images.githubusercontent.com/739696/31088247-4997bd30-a7a0-11e7-9be1-dab1aa81f1c8.png)

- 14.728 impressions
- 1,853 product page views
- 2,233 app units (majority spam, more on this below)
- 2,464 sessions
- 379 devices (that's **6.5 sessions per device!**)
- 0 crashes! 😎

## Downloads

Measuring downloads is a little fraught because of how much spam there is on the App Store. I didn't really know this going in until I saw a **massive spike** in downloads from China.

![China downloads](https://user-images.githubusercontent.com/739696/31087342-f4636d1c-a79c-11e7-96af-e5ae0114f2bb.png)

By comparing Sessions to App Units in the app analytics tool, you can see just how _poor_ Asia Pacific downloads are.

![China sessions](https://user-images.githubusercontent.com/739696/31087413-37ef41be-a79d-11e7-9d92-c8526a73d75a.png)

Thankfully, these spammy downloads seem to have disappeared within the last week!

![China gone](https://user-images.githubusercontent.com/739696/31087443-5603b8b0-a79d-11e7-9255-a698c1e6524f.png)

I'm not sure what this download spam is all about, but one theory about spammers filling accounts with "history" to then sell reviews sounds plausible.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/camroth?ref_src=twsrc%5Etfw">@camroth</a> Had a theory about this: &quot;...backfill their purchase history to make them look legit when they use those accounts to sell reviews&quot;</p>&mdash; Arthur A. Sabintsev (@ArtSabintsev) <a href="https://twitter.com/ArtSabintsev/status/911617745254526976?ref_src=twsrc%5Etfw">September 23, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

So if you remove downloads from Asia Pacific, we're hovering between **10-20 downloads a day**. Not great, but hey, it's moving!

## Ranking and Ratings

In early September, if you searched "github" on the App Store, GitHawk would show up way, way down. There were at least 25 apps that would show up before it!

However, as of October 2, 2017, GitHawk is **ranked 10th when searching for "github"!** That's a huge improvement in only a month!

The iOS 11 App Store update now shows more ratings than just the previous version. That's a blessing because I like to ship pretty fast.

We also added two different rating prompts:

- `SKStoreReviewController` for alert-style prompts after making a notification (or all of them) read.
- A dismissable in-feed unit if you haven't been exposed to the native rater in a while

Here are those prompts in action:

![rating](https://user-images.githubusercontent.com/739696/31088978-cfe652a0-a7a2-11e7-8caf-dc19005cd57e.jpg)

You can [check out the source](https://github.com/rnystrom/GitHawk/blob/master/Classes/Systems/Rating/RatingController.swift) to see how I mix & match the two rating styles.

Things seem to be working because GitHawk is sitting pretty with 18 reviews displayed in the search results!

![ratings](https://user-images.githubusercontent.com/739696/31087909-22d5b87e-a79f-11e7-8fb7-cc0513c489ae.PNG)

## App Store Impressions

In version 1.10.0, I wanted to try to push GitHawk in front of more eyeballs. I made 3 updates:

- Wrote a new App Store description focusing on the first "3 lines" that are displayed (before the "more" truncation).
    + I also spent a good amount of time writing a detailed description of features and selling points. Some research told me that your sticky-users (e.g. high retention) will often expand and read the description, so you want something meaty!
- Create an App Preview video.
    + I followed [Apple's advice](https://developer.apple.com/support/app-previews/imovie/) for editing the video in iMovie. Stupid simple with a couple text overlays.
    + Most of my installs come from iPhones, so I only made one format so that my update cost is low. I followed [this article](https://thenextweb.com/insider/2015/11/15/6-tips-for-creating-the-perfect-apple-app-store-video-for-your-app/#.tnw_7J5BWcHx) and learned about using [FFMPEG](http://www.ffmpegmac.net/) to scale and edit one video for other device requirements.
- Tweaked keywords slightly

I shipped version 1.10.0 on 9/22/17 if that isn't obvious by this iTunes impressions chart:

![impressions](https://user-images.githubusercontent.com/739696/31088194-0ed874a0-a7a0-11e7-97db-1b82c4dc33eb.png)

All in all, I basically tripled my impressions!

> I do wish that I could measure the effectiveness of the App Preview, description, and keyword changes independently. 🙏 for App Store A/B testing!

### Product-Page View Sources

Impressions are nice, but they are counted when someone scrolls by GitHawk on a search results page. What about people that actually view the product page?

Here's a look at our sources:

![sources](https://user-images.githubusercontent.com/739696/31088469-0edbad18-a7a1-11e7-9d7a-7d1614cbeeb3.png)

I've been trying to boost traffic via tweeting about GitHawk (a lot, sorry). How effective has that been?

![web sources](https://user-images.githubusercontent.com/739696/31088518-3c998d2e-a7a1-11e7-8f3c-dc22309039fd.png)

Nice, **t.co** (Twitter's short domain) makes up 93 of my page views! Not a ton, but its something! May the tweetstorms continue!

## Usage

Lastly, just how active are people that install GitHawk?

![sessions per install](https://user-images.githubusercontent.com/739696/31088598-7cde0216-a7a1-11e7-9b46-06e69967cdf6.png)

Sessions/install seems like a pretty good metric for me to measure GitHawk's usefulness. We're flirting with 10 sessions/install, which I think is great: that's a couple uses per week per person!

I also spend some time supporting iPad with GitHawk, are any of these active users on iPad?

![ipad](https://user-images.githubusercontent.com/739696/31088699-e1b1caa6-a7a1-11e7-8e15-663c778501cf.png)

Not many, sadly. That doesn't mean I should forget about iPad, but also gives me some evidence that I shouldn't bend-over-backward to make everything pixel-perfect.

## Conclusion

This has been a fun month! GitHawk is getting a healthy volume of ratings, downloads are low but the spam is gone, and our ranking went up quite a lot!

For the next month, I want to pump out a few more features and write more. Hopefully these blog posts will help drive downloads too! 😉
