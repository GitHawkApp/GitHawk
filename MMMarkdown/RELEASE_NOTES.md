# MMMarkdown Release Notes
## 0.5.5
 - #107: Create `NSRegularExpression`s using `dispatch_once`

## 0.5.4
 - #103: Don't let lists contain both bulleted and numbered items
 - #104: Require a space after the # in headers
 - #105: Let list items indent with 2 spaces

## 0.5.3
 - #101: Fix infinite loop in list parsing

## 0.5.2
 - #92: Allow `-`s in inline HTML

## 0.5.1
 - #88: Update Xcode project settings
 - #89: Fix some broken unit tests
 - #90: Add tvOS and watchOS targets
 
## 0.5
 - #63: Fix warnings from Xcode 6.3
 - #67: Improved link handling
 - #71: Allow = in autolinked URLs
 - #73: Allow dashes in language names
 - #74: Switch to from static libraries to dynamic frameworks
 
## 0.4.3
 - #60: UnderscoresInWords should only affect underscores

## 0.4.2
 - #51: Fenced code blocks shouldn't allow non-whitespace characters after trailing delimiter
 - #54: Improve handling of of language names in fenced code blocks
 - #57: Fix handling of images inside links

## 0.4.1
Fix an exception when whitespace preceded what would otherwise be a header ([#47](https://github.com/mdiep/MMMarkdown/issues/47)).

## 0.4
This release adds support for GitHub-flavored Markdown and extensions. It also includes bug fixes, updated Xcode project settings, and more modernization. 

## 0.3
This release adds an HTML parser, which is needed to properly handle HTML inside Markdown. It also removes the precompiled libraries in favor of including the project.

Other changes include:

 - Support newer iOS architectures
 - Fix a crash when passed an empty string
 - Fix code spans with multiple backticks
 - Fix code spans that contain newlines
 - Fix handling of images with no alt text
 - Annotate that the markdown can't be nil
 - Fix behavior of archive builds
 - Update Xcode project settings
 - Modernize the code

## 0.2.3
Fix the iOS deployment target and static library to support iOS 5.0.

## 0.2.2
Updated the iOS static library to include armv7s architecture.

## 0.2.1
Bugfix release that fixes 2 issues:

 - Add support for alternate ASCII line endings (\r\n and \r)
 - Fix a crash when list items have leading spaces beyond their
   indentation level

## 0.2 - Correctness
This release focused on expanding the test suite and fixing bugs. Many bugs were fixed and support for the Markdown image syntax was added.

## 0.1
The initial release of MMMarkdown. Implemented enough of markdown to pass all of Gruber's tests.
