import Foundation
import UIKit

private struct MDownFormattingElement {
    let name: String
    let replacements: (String, String?) // before / after
}

private let baseElements = [
    MDownFormattingElement(name: "mdown.codeBlock", replacements: ("```\n", "\n```")),
    MDownFormattingElement(name: "mdown.code", replacements: ("`", "`")),
    MDownFormattingElement(name: "H1", replacements: ("# ", nil)),
    MDownFormattingElement(name: "H2", replacements: ("## ", nil)),
    MDownFormattingElement(name: "H3", replacements: ("### ", nil)),
    MDownFormattingElement(name: "H4", replacements: ("#### ", nil)),
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

class MDownFormattingController: UIViewController {
    private let elements = baseElements
    private let scrollView = UIScrollView(frame: .zero)
    private let stackView = UIStackView(frame: .zero)
    private var hasInitialConstraints: Bool = false

    weak var textView: UITextView? = nil

    override func viewDidLoad() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        elements.map { (elt) -> UIButton in
            let btn = UIButton(frame: .zero)
            btn.setTitle(NSLocalizedString(elt.name, comment: ""), for: .normal)
            btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            return skinnedButton(btn)
        }.forEach(stackView.addArrangedSubview)
        view.backgroundColor = Styles.Colors.background

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20.0
        view.frame = CGRect(origin: .zero, size: CGSize(width: 0.0, height: 44.0))
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        setupInitialConstraintsIfNeeded()
    }

    private func setupInitialConstraintsIfNeeded() {
        if hasInitialConstraints { return }
        hasInitialConstraints = true
        view.translatesAutoresizingMaskIntoConstraints = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

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
        textView.replace(range, withText: "\(before)\(text)\(after)")
        if range.start == range.end, // single cursor (no selection)
            let position = textView.position(from: range.start, // advance by the inserted before
                                             offset: before.lengthOfBytes(using: .utf8)) {
            textView.selectedTextRange = textView.textRange(from: position, to: position) // single cursor
        }
    }
}
