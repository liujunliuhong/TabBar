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

/// item布局方式
public enum GLTabBarItemLayoutType {
    case system   // 根据系统item尺寸来设置
    case fillUp   // 填充满
}


private struct GLTabBarAssociatedKeys {
    static var backgroundViewKey = "com.galaxy.tabbar.backgroundView.key"
}

public class GLTabBar: UITabBar {

    internal weak var _tabBarelegate: GLTabBarDelegate?
    internal var didSelectIndexClosure: ((Int)->())?
    
    private var beforSelectIndex: Int = -1
    private let baseTag: Int = 1000
    private var wrapViews: [_GLTabBarItemWrapView] = []
    
    
    /// 偏移量，影响所有item。当`layoutType`为`fillUp`时有效
    public var inset: UIEdgeInsets = .zero {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    /// 分割线的颜色
    public var shadowColor: UIColor? {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    /// 是否隐藏分割线(如果设置为true，此时`shadowColor`属性无效)
    public var hideShadowImage: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    /// 设置items，由系统调用，开发者最好不要手动设置该属性
    public override var items: [UITabBarItem]? {
        didSet {
            self.updateDisplay()
        }
    }
    
    /// 布局方式
    public var layoutType: GLTabBarItemLayoutType = .system {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    /// 设置`tabBar`的增量高度
    public var incrementTabBarHeight: CGFloat? {
        didSet {
            if let _ = self.incrementTabBarHeight {
                self.superview?.setNeedsLayout()
                self.superview?.layoutIfNeeded()
                if let vc = _tabBarelegate as? UITabBarController {
                    for subVc in (vc.viewControllers ?? []) {
                        subVc.view.setNeedsLayout()
                        subVc.view.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    /// 背景`View`
    public var backgroundView: UIView? {
        didSet {
            let beforeBackgroundView = objc_getAssociatedObject(self, &GLTabBarAssociatedKeys.backgroundViewKey) as? UIView
            beforeBackgroundView?.removeFromSuperview()
            if let backgroundView = backgroundView {
                objc_setAssociatedObject(self, &GLTabBarAssociatedKeys.backgroundViewKey, backgroundView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                if self.wrapViews.count > 0 {
                    for (i, v) in self.subviews.enumerated() {
                        if v == self.wrapViews.first! {
                            self.insertSubview(backgroundView, at: i)
                            break
                        }
                    }
                } else {
                    self.addSubview(backgroundView)
                }
                
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
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
        //
        self.updateShadowColor(view: self)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        if let incrementTabBarHeight = incrementTabBarHeight {
            size.height += incrementTabBarHeight
        }
        return size
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

extension GLTabBar {
    private func updateShadowColor(view: UIView) {
        if self.hideShadowImage {
            for (_, v) in view.subviews.enumerated() {
                if NSStringFromClass(v.classForCoder) == "_UIBarBackgroundShadowView" {
                    v.isHidden = true
                    break
                } else {
                    self.updateShadowColor(view: v)
                }
            }
        } else {
            for (_, v) in view.subviews.enumerated() {
                if NSStringFromClass(v.classForCoder) == "_UIBarBackgroundShadowView" {
                    v.backgroundColor = self.shadowColor
                    break
                } else {
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
                item.tabBar = self
                containerView.tabBar = self
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
        let backgroundView = objc_getAssociatedObject(self, &GLTabBarAssociatedKeys.backgroundViewKey) as? UIView
        backgroundView?.frame = self.bounds
        //
        guard let tabBarItems = self.items else {
            return
        }
        if tabBarItems.count <= 0 {
            return
        }
        // Obtain the tabBarButton of the system. If the system is upgraded, and Apple changes the attributes or the hierarchy, the custom tabBar may fail.
        let originTabBarButtons = subviews.filter { (subView) -> Bool in
            if let cls = NSClassFromString("UITabBarButton") { // 获取系统button
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
        var buttons: [UIView] = [] /* 包含系统`tabBar`按钮和`_GLTabBarItemWrapView` */
        for (index, item) in tabBarItems.enumerated() {
            let wrapView = self.wrapViews[index]
            let sysButton = originTabBarButtons[index]
            if let _ = item as? GLTabBarItem {
                sysButton.isHidden = true
                wrapView.isHidden = false
                buttons.append(wrapView)
            } else {
                sysButton.isHidden = false
                wrapView.isHidden = true
                buttons.append(sysButton)
            }
        }
        if buttons.count != tabBarItems.count {
            return
        }
        //
        if self.layoutType == .fillUp { /* fillUp */
            var x: CGFloat = self.inset.left
            let y: CGFloat = self.inset.top
            
            var sumCustomWidth: CGFloat = .zero
            var customCount: Int = 0
            for (i, _) in buttons.enumerated() {
                if let item = tabBarItems[i] as? GLTabBarItem, let w = item.itemWidth, !w.isLessThanOrEqualTo(.zero) {
                    sumCustomWidth += w
                    customCount += 1
                }
            }
            var regularWidth: CGFloat = .zero // 标准宽度
            if customCount < buttons.count {
                regularWidth = (self.bounds.size.width - self.inset.left - self.inset.right - sumCustomWidth) / CGFloat(tabBarItems.count - customCount)
            }
            let regularHeight = self.bounds.size.height - self.inset.top - self.inset.bottom // 标准高度
            
            for (i, v) in buttons.enumerated() {
                if let item = tabBarItems[i] as? GLTabBarItem, let w = item.itemWidth, !w.isLessThanOrEqualTo(.zero) {
                    v.frame = CGRect(x: x, y: y, width: w, height: regularHeight)
                    x += w
                } else {
                    v.frame = CGRect(x: x, y: y, width: regularWidth, height: regularHeight)
                    x += regularWidth
                }
            }
        } else { /* system */
            for (index, w) in buttons.enumerated() {
                w.frame = originTabBarButtons[index].frame
            }
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
