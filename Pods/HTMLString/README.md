<p align="center">
    <img src="https://github.com/alexaubry/HTMLString/raw/master/logo.png" alt="HTMLString" />
    <a>
        <img src="https://img.shields.io/badge/Swift-3.0.2-ee4f37.svg" alt="Swift 3.0.2" />
    </a>
    <a href="https://travis-ci.org/alexaubry/HTMLString">
        <img src="https://travis-ci.org/alexaubry/HTMLString.svg?branch=master" alt="Build Status" />
    </a>
    <a href="https://cocoapods.org/pods/HTMLString">
        <img src="https://img.shields.io/cocoapods/v/HTMLString.svg" alt="CocoaPods" />
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" />
    </a>
    <a href="https://codecov.io/gh/alexaubry/HTMLString">
        <img src="https://codecov.io/gh/alexaubry/HTMLString/branch/master/graph/badge.svg" alt="Code coverage" />
    </a>
    <a href="https://twitter.com/leksantoine">
        <img src="https://img.shields.io/badge/Twitter-%40leksantoine-6C7A89.svg" alt="Twitter : @leksantoine" />
    </a>
</p>

`HTMLString` is a library written in Swift that enables your app to escape and unescape HTML entities in Strings.

|         | Main features |
----------|----------------
&#128271; | Adds entities for ASCII and UTF-8/UTF-16 encodings
&#128221; | Removes more than 2100 named entities (like `&amp;`)
&#128290; | Supports removing decimal and hexadecimal entities
&#128035; | Designed to support Swift Extended Grapheme Clusters (&#8594; 100% emoji-proof)
&#009989; | Fully unit tested
&#009889; | Fast
&#128218; | [100% documented](https://alexaubry.github.io/HTMLString/)
&#129302; | [Compatible with Objective-C](https://github.com/alexaubry/HTMLString/tree/master/README.md#objective%2Dc-api)

## Supported Platforms

- iOS 8.0+
- macOS 10.10+
- tvOS 9.0+
- watchOS 2.0+
- Linux

## Installation

### Swift Package Manager

Add this line to your `Package.swift` :

~~~swift
.Package(url: "https://github.com/alexaubry/HTMLString", majorVersion: 3, minor: 0)
~~~

### CocoaPods

Add this line to your `Podfile`:

~~~
pod 'HTMLString'
~~~

### Carthage

Add this line to your Cartfile:

~~~
github "alexaurby/HTMLString"
~~~

### Manual

Copy the `Sources/HTMLString/` directory into your project.

## Usage

`HTMLString` allows you to add and remove HTML entities from a String.

### &#128271; Add HTML Entities (Escape)

When a character is not supported into the specified encoding, the library replaces it with a decimal entitiy, such as `&#038;` <=> `&` (compatible with HTML 4+). 

You can choose between ASCII and Unicode escaping. 

> &#128161; **Pro Tip**: When your content supports UTF-8 or UTF-16, use Unicode escaping as it is faster and yields a less bloated output.

#### Docs

- [`addingUnicodeEntities`](https://alexaubry.github.io/HTMLString/Extensions/String.html#/s:vE10HTMLStringSS21addingUnicodeEntitiesSS)
- [`addingASCIIEntities`](https://alexaubry.github.io/HTMLString/Extensions/String.html#/s:vE10HTMLStringSS19addingASCIIEntitiesSS)

#### Example

~~~swift
import HTMLString

let emoji = "My favorite emoji is 🙃"
let escapedEmoji = emoji.addingASCIIEntities // "My favorite emoji is &#128579;"
let noNeedToEscapeThatEmoji = emoji.addingUnicodeEntities // "My favorite emoji is 🙃"

let snack = "Fish & Chips"
let escapedSnack = snack.addingUnicodeEntities // "Fish &#038; Chips"
~~~

### &#128221; Remove HTML Entities (Unescape)

To remove HTML entities from a String, use the `removingHTMLEntities` property.

#### Docs

- [`removingHTMLEntities`](https://alexaubry.github.io/HTMLString/Extensions/String.html#/s:vE10HTMLStringSS20removingHTMLEntitiesSS)

#### Example

~~~swift
import HTMLString

let escapedEmoji = "My favorite emoji is &#x1F643;"
let emoji = escapedEmoji.removingHTMLEntities // "My favorite emoji is 🙃"

let escapedSnack = "Fish &amp; Chips"
let snack = escapedSnack.removingHTMLEntities // "Fish & Chips"
~~~

## Objective-C API

With Obj-C Mix and Match, you can import and use the `HTMLString` module from in Objective-C code.

The library introduces a set of Objective-C specific APIs as categories on the `NSString` type:

- `[aString stringByAddingUnicodeEntities];` : Replaces every character incompatible with HTML Unicode encoding by a decimal HTML entitiy.
- `[aString stringByAddingASCIIEntities];` : Replaces every character incompatible with HTML ASCII encoding by a decimal HTML entitiy.
- `[aString stringByRemovingHTMLEntities];` : Replaces every HTML entity with the matching Unicode character.

### Escaping Examples

~~~objc
@import HTMLString;

NSString *emoji = @"My favorite emoji is 🙃";
NSString *escapedEmoji = [emoji stringByAddingASCIIEntities]; // "My favorite emoji is &#128579;"

NSString *snack = @"Fish & Chips";
NSString *escapedSnack = [snack stringByAddingUnicodeEntities]; // "Fish &#038; Chips"
~~~

### Unescaping Examples

~~~objc
@import HTMLString;

NSString *escapedEmoji = @"My favorite emoji is &#x1F643;";
NSString *emoji = [escapedEmoji stringByRemovingHTMLEntities]; // "My favorite emoji is 🙃"

NSString *escapedSnack = @"Fish &amp; Chips";
NSString *snack = [escapedSnack stringByRemovingHTMLEntities]; // "Fish & Chips"
~~~

## &#128175; Acknowledgements

![Thanks @google](http://i.giphy.com/QBC5foQmcOkdq.gif)

This library was inspired by [**@google**'s Toolbox for Mac](https://github.com/google/google-toolbox-for-mac).