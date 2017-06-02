//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

final class DetailMenuLabel: UILabel {

    let detailText: String

    init(detailText: String) {
        self.detailText = detailText

        super.init(frame: .zero)

        isUserInteractionEnabled = true

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(DetailMenuLabel.showMenu(recognizer:)))
        addGestureRecognizer(longPress)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    func showMenu(recognizer: UITapGestureRecognizer) {
        guard recognizer.state == .began else { return }

        becomeFirstResponder()

        let menu = UIMenuController.shared
        menu.menuItems = [
            UIMenuItem(title: detailText, action: #selector(DetailMenuLabel.fake))
        ]
        menu.setTargetRect(bounds, in: self)
        menu.setMenuVisible(true, animated: true)
    }

    func fake() {}

}

let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
container.backgroundColor = .blue

let label = DetailMenuLabel(detailText: "5/12/2017 8:43pm UTC")
label.backgroundColor = .white
label.text = "2 minutes ago"
label.textColor = .gray
label.sizeToFit()
label.center = CGPoint(x: container.bounds.width/2, y: container.bounds.height/2)
container.addSubview(label)

PlaygroundPage.current.liveView = container
