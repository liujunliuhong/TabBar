//
//  GLTabBarItem.swift
//  SwiftTool
//
//  Created by galaxy on 2020/10/27.
//  Copyright © 2020 yinhe. All rights reserved.
//

import UIKit

public class GLTabBarItem: UITabBarItem {

    internal weak var tabBar: GLTabBar?
    public private(set) var containerView: GLTabBarItemContainerView?
    
    /// 初始化方法
    public init(containerView: GLTabBarItemContainerView) {
        super.init()
        self.containerView = containerView
    }
    
    /// 设置`item`的宽度，如果为`nil`或者`0`，框架内部会自动设置宽度(当`tabBar`的`layoutType`为`fillUp`时，有效)
    public var itemWidth: CGFloat? {
        didSet {
            guard let tabBar = self.tabBar else { return }
            if tabBar.layoutType == .fillUp {
                tabBar.setNeedsLayout()
                tabBar.layoutIfNeeded()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
