//
//  MMMarkdown.h
//  MMMarkdown
//
//  Copyright (c) 2012 Matt Diephouse.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <Foundation/Foundation.h>

//! Project version number for MMMarkdown.
FOUNDATION_EXPORT double MMMarkdownVersionNumber;

//! Project version string for MMMarkdown.
FOUNDATION_EXPORT const unsigned char MMMarkdownVersionString[];

typedef NS_OPTIONS(NSUInteger, MMMarkdownExtensions)
{
    MMMarkdownExtensionsNone = 0,
    
    MMMarkdownExtensionsAutolinkedURLs      = 1 << 0,
//    MMMarkdownExtensionsCrossReferences     = 1 << 1,
//    MMMarkdownExtensionsCustomAttributes    = 1 << 2,
    MMMarkdownExtensionsFencedCodeBlocks    = 1 << 3,
//    MMMarkdownExtensionsFootnotes           = 1 << 4,
    MMMarkdownExtensionsHardNewlines        = 1 << 5,
    MMMarkdownExtensionsStrikethroughs      = 1 << 6,
//    MMMarkdownExtensionsTableCaptions       = 1 << 7,
    MMMarkdownExtensionsTables              = 1 << 8,
    MMMarkdownExtensionsUnderscoresInWords  = 1 << 9,
    
    MMMarkdownExtensionsGitHubFlavored = MMMarkdownExtensionsAutolinkedURLs|MMMarkdownExtensionsFencedCodeBlocks|MMMarkdownExtensionsHardNewlines|MMMarkdownExtensionsStrikethroughs|MMMarkdownExtensionsTables|MMMarkdownExtensionsUnderscoresInWords,
};

NS_ASSUME_NONNULL_BEGIN
@interface MMMarkdown : NSObject

/*!
 Convert a Markdown string to HTML.
 
 @param string
    A Markdown string. Must not be nil.
 @param error
    Out parameter used if an error occurs while parsing the Markdown. May be NULL.
 @result
    Returns an HTML string.
 */
+ (NSString *)HTMLStringWithMarkdown:(NSString *)string error:(NSError * __autoreleasing * _Nullable)error;

/*!
 Convert a Markdown string to HTML.
 
 @param string
    A Markdown string. Must not be nil.
 @param extensions
    The extensions to enable.
 @param error
    Out parameter used if an error occurs while parsing the Markdown. May be NULL.
 @result
    Returns an HTML string.
 */
+ (NSString *)HTMLStringWithMarkdown:(NSString *)string extensions:(MMMarkdownExtensions)extensions error:(NSError * __autoreleasing * _Nullable)error;

@end
NS_ASSUME_NONNULL_END
