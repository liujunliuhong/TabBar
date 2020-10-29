//
//  BadgeTabBarController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/29.
//

import UIKit

public class BadgeTabBarController: GLTabBarController {
    deinit {
        print("\(NSStringFromClass(self.classForCoder)) deinit")
    }
    
    private lazy var quanquanItemContainerView: GLTabBarItemContainerView = {
        let quanquanItemContainerView = GLTabBarItemContainerView()
        quanquanItemContainerView.normalImage = UIImage(named: "tab_bar_quanquan_normal")
        quanquanItemContainerView.selectedImage = UIImage(named: "tab_bar_quanquan_selected")
        quanquanItemContainerView.title = "圈圈"
        quanquanItemContainerView.normalTextColor = UIColor.orange // 未选中状态下文本颜色
        quanquanItemContainerView.selectedTextColor = UIColor.red // 选中状态下文本颜色
        return quanquanItemContainerView
    }()
    
    private lazy var tantanItemContainerView: GLTabBarItemContainerView = {
        let tantanItemContainerView = GLTabBarItemContainerView()
        tantanItemContainerView.normalImage = UIImage(named: "tab_bar_tantan_normal")
        tantanItemContainerView.selectedImage = UIImage(named: "tab_bar_tantan_selected")
        tantanItemContainerView.title = "摊摊"
        tantanItemContainerView.normalTextColor = UIColor.orange // 未选中状态下文本颜色
        tantanItemContainerView.selectedTextColor = UIColor.red // 选中状态下文本颜色
        return tantanItemContainerView
    }()
    
    private lazy var messageeItemContainerView: GLTabBarItemContainerView = {
        let messageeItemContainerView = GLTabBarItemContainerView()
        messageeItemContainerView.normalImage = UIImage(named: "tab_bar_message_normal")
        messageeItemContainerView.selectedImage = UIImage(named: "tab_bar_message_selected")
        messageeItemContainerView.title = "消息"
        messageeItemContainerView.normalTextColor = UIColor.orange // 未选中状态下文本颜色
        messageeItemContainerView.selectedTextColor = UIColor.red // 选中状态下文本颜色
        return messageeItemContainerView
    }()
    
    private lazy var meItemContainerView: GLTabBarItemContainerView = {
        let meItemContainerView = GLTabBarItemContainerView()
        meItemContainerView.normalImage = UIImage(named: "tab_bar_me_normal")
        meItemContainerView.selectedImage = UIImage(named: "tab_bar_me_selected")
        meItemContainerView.title = "我的"
        meItemContainerView.normalTextColor = UIColor.orange // 未选中状态下文本颜色
        meItemContainerView.selectedTextColor = UIColor.red // 选中状态下文本颜色
        return meItemContainerView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let quanquanItem = GLTabBarItem(containerView: self.quanquanItemContainerView)
        let tantanItem = GLTabBarItem(containerView: self.tantanItemContainerView)
        let messageItem = GLTabBarItem(containerView: self.messageeItemContainerView)
        let meItem = GLTabBarItem(containerView: self.meItemContainerView)
        
        let vc1 = BadgeViewController()
        let vc2 = BadgeViewController()
        let vc3 = BadgeViewController()
        let vc4 = BadgeViewController()
        let navi1 = Navi(rootViewController: vc1)
        let navi2 = Navi(rootViewController: vc2)
        let navi3 = Navi(rootViewController: vc3)
        let navi4 = Navi(rootViewController: vc4)
        
        navi1.tabBarItem = quanquanItem
        navi2.tabBarItem = tantanItem
        navi3.tabBarItem = messageItem
        navi4.tabBarItem = meItem
        
        self.viewControllers = [navi1, navi2, navi3, navi4]
        
        
        
        vc1.messageLabel.text = "普通badge，显示数字，延迟2秒后，显示小红点\n\n接着再延迟2秒，改变小圆点的大小，同时改变小圆点颜色\n\n接着再延迟2秒，给小圆点加边框"
        self.quanquanItemContainerView.defaultBadgeView.badgeValue = "20" // 角标为数字
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.quanquanItemContainerView.defaultBadgeView.badgeValue = "" // 小圆点
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.quanquanItemContainerView.defaultBadgeView.dotSize = CGSize(width: 16.0, height: 16.0)
                self.quanquanItemContainerView.defaultBadgeView.badgeColor = .purple // 角标背景颜色
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.quanquanItemContainerView.defaultBadgeView.badgeBorderWidth = 2.0 // 边框宽度
                    self.quanquanItemContainerView.defaultBadgeView.badgeBorderColor = UIColor.cyan // 边框颜色
                }
            }
        }
        
        
        
        
        
        vc2.messageLabel.text = "自定义角标"
        let badgeButton = UIButton(type: .custom)
        badgeButton.setTitle("自定义badge", for: .normal)
        badgeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        badgeButton.backgroundColor = .purple
        self.tantanItemContainerView.badgeView = badgeButton // 设置自定义badgeView
        let beforeOffset = self.tantanItemContainerView.badgeOffset
        self.tantanItemContainerView.badgeOffset = UIOffset(horizontal: beforeOffset.horizontal, vertical: -50) // 设置badgeView的偏移量
        
        
        
        
    }
}
