# MMMarkdown
MMMarkdown is an Objective-C framework for converting [Markdown][] to HTML. It is compatible with OS X 10.7+, iOS 8.0+, tvOS, and watchOS.

Unlike other Markdown libraries, MMMarkdown implements an actual parser. It is not a port of the original Perl implementation and does not use regular expressions to transform the input into HTML. MMMarkdown tries to be efficient and minimize memory usage.

[Markdown]: http://daringfireball.net/projects/markdown/

## API
Using MMMarkdown is simple. The main API is a single class method:

    #import <MMMarkdown/MMMarkdown.h>
    
    NSError  *error;
    NSString *markdown   = @"# Example\nWhat a library!";
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
    // Returns @"<h1>Example</h1>\n<p>What a library!</p>"

The markdown string that is passed in must be non-nil.

MMMarkdown also supports a number of Markdown extensions:

    #import <MMMarkdown/MMMarkdown.h>
    
    NSString *markdown   = @"~~Mistaken~~";
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown extensions:MMMarkdownExtensionsGitHubFlavored error:NULL];
    // Returns @"<p><del>Mistaken</del></p>"

## Setup
Adding MMMarkdown to your project is easy.

If you’d like to use [Carthage](https://github.com/Carthage/Carthage), add the following line to your `Cartfile`:

```
github "mdiep/MMMarkdown"
```

Otherwise, you can:

0. Add MMMarkdown as a git submodule. (`git submodule add https://github.com/mdiep/MMMarkdown <path>`)

0. Add `MMMarkdown.xcodeproj` to your project or workspace

0. Add `MMMarkdown.framework` to the ”Link Binary with Libraries" section of your project's “Build Phases”.

0. Add `MMMarkdown.framework` to a ”Copy Files” build phase that copies it to the `Frameworks` destination.

## License
MMMarkdown is available under the [MIT License][].

[MIT License]: http://opensource.org/licenses/mit-license.php

