//
//  IssueCommentBaseCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol IssueCommentDoubleTapDelegate: class {
    func didDoubleTap(cell: IssueCommentBaseCell)
}

class IssueCommentBaseCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    static let collapseCellMinHeight: CGFloat = 30

    enum BorderType {
        case head
        case neck
        case tail
    }

    weak var doubleTapDelegate: IssueCommentDoubleTapDelegate?
    var border: BorderType = .neck {
        didSet { setNeedsLayout() }
    }
    let doubleTapGesture = UITapGestureRecognizer()

    private let borderLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private let collapseLayer = CAGradientLayer()
    private let collapseButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.clipsToBounds = true

        doubleTapGesture.addTarget(self, action: #selector(onDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delegate = self
        addGestureRecognizer(doubleTapGesture)

        // insert above contentView layer
        borderLayer.strokeColor = UIColor.red.cgColor
        borderLayer.strokeColor = Styles.Colors.Gray.border.color.cgColor
        borderLayer.lineWidth = 1 / UIScreen.main.scale
        borderLayer.fillColor = nil
        layer.addSublayer(borderLayer)

        // insert as base layer
        backgroundLayer.strokeColor = nil
        backgroundLayer.fillColor = UIColor.white.cgColor
        layer.insertSublayer(backgroundLayer, at: 0)

        collapseLayer.isHidden = true
        collapseLayer.colors = [
            UIColor(white: 1, alpha: 0).cgColor,
            UIColor(white: 1, alpha: 1).cgColor
        ]

        collapseButton.setImage(UIImage(named: "bullets")?.withRenderingMode(.alwaysTemplate), for: .normal)
        collapseButton.backgroundColor = Styles.Colors.Blue.medium.color
        collapseButton.accessibilityTraits = UIAccessibilityTraitNone
        collapseButton.tintColor = .white
        collapseButton.titleLabel?.font = Styles.Text.smallTitle.preferredFont
        collapseButton.clipsToBounds = true
        collapseButton.isHidden = true
        collapseButton.contentEdgeInsets = UIEdgeInsets(top: -2, left: 8, bottom: -2, right: 8)
        collapseButton.imageEdgeInsets = .zero
        collapseButton.sizeToFit()
        collapseButton.layer.cornerRadius = collapseButton.bounds.height / 2
        collapseButton.isUserInteractionEnabled = false // allow tap to pass through to cell
        contentView.addSubview(collapseButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()

        let bounds = contentView.frame
        let inset = borderLayer.lineWidth / 2
        let pixelSnapBounds = bounds.insetBy(dx: inset, dy: inset)
        let cornerRadius = Styles.Sizes.cardCornerRadius

        let borderPath = UIBezierPath()
        let fillPath: UIBezierPath

        switch border {
        case .head:
            borderPath.move(to: CGPoint(x: pixelSnapBounds.minX, y: bounds.maxY))
            borderPath.addLine(to: CGPoint(x: pixelSnapBounds.minX, y: pixelSnapBounds.minY + cornerRadius))
            borderPath.addQuadCurve(
                to: CGPoint(x: pixelSnapBounds.minX + cornerRadius, y: pixelSnapBounds.minY),
                controlPoint: CGPoint(x: pixelSnapBounds.minX, y: pixelSnapBounds.minY)
            )
            borderPath.addLine(to: CGPoint(x: pixelSnapBounds.maxX - cornerRadius, y: pixelSnapBounds.minY))
            borderPath.addQuadCurve(
                to: CGPoint(x: pixelSnapBounds.maxX, y: pixelSnapBounds.minY + cornerRadius),
                controlPoint: CGPoint(x: pixelSnapBounds.maxX, y: pixelSnapBounds.minY)
            )
            borderPath.addLine(to: CGPoint(x: pixelSnapBounds.maxX, y: bounds.maxY))

            fillPath = borderPath.copy() as! UIBezierPath
            fillPath.close()
        case .neck:
            borderPath.move(to: CGPoint(x: pixelSnapBounds.minX, y: bounds.minY))
            borderPath.addLine(to: CGPoint(x: pixelSnapBounds.minX, y: bounds.maxY))
            borderPath.move(to: CGPoint(x: pixelSnapBounds.maxX, y: bounds.minY))
            borderPath.addLine(to: CGPoint(x: pixelSnapBounds.maxX, y: bounds.maxY))

            fillPath = UIBezierPath(rect: bounds)
        case .tail:
            borderPath.move(to: CGPoint(x: pixelSnapBounds.minX, y: bounds.minY))
            borderPath.addLine(to: CGPoint(x: pixelSnapBounds.minX, y: pixelSnapBounds.maxY - cornerRadius))
            borderPath.addQuadCurve(
                to: CGPoint(x: pixelSnapBounds.minX + cornerRadius, y: pixelSnapBounds.maxY),
                controlPoint: CGPoint(x: pixelSnapBounds.minX, y: pixelSnapBounds.maxY)
            )
            borderPath.addLine(to: CGPoint(x: pixelSnapBounds.maxX - cornerRadius, y: pixelSnapBounds.maxY))
            borderPath.addQuadCurve(
                to: CGPoint(x: pixelSnapBounds.maxX, y: pixelSnapBounds.maxY - cornerRadius),
                controlPoint: CGPoint(x: pixelSnapBounds.maxX, y: pixelSnapBounds.maxY)
            )
            borderPath.addLine(to: CGPoint(x: pixelSnapBounds.maxX, y: bounds.minY))

            fillPath = borderPath.copy() as! UIBezierPath
            fillPath.close()
        }
        borderLayer.path = borderPath.cgPath
        backgroundLayer.path = fillPath.cgPath

        borderLayer.frame = self.bounds
        backgroundLayer.frame = self.bounds

        if collapseLayer.isHidden == false {
            contentView.layer.addSublayer(collapseLayer)
            contentView.bringSubview(toFront: collapseButton)

            let collapseFrame = CGRect(
                x: bounds.minX,
                y: bounds.height - IssueCommentBaseCell.collapseCellMinHeight,
                width: bounds.width,
                height: IssueCommentBaseCell.collapseCellMinHeight
            )

            // disable implicit CALayer animations
            CATransaction.begin()
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            collapseLayer.frame = collapseFrame
            CATransaction.commit()

            collapseButton.center = CGPoint(
                x: collapseFrame.width / 2,
                y: collapseFrame.maxY - collapseButton.bounds.height / 2
            )
        }
    }

    override var backgroundColor: UIColor? {
        get {
            guard let color = backgroundLayer.fillColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { backgroundLayer.fillColor = newValue?.cgColor}
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        collapseLayer.isHidden = true
        collapseButton.isHidden = true
    }

    // MARK: Private API

    @objc private func onDoubleTap() {
        doubleTapDelegate?.didDoubleTap(cell: self)
    }

    var collapsed: Bool = false {
        didSet {
            collapseButton.isHidden = !collapsed
            collapseLayer.isHidden = !collapsed
            setNeedsLayout()
        }
    }

    // MARK: UIGestureRecognizerDelegate

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
        return true
    }

}
