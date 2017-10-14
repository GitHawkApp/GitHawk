//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class Button: UIView {
    let emoji = UILabel()
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        emoji.backgroundColor = .clear
        emoji.textAlignment = .center
        emoji.font = UIFont.systemFont(ofSize: 36)
        addSubview(emoji)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        addSubview(label)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let half = bounds.width/2
        emoji.frame = CGRect(x: 0, y: 0, width: half, height: bounds.height)
        label.frame = CGRect(x: half, y: 0, width: half, height: bounds.height)
    }
}

class MyViewController : UIViewController {

    var val = 0

    let button = Button()
    let add = UIButton()
    let sub = UIButton()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        button.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
        view.addSubview(button)
        add.setTitle("Add", for: .normal)
        add.setTitleColor(.blue, for: .normal)
        add.sizeToFit()
        add.addTarget(self, action: #selector(MyViewController.onAdd), for: .touchUpInside)
        view.addSubview(add)
        sub.setTitle("Sub", for: .normal)
        sub.setTitleColor(.blue, for: .normal)
        sub.sizeToFit()
        sub.addTarget(self, action: #selector(MyViewController.onSub), for: .touchUpInside)
        view.addSubview(sub)
        update(.idle)
    }

    @objc func onAdd() {
        update(.add)
    }

    @objc func onSub() {
        update(.sub)
    }

    enum Update {
        case add
        case sub
        case idle
    }

    func update(_ update: Update) {
        button.emoji.text = "🤔"

        enum Action {
            case remove
            case add
            case incr
            case decr
            case none
        }

        let action: Action
        switch update {
        case .add:
            if val == 0 {
                action = .add
            } else if val > 0 {
                action = .incr
            } else {
                action = .none
            }
            val += 1
        case .sub:
            if val > 1 {
                action = .decr
            } else if val == 1 {
                action = .remove
            } else {
                action = .none
            }
            val -= 1
        case .idle:
            action = .none
        }

        print(val)

        switch action {
        case .add:
            pop()
        case .remove:
            remove()
        case .incr:
            iterate(incr: true)
        case .decr:
            iterate(incr: false)
        case .none:
            if val <= 0 {
                button.emoji.alpha = 0
                button.label.alpha = 0
            } else {
                button.emoji.alpha = 1
                button.label.alpha = 1
            }
        default: break
        }
    }

    func pop() {
        print("pop")

        button.emoji.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        button.emoji.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: [.curveEaseInOut], animations: {
            self.button.emoji.transform = .identity
            self.button.emoji.alpha = 1
        })

        button.label.alpha = 0
        button.label.text = "\(val)"
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.button.label.alpha = 1
        })
    }

    func remove() {
        print("remove")

        button.label.alpha = 1
        button.emoji.transform = .identity
        button.emoji.alpha = 1
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.button.label.alpha = 0
            self.button.emoji.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            self.button.emoji.alpha = 0
        })
    }

    func iterate(incr: Bool) {
        print("iterate \(incr)")

        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionPush
        animation.subtype = incr ? kCATransitionFromTop : kCATransitionFromBottom
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        button.label.layer.add(animation, forKey: "text-change")

        button.label.text = "\(val)"
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        button.center = view.center
        add.center = CGPoint(x: button.frame.maxX, y: button.frame.maxY + 40)
        sub.center = CGPoint(x: button.frame.minX, y: button.frame.maxY + 40)
    }

}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
