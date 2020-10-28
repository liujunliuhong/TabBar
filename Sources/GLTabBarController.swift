//
//  GLTabBarController.swift
//  SwiftTool
//
//  Created by galaxy on 2020/10/25.
//  Copyright © 2020 yinhe. All rights reserved.
//

import UIKit

/// 是否可以拦截点击事件
public typealias GLTabBarControllerCanHijackHandler = ((_ tabBarController: GLTabBarController, _ viewController: UIViewController, _ index: Int) -> (Bool))
/// 拦截点击事件的回调
public typealias GLTabBarControllerDidHijackHandler = ((_ tabBarController: GLTabBarController, _ viewController: UIViewController, _ index: Int) -> (Void))


open class GLTabBarController: UITabBarController {

    /// 是否可以拦截点击事件
    public var canHijackHandler: GLTabBarControllerCanHijackHandler?
    /// 拦截点击事件的回调
    public var didHijackHandler: GLTabBarControllerDidHijackHandler?
    
    /// 设置选中的`viewController`
    public override var selectedViewController: UIViewController? {
        willSet {
            guard let newValue = newValue else {
                return
            }
            if !self.shouldNext {
                self.shouldNext = true
                return
            }
            self.shouldNext = false
            
            guard let tabBar = self.tabBar as? GLTabBar, let _ = tabBar.items, let index = self.viewControllers?.firstIndex(of: newValue) else {
                return
            }
            tabBar._select(newIndex: index)
        }
    }
    
    /// 设置选中的索引
    public override var selectedIndex: Int {
        willSet {
            if !self.shouldNext {
                self.shouldNext = true
                return
            }
            self.shouldNext = false
            guard let tabBar = self.tabBar as? GLTabBar, let _ = tabBar.items else {
                return
            }
            
            let count = tabBar.items?.count ?? 0
            if count <= 0 {
                return
            }
            var _selectedIndex = newValue
            if newValue < 0 {
                _selectedIndex = 0
            }
            if newValue >= count {
                _selectedIndex = count - 1
            }
            tabBar._select(newIndex: _selectedIndex)
        }
    }
    
    /// 设置`viewControllers`
    public override var viewControllers: [UIViewController]? {
        willSet {
            if let newValue = newValue, newValue.count > 5 {
                // 不能超过5个
                fatalError("The number of items count cannot exceed 5.")
            }
            super.viewControllers = newValue
        }
    }
    
    /// 设置`tabBar`的高度
    public var tabBarHeight: CGFloat? {
        didSet {
            if let _tabBarHeight = self.tabBarHeight, !_tabBarHeight.isLessThanOrEqualTo(.zero) {
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    fileprivate var shouldNext: Bool = true
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = GLTabBar()
        tabBar.shadowColor = .blue
        tabBar._tabBarelegate = self
        self.setValue(tabBar, forKey: "tabBar")
        
        tabBar.didSelectIndexClosure = { [weak self] (idx) in
            guard let self = self else { return }
            guard let vc = self.viewControllers?[idx] else {
                return
            }
            self.shouldNext = false
            self.selectedIndex = idx // 避免无限循环
            self.delegate?.tabBarController?(self, didSelect: vc)
        }
        
        
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let _tabBarHeight = self.tabBarHeight, !_tabBarHeight.isLessThanOrEqualTo(.zero) {
            var frame = self.tabBar.frame
            let beforeHeight: CGFloat = frame.size.height
            frame.size.height = _tabBarHeight
            frame.origin.y = frame.origin.y - (_tabBarHeight - beforeHeight)
            self.tabBar.frame = frame
        }
    }
    
    open override func value(forUndefinedKey key: String) -> Any? {
        return nil
    }
}

extension GLTabBarController: GLTabBarDelegate {
    internal func tabBar(_ tabBar: GLTabBar, shouldSelect item: UITabBarItem) -> Bool {
        if let idx = tabBar.items?.firstIndex(of: item), let vc = self.viewControllers?[idx] {
            return delegate?.tabBarController?(self, shouldSelect: vc) ?? true
        }
        return true
    }
    
    internal func tabBar(_ tabBar: GLTabBar, canHijack item: UITabBarItem) -> Bool {
        if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
            return self.canHijackHandler?(self, vc, idx) ?? false
        }
        return false
    }
    
    internal func tabBar(_ tabBar: GLTabBar, didHijack item: UITabBarItem) {
        if let idx = tabBar.items?.firstIndex(of: item), let vc = viewControllers?[idx] {
            self.didHijackHandler?(self, vc, idx)
        }
    }
}

