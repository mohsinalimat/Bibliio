//
//  TipTextField.swift
//  ATTipTextFieldDemo
//
//  Created by Adam on 10/19/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit

@IBDesignable @objc open class TextField: UITextField {
    
    /// The color of the TipTextField's bottom border. Defaults to white.
    @IBInspectable dynamic open var lineColor: UIColor? = .white {
        didSet {
            updateLine()
        }
    }
    
    /// The width of the TipTextField's bottom border. Defaults to 3px.
    @IBInspectable dynamic open var lineWidth: CGFloat = 3 {
        didSet {
            updateLine()
        }
    }
    
    private let line = CAShapeLayer()
    
    private let lineTopMargin: CGFloat = 5.0
    
    override open func draw(_ rect: CGRect) {
        drawLine()
    }
    
    // MARK: - Interface Builder
    
    open override func prepareForInterfaceBuilder() {
        updateLine()
    }
    
    // MARK: - Private
    
    private func updateLine() {
        line.strokeColor = lineColor?.cgColor
        line.lineWidth = lineWidth
        layoutIfNeeded()
    }
    
    private func drawLine() {
        let lineRect = CGRect(origin: CGPoint(x: 0, y: frame.height+lineTopMargin), size: CGSize(width: frame.width, height: lineWidth))
        let linePath = UIBezierPath.init(rect: lineRect)
        line.path = linePath.cgPath
        line.strokeColor = lineColor?.cgColor
        line.lineWidth = lineWidth
        layer.masksToBounds = false
        layer.addSublayer(line)
    }
}
