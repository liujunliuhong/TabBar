//
//  GLTabBar.swift
//  SwiftTool
//
//  Created by galaxy on 2020/10/27.
//  Copyright © 2020 yinhe. All rights reserved.
//

import UIKit

internal protocol GLTabBarDelegate: NSObjectProtocol {
    func tabBar(_ tabBar: GLTabBar, shouldSelect item: UITabBarItem) -> Bool
    func tabBar(_ tabBar: GLTabBar, canHijack item: UITabBarItem) -> Bool
    func tabBar(_ tabBar: GLTabBar, didHijack item: UITabBarItem)
}

public class GLTabBar: UITabBar {

    internal weak var _tabBarelegate: GLTabBarDelegate?
    internal var didSelectIndexClosure: ((Int)->())?
    
    private var beforSelectIndex: Int = -1
    private let baseTag: Int = 1000
    private var wrapViews: [_GLTabBarItemWrapView] = []
    
    /// 偏移量，影响所有item
    public var inset: UIEdgeInsets = .zero
    
    public var shadowColor: UIColor? {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
            self.updateShadowColor(view: self)
        }
    }
    
    public override var items: [UITabBarItem]? {
        didSet {
            self.updateDisplay()
        }
    }
    
    /// item之间的间距
    public override var itemSpacing: CGFloat {
        didSet {
            self.updateDisplay()
        }
    }
    
    public override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        self.updateDisplay()
    }
    
    public override func beginCustomizingItems(_ items: [UITabBarItem]) {
        super.beginCustomizingItems(items)
    }
    
    public override func endCustomizing(animated: Bool) -> Bool {
        return super.endCustomizing(animated: animated)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        //
        self.updateLayout()
    }
    
    public override func value(forUndefinedKey key: String) -> Any? {
        return nil
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var b = super.point(inside: point, with: event)
        if !b {
            for v in self.wrapViews {
                if v.point(inside: CGPoint(x: point.x - v.frame.origin.x, y: point.y - v.frame.origin.y), with: event) {
                    b = true
                }
            }
        }
        return b
    }
}

fileprivate extension GLTabBar {
    func updateShadowColor(view: UIView) {
        for (_, v) in view.subviews.enumerated() {
            if v.frame.height.isLessThanOrEqualTo(1.0) {
                v.backgroundColor = self.shadowColor
                if let c = self.shadowColor {
                    if c == UIColor.clear {
                        v.isHidden = true
                    } else {
                        v.isHidden = false
                    }
                } else {
                    v.isHidden = true
                }
            } else {
                if v.subviews.count > 0 {
                    self.updateShadowColor(view: v)
                }
            }
        }
    }
}

extension GLTabBar {
    private func updateDisplay() {
        //
        for v in self.wrapViews {
            v.removeFromSuperview()
        }
        self.wrapViews.removeAll()
        //
        guard let tabBarItems = self.items else {
            return
        }
        if tabBarItems.count <= 0 {
            return
        }
        //
        for (index, item) in tabBarItems.enumerated() {
            let wrapView = _GLTabBarItemWrapView(target: self)
            wrapView.tag = baseTag + index // 设置tag
            self.addSubview(wrapView)
            self.wrapViews.append(wrapView)
            if let item = item as? GLTabBarItem, let containerView = item.containerView {
                wrapView.addSubview(containerView)
            }
        }
        // 触发`layoutSubviews`
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    /// update layout
    internal func updateLayout() {
        //
        guard let tabBarItems = self.items else {
            return
        }
        if tabBarItems.count <= 0 {
            return
        }
        // Obtain the tabBarButton of the system. If the system is upgraded, and Apple changes the attributes or the hierarchy, the custom tabBar may fail.
        let originTabBarButtons = subviews.filter { (subView) -> Bool in
            if let cls = NSClassFromString("UITabBarButton") {
                return subView.isKind(of: cls)
            }
            return false
        }.sorted { (view1, view2) -> Bool in
            return view1.frame.origin.x < view2.frame.origin.x
        }
        //
        if originTabBarButtons.count != tabBarItems.count {
            return
        }
        if originTabBarButtons.count != self.wrapViews.count {
            return
        }
        //
        for (index, item) in tabBarItems.enumerated() {
            if let _ = item as? GLTabBarItem {
                originTabBarButtons[index].isHidden = true
                self.wrapViews[index].isHidden = false
            } else {
                originTabBarButtons[index].isHidden = false
                self.wrapViews[index].isHidden = true
            }
        }
        var x: CGFloat = self.inset.left
        let y: CGFloat = self.inset.top
        let width = self.bounds.size.width - self.inset.left - self.inset.right
        let eachHeight = self.bounds.size.height - self.inset.top - self.inset.bottom
        let eachWidth = width / CGFloat(self.wrapViews.count)
        let spacing = self.itemSpacing.isLessThanOrEqualTo(.zero) ? .zero : self.itemSpacing
        for v in self.wrapViews {
            v.frame = CGRect(x: x, y: y, width: eachWidth, height: eachHeight) // 最终将调用`GLTabBarItemContainerView`的`updateLayout`方法
            x += eachWidth
            x += spacing
        }
    }
}

extension GLTabBar {
    @objc internal func selectAction(_ sender: AnyObject?) {
        guard let v = sender as? _GLTabBarItemWrapView else {
            return
        }
        
        let newIndex = max(0, v.tag - baseTag) // 获取index
        self._select(newIndex: newIndex)
    }
    
    internal func _select(newIndex: Int) {
        guard let item = self.items?[newIndex] else {
            return
        }
        
        // 将要选中的回调
        if (self._tabBarelegate?.tabBar(self, shouldSelect: item) ?? true) == false {
            return
        }
        
        // 拦截选中事件
        if (self._tabBarelegate?.tabBar(self, canHijack: item) ?? false) == true {
            self._tabBarelegate?.tabBar(self, didHijack: item)
            return
        }
        
        if self.beforSelectIndex != newIndex { /* 当前选中的索引和之前选中的索引不同 */
            if self.beforSelectIndex >= 0 && self.beforSelectIndex <= self.items?.count ?? 0 {
                if let currentItem = self.items?[self.beforSelectIndex] as? GLTabBarItem {
                    currentItem.containerView?._deselect(animated: false, completion: nil) // 之前的item取消选中
                }
            }
            if let item = item as? GLTabBarItem {
                item.containerView?._select(animated: false, completion: nil) // 选中当前item
            }
        } else {
            if let item = item as? GLTabBarItem { /* 当前选中的索引和之前选中的索引相同，重新选中 */
                item.containerView?._reselect(animated: false, completion: nil) // 重新选中了之前的item
            }
        }
        // 重新赋值
        self.beforSelectIndex = newIndex
        
        // 回调出去，给tabBarVc使用
        self.didSelectIndexClosure?(newIndex)
    }
}
