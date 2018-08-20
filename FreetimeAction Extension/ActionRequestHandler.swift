//
//  ActionRequestHandler.swift
//  FreetimeAction Extension
//
//  Created by Florent Vilmart on 2018-08-19.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import MobileCoreServices

private let stringUTTypePropertyList = String(kUTTypePropertyList)

final class ActionRequestHandler: NSObject, NSExtensionRequestHandling {

    var extensionContext: NSExtensionContext?
    
    func beginRequest(with context: NSExtensionContext) {
        // Do not call super in an Action extension with no user interface
        extensionContext = context
        
        var found = false
        // Find the item containing the results from the JavaScript preprocessing.
        outer:
        for item in context.inputItems as! [NSExtensionItem] {
            if let attachments = item.attachments {
                for itemProvider in attachments as! [NSItemProvider] {
                    if itemProvider.hasItemConformingToTypeIdentifier(stringUTTypePropertyList) {
                        itemProvider.loadItem(forTypeIdentifier: stringUTTypePropertyList, options: nil, completionHandler: { (item, error) in
                            let dictionary = item as! [String: Any]
                            OperationQueue.main.addOperation {
                                self.itemLoadCompletedWithPreprocessingResults(dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! [String: Any]? ?? [:])
                            }
                        })
                        found = true
                        break outer
                    }
                }
            }
        }
        
        if !found {
            self.doneWithResults(nil)
        }
    }
    
    func itemLoadCompletedWithPreprocessingResults(_ javaScriptPreprocessingResults: [String: Any]) {
        // Here, do something, potentially asynchronously, with the preprocessing
        // results.
        
        // In this very simple example, the JavaScript will have passed us the
        // current background color style, if there is one. We will construct a
        // dictionary to send back with a desired new background color style.
        guard let location = javaScriptPreprocessingResults["location"] as? String,
            let url = URL(string: location),
            let host = url.host,
            host.contains("github.com") else {

            self.doneWithResults(["error": NSLocalizedString("Unable to open in GitHawk", comment: "")])
            return
        }

        self.doneWithResults(["location": "freetime://github.com\(url.path)"])
    }
    
    func doneWithResults(_ resultsForJavaScriptFinalizeArg: [String: Any]?) {
        if let resultsForJavaScriptFinalize = resultsForJavaScriptFinalizeArg {
            // Construct an NSExtensionItem of the appropriate type to return our
            // results dictionary in.
            
            // These will be used as the arguments to the JavaScript finalize()
            // method.
            
            let resultsDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: resultsForJavaScriptFinalize]
            
            let resultsProvider = NSItemProvider(item: resultsDictionary as NSDictionary, typeIdentifier: String(kUTTypePropertyList))
            
            let resultsItem = NSExtensionItem()
            resultsItem.attachments = [resultsProvider]
            
            // Signal that we're complete, returning our results.
            self.extensionContext!.completeRequest(returningItems: [resultsItem], completionHandler: nil)
        } else {
            // We still need to signal that we're done even if we have nothing to
            // pass back.
            self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        }
        
        // Don't hold on to this after we finished with it.
        self.extensionContext = nil
    }

}
