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
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutContentViewForSafeAreaInsets()

        let bounds = self.bounds
        let inset = borderLayer.lineWidth / 2
        let pixelSnapBounds = self.bounds.insetBy(dx: inset, dy: inset)
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

        borderLayer.frame = bounds
        backgroundLayer.frame = bounds
    }

    override var backgroundColor: UIColor? {
        get {
            guard let color = backgroundLayer.fillColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { backgroundLayer.fillColor = newValue?.cgColor}
    }

    // MARK: Private API

    @objc private func onDoubleTap() {
        doubleTapDelegate?.didDoubleTap(cell: self)
    }

    // MARK: UIGestureRecognizerDelegate

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
        ) -> Bool {
        return true
    }

}
