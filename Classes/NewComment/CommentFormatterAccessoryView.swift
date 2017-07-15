import Foundation
import UIKit

private struct MDownFormattingElement {
    let name: String
    let replacements: (String, String?) // before / after
    let atLineStart: Bool

    init(name: String, replacements: (String, String?)) {
        self.name = name
        self.replacements = replacements
        self.atLineStart = false
    }

    init(name: String, replacements: (String, String?), atLineStart: Bool) {
        self.name = name
        self.replacements = replacements
        self.atLineStart = atLineStart
    }
}

private let baseElements = [
    MDownFormattingElement(name: "mdown.codeBlock", replacements: ("```\n", "\n```")),
    MDownFormattingElement(name: "mdown.code", replacements: ("`", "`")),
    MDownFormattingElement(name: "H1", replacements: ("# ", nil), atLineStart: true),
    MDownFormattingElement(name: "H2", replacements: ("## ", nil), atLineStart: true),
    MDownFormattingElement(name: "H3", replacements: ("### ", nil), atLineStart: true),
    MDownFormattingElement(name: "H4", replacements: ("#### ", nil), atLineStart: true),
    MDownFormattingElement(name: "mdown.bold", replacements: ("**", "**")),
    MDownFormattingElement(name: "mdown.emphasis", replacements: ("*", "*")),
    MDownFormattingElement(name: "mdown.strike", replacements: ("~~", "~~"))
]

private func skinnedButton(_ button: UIButton) -> UIButton {
    button.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 20.0, bottom: 5.0, right: 20.0)
    button.backgroundColor = Styles.Colors.Blue.medium.color
    button.layer.cornerRadius = 16.0 // just so we don't need recompute
    button.layer.masksToBounds = true
    button.setTitleColor(.white, for: .normal)
    return button
}

class CommentFormatterAccessoryView: UIView {
    private let elements = baseElements
    private let scrollView = UIScrollView(frame: .zero)
    private let stackView = UIStackView(frame: .zero)
    private var hasInitialConstraints: Bool = false

    weak var textView: UITextView?

    init(textView: UITextView) {
        super.init(frame: .zero)
        self.textView = textView
        textView.inputAccessoryView = self

        addSubview(scrollView)
        scrollView.addSubview(stackView)
        elements.map { (elt) -> UIButton in
            let btn = UIButton(frame: .zero)
            btn.setTitle(NSLocalizedString(elt.name, comment: ""), for: .normal)
            btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            return skinnedButton(btn)
        }.forEach(stackView.addArrangedSubview)

        backgroundColor = Styles.Colors.background

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20.0
        frame = CGRect(origin: .zero, size: CGSize(width: 0.0, height: 44.0))
        setupInitialConstraintsIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    private func setupInitialConstraintsIfNeeded() {
        if hasInitialConstraints { return }
        hasInitialConstraints = true
        translatesAutoresizingMaskIntoConstraints = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -12).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 6).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    @objc
    private func buttonTapped(btn: UIButton) {
        guard
            let idx = stackView.subviews.index(of: btn),
            let textView = textView,
            let range = textView.selectedTextRange, // seems to be always set
            let text = textView.text(in: range), // no selection = ""
            idx >= 0, idx < elements.count else { return }

        let elt = elements[idx]
        let before = elt.replacements.0
        let after = elt.replacements.1 ?? ""
        let replacementText = "\(before)\(text)\(after)"

        var insertionRange = range
        if elt.atLineStart {
            let startLinePosition = textView.startOfLine(forRange: range)
            insertionRange = textView.textRange(from: startLinePosition, to: startLinePosition) ?? range
        }

        textView.replace(insertionRange, withText: replacementText)
        if range.start == range.end, // single cursor (no selection)
            let position = textView.position(from: range.start, // advance by the inserted before
                                             offset: before.lengthOfBytes(using: .utf8)) {
            textView.selectedTextRange = textView.textRange(from: position, to: position) // single cursor
        }
    }

    deinit {
        print("DEINIT!!")
    }
}

extension UITextView {

    private func oneCharRange(pos: UITextPosition?) -> UITextRange? {
        guard let pos = pos,
            let position = self.position(from: pos, offset: 1) else { return nil }
        return self.textRange(from: pos, to: position)
    }

    private func text(atPosition position: UITextPosition?) -> String? {
        guard let position = position,
            let range = oneCharRange(pos: position) else { return nil }
        return text(in: range)
    }

    func startOfLine(forRange range: UITextRange) -> UITextPosition {

        func previousPosition(pos: UITextPosition?) -> UITextPosition? {
            guard let pos = pos else { return nil }
            return self.position(from: pos, offset: -1)
        }

        var position: UITextPosition? =  previousPosition(pos: range.start)
        while let text = text(atPosition: position), text != "\n" { // check if it's the EoL
            position = previousPosition(pos: position) // move back 1 char
        }

        if let position = position, // we have a position
            let pos = self.position(from: position, offset: 1) { // need to advance by one...
            return pos
        }

        return beginningOfDocument // not found? Go to the beginning
    }
}

