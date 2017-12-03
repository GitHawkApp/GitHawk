//
//  SampleCode.swift
//  Highlightr
//
//  Created by Illanes, J.P. on 5/5/16.
//

import UIKit
import Highlightr
import ActionSheetPicker_3_0

enum pickerSource : Int {
    case theme = 0
    case language
}

class SampleCode: UIViewController
{
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var viewPlaceholder: UIView!
    var textView : UITextView!
    @IBOutlet var textToolbar: UIToolbar!
    
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var themeName: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var highlightr : Highlightr!
    let textStorage = CodeAttributedString()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        languageName.text = "Swift"
        themeName.text = "Pojoaque"
        
        textStorage.language = languageName.text?.lowercased()
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        textView = UITextView(frame: viewPlaceholder.bounds, textContainer: textContainer)
        textView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.autocapitalizationType = UITextAutocapitalizationType.none
        textView.textColor = UIColor(white: 0.8, alpha: 1.0)
        textView.inputAccessoryView = textToolbar
        viewPlaceholder.addSubview(textView)
        
        let code = try! String.init(contentsOfFile: Bundle.main.path(forResource: "sampleCode", ofType: "txt")!)
        textView.text = code
        
        highlightr = textStorage.highlightr
        
        updateColors()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pickLanguage(_ sender: AnyObject)
    {
        let languages = highlightr.supportedLanguages()
        let indexOrNil = languages.index(of: languageName.text!.lowercased())
        let index = (indexOrNil == nil) ? 0 : indexOrNil!
        
        ActionSheetStringPicker.show(withTitle: "Pick a Language",
                                     rows: languages,
                                     initialSelection: index,
                                     doneBlock:
            { picker, index, value in
                let language = value! as! String
                self.textStorage.language = language
                self.languageName.text = language.capitalized
                let snippetPath = Bundle.main.path(forResource: "default", ofType: "txt", inDirectory: "Samples/\(language)", forLocalization: nil)
                let snippet = try! String(contentsOfFile: snippetPath!)
                self.textView.text = snippet
                
            },
                                     cancel: nil,
                                                    origin: toolBar)

    }

    @IBAction func performanceTest(_ sender: AnyObject)
    {
        let code = textStorage.string
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        DispatchQueue.global(qos: .userInteractive).async {
            let start = Date()
            for _ in 0...100
            {
                _ = self.highlightr.highlight(code, as: self.languageName.text!)
            }
            let end = Date()
            let time = Float(end.timeIntervalSince(start));
            
            let avg = String(format:"%0.4f", time/100)
            let total = String(format:"%0.3f", time)
            
            let alert = UIAlertController(title: "Performance test", message: "This code was highlighted 100 times. \n It took an average of \(avg) seconds to process each time,\n with a total of \(total) seconds", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            
            DispatchQueue.main.async(execute: {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.present(alert, animated: true, completion: nil)
            })
        }
        
    }
    
    @IBAction func pickTheme(_ sender: AnyObject)
    {
        hideKeyboard(nil)
        let themes = highlightr.availableThemes()
        let indexOrNil = themes.index(of: themeName.text!.lowercased())
        let index = (indexOrNil == nil) ? 0 : indexOrNil!
        
        ActionSheetStringPicker.show(withTitle: "Pick a Theme",
                                     rows: themes,
                                     initialSelection: index,
                                     doneBlock:
            { picker, index, value in
                let theme = value! as! String
                self.textStorage.highlightr.setTheme(to: theme)
                self.themeName.text = theme.capitalized
                self.updateColors()
            },
                                     cancel: nil,
                                                    origin: toolBar)
        
    }
    
    @IBAction func hideKeyboard(_ sender: AnyObject?)
    {
        textView.resignFirstResponder()
    }
    
    func updateColors()
    {
        textView.backgroundColor = highlightr.theme.themeBackgroundColor
        navBar.barTintColor = highlightr.theme.themeBackgroundColor
        navBar.tintColor = invertColor(navBar.barTintColor!)
        languageName.textColor = navBar.tintColor
        themeName.textColor = navBar.tintColor.withAlphaComponent(0.5)
        toolBar.barTintColor = navBar.barTintColor
        toolBar.tintColor = navBar.tintColor
    }
    
    func invertColor(_ color: UIColor) -> UIColor
    {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: nil)
        return UIColor(red:1.0-r, green: 1.0-g, blue: 1.0-b, alpha: 1)
    }
}
