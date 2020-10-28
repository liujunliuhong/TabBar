//
//  CommonTabBarController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/27.
//

import UIKit

class _BadgeButton: UIButton {
    
}

class _TabBarItemContainerView: GLTabBarItemContainerView {
    override init() {
        super.init()
        self.normalTextColor = UIColor.orange // 未选中状态下文本颜色
        self.selectedTextColor = UIColor.red // 选中状态下文本颜色
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CommonTabBarController: GLTabBarController {
    
    lazy var quanquanItemContainerView: _TabBarItemContainerView = {
        let quanquanItemContainerView = _TabBarItemContainerView()
        quanquanItemContainerView.normalImage = UIImage(named: "tab_bar_quanquan_normal")
        quanquanItemContainerView.selectedImage = UIImage(named: "tab_bar_quanquan_selected")
        quanquanItemContainerView.title = "圈圈"
        return quanquanItemContainerView
    }()
    
    lazy var tantanItemContainerView: _TabBarItemContainerView = {
        let tantanItemContainerView = _TabBarItemContainerView()
        tantanItemContainerView.normalImage = UIImage(named: "tab_bar_tantan_normal")
        tantanItemContainerView.selectedImage = UIImage(named: "tab_bar_tantan_selected")
        tantanItemContainerView.title = "摊摊"
        return tantanItemContainerView
    }()
    
    lazy var messageeItemContainerView: _TabBarItemContainerView = {
        let messageeItemContainerView = _TabBarItemContainerView()
        messageeItemContainerView.normalImage = UIImage(named: "tab_bar_message_normal")
        messageeItemContainerView.selectedImage = UIImage(named: "tab_bar_message_selected")
        messageeItemContainerView.title = "消息"
        return messageeItemContainerView
    }()
    
    lazy var meItemContainerView: _TabBarItemContainerView = {
        let meItemContainerView = _TabBarItemContainerView()
        meItemContainerView.normalImage = UIImage(named: "tab_bar_me_normal")
        meItemContainerView.selectedImage = UIImage(named: "tab_bar_me_selected")
        meItemContainerView.title = "我的"
        return meItemContainerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let quanquanItem = GLTabBarItem(containerView: self.quanquanItemContainerView)
        let tantanItem = GLTabBarItem(containerView: self.tantanItemContainerView)
        let messageItem = GLTabBarItem(containerView: self.messageeItemContainerView)
        let meItem = GLTabBarItem(containerView: self.meItemContainerView)
        
        let vc1 = VC1()
        let vc2 = VC2()
        let vc3 = VC3()
        let vc4 = VC4()
        let navi1 = Navi(rootViewController: vc1)
        let navi2 = Navi(rootViewController: vc2)
        let navi3 = Navi(rootViewController: vc3)
        let navi4 = Navi(rootViewController: vc4)
        
        navi1.tabBarItem = quanquanItem
        navi2.tabBarItem = tantanItem
        navi3.tabBarItem = messageItem
        navi4.tabBarItem = meItem
        
        self.viewControllers = [navi1, navi2, navi3, navi4]
        self.selectedIndex = 1 // 默认选中第2个(如果不设置`selectedIndex`，默认选中第一个)
        
        //self.tabBar.isTranslucent = false
        //self.tabBar.barTintColor = UIColor.magenta
        
        if let tabBar = self.tabBar as? GLTabBar {
            tabBar.inset = UIEdgeInsets(top: 0, left: 0, bottom: UIDevice.gl_isNotchiPhone ? 34.0 : 0.0, right: 0)
        }
        
        //
        self.quanquanItemContainerView.defaultBadgeView.badgeValue = ""
        
        
        //
        self.tantanItemContainerView.defaultBadgeView.badgeValue = "20"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tantanItemContainerView.defaultBadgeView.badgeValue = "" // 修改角标为小圆点
            self.tantanItemContainerView.defaultBadgeView.dotSize = CGSize(width: 16.0, height: 16.0) // 修改角标小圆点尺寸
        }
        
        //
        self.messageeItemContainerView.defaultBadgeView.badgeValue = "66"
        self.messageeItemContainerView.defaultBadgeView.badgeColor = UIColor.purple // 修改角标背景颜色
        self.messageeItemContainerView.defaultBadgeView.badgeBorderWidth = 2.0 // 修改角标边框宽度
        self.messageeItemContainerView.defaultBadgeView.badgeBorderColor = UIColor.cyan // 修改角标边框颜色
        
        //
        self.meItemContainerView.defaultBadgeView.badgeValue = "99"
        self.meItemContainerView.defaultBadgeView.badgeHeight = 12.0 // 修改角标高度
        self.meItemContainerView.defaultBadgeView.badgeContentFont = UIFont.systemFont(ofSize: 10) // 修改角标字体
        self.meItemContainerView.defaultBadgeView.incrementWidth = 5.0 // 修改增量宽度
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.tabBarHeight = 250.0 // 延迟3秒改变TabBar高度
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let badgeButton = UIButton(type: .custom)
            badgeButton.setTitle("自定义badge", for: .normal)
            badgeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            badgeButton.backgroundColor = .purple
            self.quanquanItemContainerView.badgeView = badgeButton
            let beforeOffset = self.meItemContainerView.badgeOffset
            self.quanquanItemContainerView.badgeOffset = UIOffset(horizontal: beforeOffset.horizontal, vertical: -50)
        }
        
    }

}
