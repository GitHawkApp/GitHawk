//
//  AppDelegate.swift
//  Highlightr_OSX_Example
//
//  Created by Illanes, Juan Pablo on 5/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Cocoa
import Highlightr

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var textView : NSTextView!
    let textStorage = CodeAttributedString()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        textStorage.language = "Swift"
        textStorage.highlightr.setTheme(to: "Pojoaque")
        textStorage.highlightr.theme.codeFont = NSFont(name: "Courier", size: 12)
        
        let code = try! String.init(contentsOfFile: Bundle.main.path(forResource: "sampleCode", ofType: "txt")!)
        textStorage.setAttributedString(NSAttributedString(string: code))
        
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size:(window.contentView?.bounds.size)!)
        layoutManager.addTextContainer(textContainer)
        
        
        textView = NSTextView(frame: (window.contentView?.bounds)!, textContainer: textContainer)
        textView.autoresizingMask = [.viewWidthSizable,.viewHeightSizable]
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.backgroundColor = (textStorage.highlightr.theme.themeBackgroundColor)!
        textView.insertionPointColor = NSColor.white
        window.contentView?.addSubview(textView)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

