//
//  _GLTabBarItemWrapView.swift
//  SwiftTool
//
//  Created by galaxy on 2020/10/27.
//  Copyright © 2020 yinhe. All rights reserved.
//

import UIKit

private let _clearColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

internal class _GLTabBarItemWrapView: UIControl {
    
    @available(iOS, unavailable)
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    init(target: AnyObject?) {
        super.init(frame: .zero)
        self.backgroundColor = _clearColor
        self.addTarget(target, action: #selector(GLTabBar.selectAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for subView in subviews {
            if let subView = subView as? GLTabBarItemContainerView {
                let inset = subView.insets
                subView.frame = CGRect(x: inset.left, y: inset.top, width: bounds.size.width - inset.left - inset.right, height: bounds.size.height - inset.top - inset.bottom)
            }
        }
    }
    
    internal override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var b = super.point(inside: point, with: event)
        if !b {
            for subView in subviews {
                if subView.point(inside: CGPoint(x: point.x - subView.frame.origin.x, y: point.y - subView.frame.origin.y), with: event) {
                    b = true
                }
            }
        }
        return b
    }
}
