//
//  GLTabBarItem.swift
//  SwiftTool
//
//  Created by galaxy on 2020/10/27.
//  Copyright © 2020 yinhe. All rights reserved.
//

import UIKit

public class GLTabBarItem: UITabBarItem {

    public private(set) var containerView: GLTabBarItemContainerView?
    
    
    public init(containerView: GLTabBarItemContainerView) {
        super.init()
        self.containerView = containerView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
